unit Win.Settings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, Model.EmailSettings;

type
  TfrmSettings = class(TForm)
    pnlMain: TPanel;
    lblSMTP: TLabel;
    edtSMTP: TEdit;
    lblPort: TLabel;
    sePort: TSpinEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FSettings: TrSettingsEmail;
    FOnCloseForm: TNotifyEvent;

    procedure LoadSettings;
    procedure SaveSettings;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent;
     ASettings: TrSettingsEmail); reintroduce;

    property OnCloseForm: TNotifyEvent read FOnCloseForm write FOnCloseForm;
  end;

var
  frmSettings: TfrmSettings;

implementation

{$R *.dfm}

{ TfrmSettings }

constructor TfrmSettings.Create(AOwner: TComponent; ASettings: TrSettingsEmail);
begin
  inherited Create(AOwner);
  FSettings := ASettings;
  LoadSettings;
end;

procedure TfrmSettings.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveSettings;
  if Assigned(FOnCloseForm) then
    FOnCloseForm(Self);
  Action := caFree;
end;

procedure TfrmSettings.LoadSettings;
begin
  edtSMTP.Text := FSettings.Host;
  sePort.Value := FSettings.Port;
end;

procedure TfrmSettings.SaveSettings;
begin
  FSettings.Host := edtSMTP.Text;
  FSettings.Port := sePort.Value;
end;

end.
