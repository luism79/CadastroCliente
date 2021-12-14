unit Win.SendEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Model.EmailSettings,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls;

type
  TfrmSendEmail = class(TForm)
    pnlMain: TPanel;
    pnlFooter: TPanel;
    lblFrom: TLabel;
    edtFrom: TEdit;
    btnSend: TBitBtn;
    btnDiscard: TBitBtn;
    lblTo: TLabel;
    edtTo: TRichEdit;
    lblSubject: TLabel;
    edtSubject: TEdit;
    edtText: TRichEdit;
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
    FSettingsEmail: TrSettingsEmail;
    FFileXML: string;
    function GetText: TStrings;
    procedure SetText(const Value: TStrings);
    procedure ResetData;
    procedure InternalSend;
    function Authenticate: boolean;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
     ASettings: TrSettingsEmail); reintroduce;

     property Text: TStrings read GetText write SetText;
     property FileXML: string read FFileXML write FFileXML;
  end;

var
  frmSendEmail: TfrmSendEmail;

implementation

{$R *.dfm}

uses Service.SendEMail;

{ TfrmSendEmail }

function TfrmSendEmail.Authenticate: boolean;
var
  lValue: string;
begin
  FSettingsEmail.UserName := edtFrom.Text;
  Result := InputQuery('Autenticação', #31'Senha', lValue);
  if Result then
    FSettingsEmail.PassWord := lValue;
end;

procedure TfrmSendEmail.btnSendClick(Sender: TObject);
begin
  if Authenticate then
  begin
    InternalSend;
    ModalResult := mrOk;
  end;
end;

constructor TfrmSendEmail.Create(AOwner: TComponent;
  ASettings: TrSettingsEmail);
begin
  inherited Create(AOwner);
  ResetData;
  FSettingsEmail := ASettings;
end;

function TfrmSendEmail.GetText: TStrings;
begin
  Result := edtText.Lines;
end;

procedure TfrmSendEmail.InternalSend;
var
  email: TrSendEmail;
begin
  email := TrSendEmail.Create(Self, FSettingsEmail);
  try
    try
      email.Subject      := edtSubject.Text;
      email.EmailAddress := edtTo.Text;
      email.Attachment   := FFileXML;
      email.Text.Assign(edtText.Lines);
      email.Execute;

      Application.MessageBox('E-mail enviado com sucesso!',
        'Aviso', MB_ICONEXCLAMATION);
    except
      on E: Exception do
        Application.MessageBox(PWChar(E.Message),
          'Falha ao enviar o e-mail', MB_ICONEXCLAMATION);
    end;
  finally
    email.Free;
  end;
end;

procedure TfrmSendEmail.ResetData;
begin
  edtFrom.Text    := EmptyStr;
  edtTo.Text      := EmptyStr;
  edtSubject.Text := EmptyStr;
  edtText.Lines.Clear;
end;

procedure TfrmSendEmail.SetText(const Value: TStrings);
begin
  edtText.Lines.Clear;
  edtText.Lines.Assign(Value);
end;

end.
