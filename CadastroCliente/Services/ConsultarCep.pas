unit ConsultarCep;

interface

uses
  System.Classes, System.SysUtils, REST.Client, System.JSON, CustomBase,
  CustomEndereco;

type
  TrConsultarCEP = class(TrCustomBase)
  private
    FRestClient: TRESTClient;
    FRestRequest: TRESTRequest;
    FRestResponse: TRESTResponse;
    FOnAfterExecute: TNotifyEvent;

    procedure CreateRestClient;
    procedure CreateRestRequest;
    procedure CreateRestResponse;
    function GetValue: TJsonValue;
    function GetEmpty: Boolean;
    function GetEndereco: TrCustomEndereco;
    procedure LoadCEP(ACEP: string);
  public
    constructor Create(AEndereco: TObject); override;
    destructor Destroy; override;

    procedure Execute(const ACEP: string);

    property OnAfterExecute: TNotifyEvent read FOnAfterExecute write FOnAfterExecute;
    property JsonValue: TJsonValue read GetValue;
    property Endereco: TrCustomEndereco read GetEndereco;
    property IsEmpty: Boolean read GetEmpty;
  end;

implementation

{ TpConsultarCEP }

constructor TrConsultarCEP.Create(AEndereco: TObject);
begin
  inherited Create(AEndereco);

  CreateRestClient;
  CreateRestResponse;
  CreateRestRequest;
end;

procedure TrConsultarCEP.CreateRestClient;
begin
  FRestClient := TRESTClient.Create(nil);
  FRestClient.Accept        := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  FRestClient.AcceptCharset := 'utf-8, *;q=0.8';
  FRestClient.BaseURL       := 'http://viacep.com.br/ws';
end;

procedure TrConsultarCEP.CreateRestRequest;
begin
  FRestRequest := TRESTRequest.Create(nil);
  FRestRequest.Accept        := FRestClient.Accept;
  FRestRequest.AcceptCharset := FRestClient.AcceptCharset;
  FRestRequest.Client        := FRestClient;
  FRestRequest.Response      := FRestResponse;
end;

procedure TrConsultarCEP.CreateRestResponse;
begin
  FRestResponse := TRESTResponse.Create(nil);
  FRestResponse.ContentType := 'application/json';
end;

destructor TrConsultarCEP.Destroy;
begin
  FreeAndNil(FRestRequest);
  FreeAndNil(FRestResponse);
  FreeAndNil(FRestClient);
  inherited;
end;

procedure TrConsultarCEP.Execute(const ACEP: string);
begin
  if ACEP.IsEmpty then
    raise Exception.Create('Informe o CEP!')
  else if Length(ACEP) <> 8 then
    raise Exception.Create('O CEP digitado é inválido!');

  FRestRequest.Resource := Format('%s/json', [ACEP]);
  FRestRequest.Execute;
  LoadCEP(ACEP);

  if Assigned(FOnAfterExecute) then
    FOnAfterExecute(Self);
end;

function TrConsultarCEP.GetEmpty: Boolean;
begin
  Result := FRestResponse.Content.IsEmpty or
            (FRestResponse.Content.IndexOf('erro') <> -1);
end;

function TrConsultarCEP.GetEndereco: TrCustomEndereco;
begin
  if Owner is TrCustomEndereco then
    Result := TrCustomEndereco(Owner)
  else Result := nil;
end;

function TrConsultarCEP.GetValue: TJsonValue;
begin
  Result := FRestResponse.JSONValue;
end;

procedure TrConsultarCEP.LoadCEP(ACEP: string);

  function GetValueString(AFieldName: string): string;
  begin
    try
      Result := FRestResponse.JSONValue.GetValue<string>(AFieldName);
    except
      Result := '';
    end;
  end;

begin
  if GetEndereco <> nil then
  begin
    GetEndereco.Cep := ACEP;

    GetEndereco.Logradouro := GetValueString('logradouro');
    GetEndereco.Bairro     := GetValueString('bairro');
    GetEndereco.Estado     := GetValueString('uf');
    GetEndereco.Cidade     := GetValueString('localidade');
  end;
end;

end.
