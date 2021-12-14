unit Model.EmailSettings;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms;

type
  TrSettingsEmail = class
  private
    FPort: Word;
    FPassword: string;
    FHost: string;
    FUserName: string;
  public
    property Host: string read FHost write FHost;
    property Port: Word read FPort write FPort;
    property UserName: string read FUserName write FUserName;
    property Password: string read FPassword write FPassword;
  end;

implementation

end.
