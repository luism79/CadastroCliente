unit ExportXML;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms, System.Rtti,
  System.IOUtils, CustomBase;

type
  TrExportXML = class(TrCustomBase)
  private
    FTextXML: TStrings;
    FFileName: string;

    procedure AddClassValues(AClass: TrCustomBase;
      ACharSpace: string);
    procedure InternalExecute(AClass: TrCustomBase);
    procedure ResetTextXML;
    procedure SaveXML;
    procedure SetFileName(const Value: string);
  public
    constructor Create(AOwner: TObject); overload; override;
    constructor Create(AOwner: TObject; AFileName: string); reintroduce; overload;
    destructor Destroy; override;

    procedure Execute;

    property FileName: string read FFileName;
  end;

implementation

{ TpExportXML }

constructor TrExportXML.Create(AOwner: TObject);
begin
  inherited Create(AOwner);

  FTextXML := TStringList.Create;
  SetFileName(Owner.ClassName);
end;

procedure TrExportXML.AddClassValues(AClass: TrCustomBase; ACharSpace: string);
var
  rContext: TRttiContext;
  rType: TRttiType;
  rProperty: TRttiProperty;
  sPropName: string;
  sPropValue: string;
  sRoot: string;
  obj: TObject;

  function IsObject: boolean;
  begin
    try
      Result := rProperty.GetValue(AClass).AsObject <> nil;
    except
      Result := false;
    end;
  end;

  function GetCustomObject: TObject;
  begin
    try
      Result := rProperty.GetValue(AClass).AsType<TObject>;
      if Result = Owner then
        Result := nil;
    except
      Result := nil;
    end;
  end;

begin
  rContext := TRttiContext.Create;
  try
    rType := rContext.GetType(AClass.ClassType);

    sRoot := StringReplace(AClass.ClassName, 'TrCustom', '', [rfIgnoreCase, rfReplaceAll]);
    FTextXML.Add(Format('%s<%s>', [ACharSpace, sRoot]));
    for rProperty in rType.GetProperties do
    begin
      sPropName  := rProperty.Name;
      sPropValue := Trim(rProperty.GetValue(AClass).ToString);
      if IsObject then
        obj := GetCustomObject
      else
      begin
        obj := nil;
        FTextXML.Add(Format('%s  <%s>%s</%s>', [ACharSpace, sPropName, sPropValue, sPropName]));
      end;

      if Assigned(obj) and
         (obj is TrCustomBase) then
        AddClassValues(TrCustomBase(obj), '  ');
    end;
    FTextXML.Add(Format('%s</%s>', [ACharSpace, sRoot]));
  finally
    rContext.Free;
  end;
end;

constructor TrExportXML.Create(AOwner: TObject;
  AFileName: string);
begin
  Create(AOwner);
  SetFileName(AFileName);
end;

destructor TrExportXML.Destroy;
begin
  FreeAndNil(FTextXML);
  inherited;
end;

procedure TrExportXML.Execute;
begin
  ResetTextXML;
  if Assigned(Owner) then
    InternalExecute(TrCustomBase(Owner));
end;

procedure TrExportXML.InternalExecute(AClass: TrCustomBase);
begin
  FTextXML.Add('<?xml version="1.0" encoding="UTF-8"?>');
  AddClassValues(AClass, '');
  SaveXML;
end;

procedure TrExportXML.ResetTextXML;
begin
  FTextXML.Clear;
end;

procedure TrExportXML.SaveXML;
var
  sDir: string;
begin
  if FFileName = '' then
    raise Exception.Create('Não foi possível criar o arquivo xml!');

  sDir := ExtractFilePath(FFileName);
   if not TDirectory.Exists(sDir) then
    TDirectory.CreateDirectory(sDir);

  FTextXML.SaveToFile(FFileName);
end;

procedure TrExportXML.SetFileName(const Value: string);
var
  sDir: string;
begin
  sDir      := ExtractFileDir(Application.ExeName);
  FFileName := Format('%s\XML\%s.xml', [sDir, StringReplace(Value, 'TrCustom', '', [rfIgnoreCase, rfReplaceAll])]);
end;

end.
