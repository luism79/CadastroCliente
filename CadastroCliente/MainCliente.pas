unit MainCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Model.CustomCliente, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Model.EmailSettings, System.ImageList, Vcl.ImgList;

type
  TForm1 = class(TForm)
    grpCliente: TGroupBox;
    edtNome: TEdit;
    edtIdentidade: TEdit;
    edtEmail: TEdit;
    lblNome: TLabel;
    edtCPF: TMaskEdit;
    edtFone: TMaskEdit;
    lblIdentidade: TLabel;
    lblCPF: TLabel;
    lblFone: TLabel;
    lblEmail: TLabel;
    grpEndereco: TGroupBox;
    lblCEP: TLabel;
    edtCEP: TEdit;
    edtLogradouro: TEdit;
    edtComplemento: TEdit;
    edtBairro: TEdit;
    cbbEstado: TComboBox;
    edtNro: TEdit;
    lblNro: TLabel;
    lblLogradouro: TLabel;
    lblComplemento: TLabel;
    lblBairro: TLabel;
    lblEstado: TLabel;
    btnConsultarCEP: TSpeedButton;
    lblPais: TLabel;
    edtPais: TEdit;
    edtCidade: TEdit;
    lblCidade: TLabel;
    pnlMain: TPanel;
    btnSendEmail: TButton;
    btnConfig: TSpeedButton;
    pnlFooter: TPanel;
    ImageList1: TImageList;

    //*************************************************************************
    procedure edtOnlyNumberKeyPress(Sender: TObject; var Key: Char);
    //*************************************************************************
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConsultarCEPClick(Sender: TObject);
    procedure edtCEPKeyPress(Sender: TObject; var Key: Char);
    procedure btnSendEmailClick(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
    procedure edtCEPExit(Sender: TObject);
  private
    { Private declarations }
    FSettingsEmail: TrSettingsEmail;
    FCliente: TrCustomCliente;
    FFileXML: string;

    procedure _focusCltr(ACtrl: TWinControl);
    procedure ApplyCliente;
    procedure CloseFormSetting(ASender: TObject);
    procedure CreateXML;
    function GetFileName: string;
    procedure LoadCliente;
    procedure LoadEndereco;
    procedure LoadSettings;
    procedure SaveSettings;
    procedure SettingsCEP(ASender: TObject);
    procedure SendEmail;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Service.LocateCep, Service.ExportXML, Win.SendEMail, Win.Settings,
  System.IniFiles;

const
  CS_GENERAL = 'General';
  CS_HOST = 'Host';
  CS_PORT = 'Port';

{$R *.dfm}

procedure TForm1.ApplyCliente;
begin
  FCliente.Nome       := edtNome.Text;
  FCliente.Identidade := edtIdentidade.Text;
  FCliente.CPF        := edtCPF.Text;
  FCliente.Telefone   := edtFone.Text;
  FCliente.Email      := edtEmail.Text;

  FCliente.Endereco.Cep         := edtCEP.Text;
  FCliente.Endereco.Logradouro  := edtLogradouro.Text;
  FCliente.Endereco.Numero      := StrToIntDef(edtNro.Text, 0);
  FCliente.Endereco.Complemento := edtComplemento.Text;
  FCliente.Endereco.Bairro      := edtBairro.Text;
  FCliente.Endereco.Cidade      := edtCidade.Text;
  FCliente.Endereco.Estado      := cbbEstado.Text;
  FCliente.Endereco.Pais        := edtPais.Text;
end;

procedure TForm1.btnConfigClick(Sender: TObject);
var
  fSettings: TfrmSettings;
begin
  fSettings := TfrmSettings.Create(Self, FSettingsEmail);
  try
    fSettings.OnCloseForm := CloseFormSetting;
    fSettings.ShowModal;
  finally
    fSettings.Free;
  end;
end;

procedure TForm1.btnConsultarCEPClick(Sender: TObject);
var
  CEP: TrConsultarCEP;
begin
  CEP := TrConsultarCEP.Create(FCliente.Endereco);
  CEP.OnAfterExecute := SettingsCEP;
  try
    FCliente.Endereco.Cep := edtCEP.Text;
    try
      CEP.Execute(edtCEP.Text);
    except
      on E: Exception do
        Application.MessageBox(PWChar(E.Message),
          'Falha na Consulta', MB_ICONERROR);
    end;
  finally
    CEP.Free;
  end;
end;

procedure TForm1.btnSendEmailClick(Sender: TObject);
begin
  ApplyCliente;
  CreateXML;
  SendEmail;
end;

procedure TForm1.CloseFormSetting(ASender: TObject);
begin
  SaveSettings;
end;

procedure TForm1.CreateXML;

  function FileNameXML: string;
  begin
    Result := Format('%s-%s', [FCliente.CPF, FCliente.Nome]);
  end;

var
  xml: TrExportXML;
begin
  FFileXML := '';
  xml      := TrExportXML.Create(FCliente, FileNameXML);
  try
    try
      xml.Execute;
      FFileXML := xml.FileName;
    except
      on E: Exception do
        Application.MessageBox(PWChar(E.Message),
          'Falha na geração XML', MB_ICONERROR);
    end;
  finally
    xml.Free;
  end;
end;

procedure TForm1.edtCEPExit(Sender: TObject);
begin
  if edtCEP.Text <> EmptyStr then
    btnConsultarCEPClick(Sender);
end;

procedure TForm1.edtCEPKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    btnConsultarCEPClick(Sender);
  end;
  edtOnlyNumberKeyPress(Sender, Key);
end;

procedure TForm1.edtOnlyNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key := #0;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FCliente);
  FreeAndNil(FSettingsEmail);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCliente       := TrCustomCliente.Create(Self);
  FSettingsEmail := TrSettingsEmail.Create;
  LoadCliente;
  LoadSettings;
end;

function TForm1.GetFileName: string;
var
  lPath: string;
  lFile: string;
begin
  lFile  := ExtractFileName(Application.ExeName);
  lPath  := ExtractFileDir(Application.ExeName);
  lFile  := StringReplace(lFile, '.exe', '.ini', [rfReplaceAll, rfIgnoreCase]);
  Result := Format('%s\%s', [lPath, lFile]);
end;

procedure TForm1.LoadCliente;
begin
  edtNome.Text        := FCliente.Nome;
  edtIdentidade.Text  := FCliente.Identidade;
  edtCPF.Text         := FCliente.CPF;
  edtFone.Text        := FCliente.Telefone;
  edtEmail.Text       := FCliente.Email;
  LoadEndereco;
end;


procedure TForm1.LoadEndereco;
begin
  edtCEP.Text         := FCliente.Endereco.Cep;
  edtLogradouro.Text  := FCliente.Endereco.Logradouro;

  if FCliente.Endereco.Numero = 0 then
    edtNro.Text := ''
  else edtNro.Text := IntToStr(FCliente.Endereco.Numero);

  edtComplemento.Text := FCliente.Endereco.Complemento;
  edtBairro.Text      := FCliente.Endereco.Bairro;
  cbbEstado.ItemIndex := cbbEstado.Items.IndexOf(FCliente.Endereco.Estado);
  edtCidade.Text      := FCliente.Endereco.Cidade;
  edtPais.Text        := FCliente.Endereco.Pais;
end;

procedure TForm1.LoadSettings;
var
  lFileIni: TIniFile;
begin
  lFileIni := TIniFile.Create(GetFileName);
  try
    FSettingsEmail.Host := lFileIni.ReadString(CS_GENERAL, CS_HOST, '');
    FSettingsEmail.Port := lFileIni.ReadInteger(CS_GENERAL, CS_PORT, 0);
  finally
    lFileIni.Free;
  end;
end;

procedure TForm1.SaveSettings;
var
  lFileIni: TIniFile;
begin
  lFileIni := TIniFile.Create(GetFileName);
  try
    lFileIni.WriteString(CS_GENERAL, CS_HOST, FSettingsEmail.Host);
    lFileIni.WriteInteger(CS_GENERAL, CS_PORT, FSettingsEmail.Port);
  finally
    lFileIni.Free;
  end;
end;

procedure TForm1.SendEmail;

  function ClienteText: TStrings;
  begin
    Result := TStringList.Create;
    Result.Add('Dados do Cadastro');
    Result.Add(Format('    Nome: %s', [FCliente.Nome]));
    Result.Add(Format('    Identidade: %s', [FCliente.Identidade]));
    Result.Add(Format('    CPF: %s', [FCliente.CPF]));
    Result.Add(Format('    Telefone: %s', [FCliente.Telefone]));
    Result.Add(Format('    E-mail: %s', [FCliente.Email]));
    Result.Add('');
    Result.Add('    Endereço');
    Result.Add(Format('        CEP: %s', [FCliente.Endereco.Cep]));
    Result.Add(Format('        Logradouro: %s', [FCliente.Endereco.Logradouro]));
    Result.Add(Format('        Número: %d', [FCliente.Endereco.Numero]));
    Result.Add(Format('        Complemento: %s', [FCliente.Endereco.Complemento]));
    Result.Add(Format('        Bairro: %s', [FCliente.Endereco.Bairro]));
    Result.Add(Format('        Cidade: %s', [FCliente.Endereco.Cidade]));
    Result.Add(Format('        Estado: %s', [FCliente.Endereco.Estado]));
    Result.Add(Format('        Páis: %s', [FCliente.Endereco.Pais]));
  end;

var
  lSend: TfrmSendEmail;
begin
  lSend := TfrmSendEmail.Create(Self, FSettingsEmail);
  try
    lSend.Text    := ClienteText;
    lSend.FileXML := FFileXML;
    lSend.ShowModal;
  finally
    lSend.Free;
  end;
end;

procedure TForm1.SettingsCEP(ASender: TObject);
begin
  if ASender is TrConsultarCEP then
  begin
    FCliente.Endereco := (ASender as TrConsultarCEP).Endereco;
    if (ASender as TrConsultarCEP).IsEmpty then
      _focusCltr(edtCEP);
  end;
  LoadEndereco;
end;

procedure TForm1._focusCltr(ACtrl: TWinControl);
begin
  if ACtrl.CanFocus then
    ACtrl.SetFocus;

  TEdit(ACtrl).SelectAll;
end;

end.
