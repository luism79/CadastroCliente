program pjCliente;

uses
  Vcl.Forms,
  MainCliente in 'MainCliente.pas' {Form1},
  ConsultarCep in 'Services\ConsultarCep.pas',
  CustomBase in 'Models\CustomBase.pas',
  CustomCliente in 'Models\CustomCliente.pas',
  CustomEndereco in 'Models\CustomEndereco.pas',
  ExportXML in 'Services\ExportXML.pas',
  Service.SendEMail in 'Services\Service.SendEMail.pas',
  Win.Settings in 'Window\Settings\Win.Settings.pas' {frmSettings},
  Controller.EmailSettings in 'Controller\Controller.EmailSettings.pas',
  Win.SendEmail in 'Window\Win.SendEmail.pas' {frmSendEmail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
