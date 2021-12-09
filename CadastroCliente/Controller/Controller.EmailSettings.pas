unit Controller.EmailSettings;

interface

uses
  System.Classes, System.SysUtils, Vcl.Forms;

type
  TrSettingsEmail = class
  private
    FPort: Word;
    FPassWord: string;
    FHost: string;
    FUserName: string;
  public
    property Host: string read FHost write FHost;
    property Port: Word read FPort write FPort;
    property UserName: string read FUserName write FUserName;
    property PassWord: string read FPassWord write FPassWord;
  end;

implementation

end.
