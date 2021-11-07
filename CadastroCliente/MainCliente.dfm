object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Cadastro de Cliente'
  ClientHeight = 360
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 568
    Height = 312
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    Color = clWhite
    Ctl3D = False
    ParentBackground = False
    ParentCtl3D = False
    ShowCaption = False
    TabOrder = 0
    object grpCliente: TGroupBox
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 558
      Height = 302
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alTop
      Caption = '  Dados do Cliente  '
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object lblNome: TLabel
        Left = 64
        Top = 30
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object lblIdentidade: TLabel
        Left = 39
        Top = 59
        Width = 52
        Height = 13
        Caption = 'Identidade'
      end
      object lblCPF: TLabel
        Left = 232
        Top = 59
        Width = 19
        Height = 13
        Caption = 'CPF'
      end
      object lblFone: TLabel
        Left = 402
        Top = 59
        Width = 24
        Height = 13
        Caption = 'Fone'
      end
      object lblEmail: TLabel
        Left = 67
        Top = 88
        Width = 24
        Height = 13
        Caption = 'Email'
      end
      object edtNome: TEdit
        Left = 95
        Top = 27
        Width = 420
        Height = 19
        TabOrder = 0
        Text = 'edtNome'
      end
      object edtIdentidade: TEdit
        Left = 95
        Top = 56
        Width = 103
        Height = 19
        TabOrder = 1
        Text = 'edtIdentidade'
      end
      object edtEmail: TEdit
        Left = 95
        Top = 85
        Width = 420
        Height = 19
        CharCase = ecLowerCase
        TabOrder = 4
        Text = 'edtemail'
      end
      object edtCPF: TMaskEdit
        Left = 255
        Top = 56
        Width = 91
        Height = 19
        EditMask = '000.00.000-00;0;_'
        MaxLength = 13
        TabOrder = 2
        Text = ''
      end
      object edtFone: TMaskEdit
        Left = 430
        Top = 56
        Width = 85
        Height = 19
        EditMask = '!\(99\)000-0000;0;_'
        MaxLength = 12
        TabOrder = 3
        Text = ''
      end
      object grpEndereco: TGroupBox
        Left = 15
        Top = 120
        Width = 517
        Height = 166
        Caption = '  Endere'#231'o  '
        TabOrder = 5
        object lblCEP: TLabel
          Left = 57
          Top = 26
          Width = 19
          Height = 13
          Caption = 'CEP'
        end
        object lblNro: TLabel
          Left = 383
          Top = 53
          Width = 37
          Height = 13
          Caption = 'N'#250'mero'
        end
        object lblLogradouro: TLabel
          Left = 21
          Top = 53
          Width = 55
          Height = 13
          Caption = 'Logradouro'
        end
        object lblComplemento: TLabel
          Left = 11
          Top = 80
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object lblBairro: TLabel
          Left = 48
          Top = 108
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object lblEstado: TLabel
          Left = 387
          Top = 107
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        object btnConsultarCEP: TSpeedButton
          Left = 151
          Top = 23
          Width = 99
          Height = 21
          Caption = 'Consultar CEP'
          OnClick = btnConsultarCEPClick
        end
        object lblPais: TLabel
          Left = 337
          Top = 134
          Width = 19
          Height = 13
          Caption = 'Pa'#237's'
        end
        object lblCidade: TLabel
          Left = 43
          Top = 134
          Width = 33
          Height = 13
          Caption = 'Cidade'
        end
        object edtCEP: TEdit
          Left = 80
          Top = 24
          Width = 65
          Height = 19
          MaxLength = 8
          TabOrder = 0
          Text = '01001000'
          OnKeyPress = edtCEPKeyPress
        end
        object edtLogradouro: TEdit
          Left = 80
          Top = 51
          Width = 272
          Height = 19
          TabOrder = 1
          Text = 'edtLogradouro'
        end
        object edtComplemento: TEdit
          Left = 80
          Top = 78
          Width = 420
          Height = 19
          TabOrder = 3
          Text = 'edtComplemento'
        end
        object edtBairro: TEdit
          Left = 80
          Top = 105
          Width = 272
          Height = 19
          TabOrder = 4
          Text = 'edtBairro'
        end
        object cbbEstado: TComboBox
          Left = 424
          Top = 105
          Width = 76
          Height = 21
          Style = csDropDownList
          TabOrder = 5
          Items.Strings = (
            'AC'
            'AL'
            'AP'
            'AM'
            'BA'
            'CE'
            'DF'
            'ES'
            'GO'
            'MA'
            'MT'
            'MS'
            'MG'
            'PA'
            'PB'
            'PR'
            'PE'
            'PI'
            'RJ'
            'RN'
            'RS'
            'RO'
            'RR'
            'SC'
            'SP'
            'SE'
            'TO')
        end
        object edtNro: TEdit
          Left = 424
          Top = 51
          Width = 76
          Height = 19
          TabOrder = 2
          Text = 'edtNro'
          OnKeyPress = edtOnlyNumberKeyPress
        end
        object edtPais: TEdit
          Left = 360
          Top = 132
          Width = 140
          Height = 19
          TabOrder = 7
          Text = 'edtPais'
        end
        object edtCidade: TEdit
          Left = 80
          Top = 132
          Width = 224
          Height = 19
          TabOrder = 6
          Text = 'edtCidade'
        end
      end
    end
  end
  object btnSendEmail: TButton
    Left = 464
    Top = 324
    Width = 99
    Height = 25
    Caption = 'Enviar E-mail'
    TabOrder = 1
    OnClick = btnSendEmailClick
  end
end
