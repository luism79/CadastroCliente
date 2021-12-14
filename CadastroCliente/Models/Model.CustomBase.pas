unit Model.CustomBase;

interface

uses
  System.Classes, System.SysUtils;

type
  TrCustomBase = class
  private
    FOwner: TObject;
  public
    constructor Create(AOwner: TObject); virtual;
    property Owner: TObject read FOwner;
  end;
implementation

{ TrCustomBase }

constructor TrCustomBase.Create(AOwner: TObject);
begin
  FOwner := AOwner;
end;

end.
