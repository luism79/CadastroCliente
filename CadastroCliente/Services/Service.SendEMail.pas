unit Service.SendEMail;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms, CustomBase, IdSMTP, IdMessage,
  IdExplicitTLSClientServerBase, IdSSLOpenSSL, IdAttachmentFile,
  Controller.EmailSettings;

type
  TrSendEmail = class(TrCustomBase)
  private
    FSettings: TrSettingsEmail;
    FIdSMTP: TIdSMTP;
    FMessage: TIdMessage;
    FAuthSSL: TIdSSLIOHandlerSocketOpenSSL;
    FAttachment: string;

    function GetHost: string;
    procedure SetHost(const Value: string);
    function GetPort: Word;
    procedure SetPort(const Value: Word);
    function GetUserName: string;
    procedure SetUserName(const Value: string);
    function GetPassWord: string;
    procedure SetPassWord(const Value: string);
    function GetSubject: string;
    procedure SetSubject(const Value: string);
    function GetFromAddress: string;
    procedure SetFromAddress(const Value: string);
    function GetText: TStrings;
    procedure SetText(const Value: TStrings);
    function GetEmailAddress: string;
    procedure SetEmailAddress(const Value: string);
  public
    constructor Create(AOwner: TObject;
      ASettings: TrSettingsEmail); reintroduce;
    destructor Destroy; override;

    procedure Execute;

    property Setings: TrSettingsEmail read FSettings;
    property Subject: string read GetSubject write SetSubject;
    property FromAddress: string read GetFromAddress write SetFromAddress;
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
  FSettings := ASettings;
  
  FAuthSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  FAuthSSL.SSLOptions.Method := sslvTLSv1;
  FAuthSSL.SSLOptions.Mode   := sslmUnassigned;

  FIdSMTP  := TIdSMTP.Create(nil);
  FIdSMTP.IOHandler := FAuthSSL;
  FIdSMTP.UseTLS    := utUseRequireTLS;
  FIdSMTP.AuthType  := satDefault;

  FMessage := TIdMessage.Create(nil);
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

function TrSendEmail.GetFromAddress: string;
begin
  Result := FMessage.From.Address;
end;

function TrSendEmail.GetHost: string;
begin
  Result := FIdSMTP.Host;
end;

function TrSendEmail.GetPassWord: string;
begin
  Result := FIdSMTP.Password;
end;

function TrSendEmail.GetPort: Word;
begin
  Result := FIdSMTP.Port;
end;

function TrSendEmail.GetSubject: string;
begin
  Result := FMessage.Subject;
end;

function TrSendEmail.GetText: TStrings;
begin
  Result := FMessage.Body;
end;

function TrSendEmail.GetUserName: string;
begin
  Result := FIdSMTP.Username;
end;

procedure TrSendEmail.SetEmailAddress(const Value: string);
begin
  FMessage.Recipients.EMailAddresses := Value;
end;

procedure TrSendEmail.SetFromAddress(const Value: string);
begin
  FMessage.From.Address := Value;
end;

procedure TrSendEmail.SetHost(const Value: string);
begin
  FIdSMTP.Host := Value;
end;

procedure TrSendEmail.SetPassWord(const Value: string);
begin
  FIdSMTP.Password := Value;
end;

procedure TrSendEmail.SetPort(const Value: Word);
begin
  FIdSMTP.Port := Value;
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

procedure TrSendEmail.SetUserName(const Value: string);
begin
  FIdSMTP.Username := Value;
end;

end.
