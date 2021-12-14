object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es E-mail'
  ClientHeight = 95
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 331
    Height = 95
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMain'
    Color = clWindow
    ParentBackground = False
    ShowCaption = False
    TabOrder = 0
    object lblSMTP: TLabel
      Left = 27
      Top = 25
      Width = 26
      Height = 13
      Caption = 'SMTP'
    end
    object lblPort: TLabel
      Left = 27
      Top = 54
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object edtSMTP: TEdit
      Left = 57
      Top = 22
      Width = 247
      Height = 21
      TabOrder = 0
      Text = 'edtSMTP'
    end
    object sePort: TSpinEdit
      Left = 57
      Top = 51
      Width = 67
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
end
