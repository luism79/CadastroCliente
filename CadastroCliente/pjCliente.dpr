program pjCliente;

uses
  Vcl.Forms,
  MainCliente in 'MainCliente.pas' {Form1},
  Service.LocateCep in 'Services\Service.LocateCep.pas',
  Model.CustomBase in 'Models\Model.CustomBase.pas',
  Model.CustomCliente in 'Models\Model.CustomCliente.pas',
  Model.CustomEndereco in 'Models\Model.CustomEndereco.pas',
  Service.ExportXML in 'Services\Service.ExportXML.pas',
  Service.SendEMail in 'Services\Service.SendEMail.pas',
  Win.Settings in 'Window\Settings\Win.Settings.pas' {frmSettings},
  Model.EmailSettings in 'Models\Model.EmailSettings.pas',
  Win.SendEmail in 'Window\Win.SendEmail.pas' {frmSendEmail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
