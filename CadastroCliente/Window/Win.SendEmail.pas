unit Win.SendEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Controller.EmailSettings,
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
    lblAttach: TLabel;
    edtText: TRichEdit;
    ButtonedEdit1: TButtonedEdit;
    procedure btnSendClick(Sender: TObject);
  private
    { Private declarations }
    FSettingsEmail: TrSettingsEmail;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
     ASettings: TrSettingsEmail); reintroduce;
  end;

var
  frmSendEmail: TfrmSendEmail;

implementation

{$R *.dfm}

{ TfrmSendEmail }

procedure TfrmSendEmail.btnSendClick(Sender: TObject);
//var
//  email: TrSendEmail;
begin
//  email := TrSendEmail.Create(Self, FSettingsEmail);
//  try
//    try
//      email.FromAddress  := '';
//      email.Subject      := 'Cadastro Cliente';
//      email.EmailAddress := '';
//      email.Text         := ClienteText;
//      email.Attachment   := FFileXML;
//      email.Execute;
//
//      Application.MessageBox('E-mail enviado com sucesso!',
//        'Aviso', MB_ICONEXCLAMATION);
//    except
//      on E: Exception do
//        Application.MessageBox(PWChar(E.Message),
//          'Falha ao enviar o e-mail', MB_ICONEXCLAMATION);
//    end;
//  finally
//    email.Free;
//  end;
end;

constructor TfrmSendEmail.Create(AOwner: TComponent;
  ASettings: TrSettingsEmail);
begin
  inherited Create(AOwner);
  FSettingsEmail := ASettings;
end;

end.
