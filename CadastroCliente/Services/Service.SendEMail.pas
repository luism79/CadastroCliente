unit Service.SendEMail;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms, Model.CustomBase, IdSMTP, IdMessage,
  IdExplicitTLSClientServerBase, IdSSLOpenSSL, IdAttachmentFile,
  Model.EmailSettings;

type
  TrSendEmail = class(TrCustomBase)
  private
    FSettings: TrSettingsEmail;
    FIdSMTP: TIdSMTP;
    FMessage: TIdMessage;
    FAuthSSL: TIdSSLIOHandlerSocketOpenSSL;
    FAttachment: string;

    function GetSubject: string;
    procedure SetSubject(const Value: string);
    function GetText: TStrings;
    procedure SetText(const Value: TStrings);
    function GetEmailAddress: string;
    procedure SetEmailAddress(const Value: string);
    procedure SetSettings(ASettings: TrSettingsEmail);
  public
    constructor Create(AOwner: TObject;
      ASettings: TrSettingsEmail); reintroduce;
    destructor Destroy; override;

    procedure Execute;

    property Setings: TrSettingsEmail read FSettings;
    property Subject: string read GetSubject write SetSubject;
    property EmailAddress: string read GetEmailAddress write SetEmailAddress;
    property Text: TStrings read GetText write SetText;
    property Attachment: string read FAttachment write FAttachment;
  end;

implementation

{ TrSendEmail }

constructor TrSendEmail.Create(AOwner: TObject;
  ASettings: TrSettingsEmail);
begin
  inherited Create(AOwner);
  
  FAuthSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FAuthSSL.SSLOptions.Method := sslvTLSv1;
  FAuthSSL.SSLOptions.Mode   := sslmUnassigned;

  FIdSMTP  := TIdSMTP.Create(nil);
  FIdSMTP.IOHandler := FAuthSSL;
  FIdSMTP.UseTLS    := utUseRequireTLS;
  FIdSMTP.AuthType  := satDefault;

  FMessage := TIdMessage.Create(nil);

  SetSettings(ASettings);
end;

destructor TrSendEmail.Destroy;
begin
  FreeAndNil(FAuthSSL);
  FreeAndNil(FMessage);
  FreeAndNil(FIdSMTP);
  inherited;
end;

procedure TrSendEmail.Execute;
begin
  FIdSMTP.Connect;
  try
    if FileExists(FAttachment) then
      TIdAttachmentFile.Create(FMessage.MessageParts, FAttachment);
    try
      FIdSMTP.Authenticate;
      FIdSMTP.Send(FMessage);
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;

  finally
    FIdSMTP.Disconnect;
  end;
end;

function TrSendEmail.GetEmailAddress: string;
begin
  Result := FMessage.Recipients.EMailAddresses;
end;

function TrSendEmail.GetSubject: string;
begin
  Result := FMessage.Subject;
end;

function TrSendEmail.GetText: TStrings;
begin
  Result := FMessage.Body;
end;

procedure TrSendEmail.SetEmailAddress(const Value: string);
begin
  FMessage.Recipients.EMailAddresses := Value;
end;

procedure TrSendEmail.SetSettings(ASettings: TrSettingsEmail);
begin
  FSettings        := ASettings;
  FIdSMTP.Host     := FSettings.Host;
  FIdSMTP.Port     := FSettings.Port;
  FIdSMTP.Username := FSettings.UserName;
  FIdSMTP.Password := FSettings.Password;

  FMessage.From.Address := FSettings.UserName;
  FMessage.From.Name    := FSettings.UserName;
end;

procedure TrSendEmail.SetSubject(const Value: string);
begin
  FMessage.Subject := Value;
end;

procedure TrSendEmail.SetText(const Value: TStrings);
begin
  FMessage.Body.Clear;
  FMessage.Body.AddStrings(Value);
end;

end.
