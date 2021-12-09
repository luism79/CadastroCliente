object frmSendEmail: TfrmSendEmail
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'Enviar E-mail'
  ClientHeight = 284
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 468
    Height = 239
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlMain'
    Color = clWhite
    Ctl3D = True
    ParentBackground = False
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      468
      239)
    object lblFrom: TLabel
      Left = 38
      Top = 20
      Width = 13
      Height = 13
      Caption = 'De'
    end
    object lblTo: TLabel
      Left = 29
      Top = 49
      Width = 22
      Height = 13
      Caption = 'Para'
    end
    object lblSubject: TLabel
      Left = 12
      Top = 78
      Width = 39
      Height = 13
      Caption = 'Assunto'
    end
    object lblAttach: TLabel
      Left = 18
      Top = 108
      Width = 35
      Height = 13
      Caption = 'Anexar'
    end
    object edtFrom: TEdit
      Left = 55
      Top = 17
      Width = 396
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = 'edtFrom'
    end
    object edtTo: TRichEdit
      Left = 55
      Top = 46
      Width = 396
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'mmTo')
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 1
      Zoom = 100
    end
    object edtSubject: TEdit
      Left = 55
      Top = 75
      Width = 396
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
      Text = 'edtSubject'
    end
    object edtText: TRichEdit
      Left = 55
      Top = 150
      Width = 396
      Height = 70
      BevelInner = bvNone
      BevelOuter = bvRaised
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'edtText')
      ParentCtl3D = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 3
      Zoom = 100
    end
    object ButtonedEdit1: TButtonedEdit
      Left = 168
      Top = 102
      Width = 121
      Height = 19
      RightButton.Visible = True
      TabOrder = 4
      Text = 'ButtonedEdit1'
    end
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 239
    Width = 468
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlFooter'
    ShowCaption = False
    TabOrder = 1
    object btnSend: TBitBtn
      Left = 297
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Enviar'
      TabOrder = 0
      OnClick = btnSendClick
    end
    object btnDiscard: TBitBtn
      Left = 376
      Top = 10
      Width = 75
      Height = 25
      Cancel = True
      Caption = 'Descartar'
      TabOrder = 1
    end
  end
end
