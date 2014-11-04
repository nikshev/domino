object Form1: TForm1
  Left = 206
  Top = 104
  Width = 437
  Height = 371
  Caption = #1058#1077#1089#1090#1086#1074#1086#1077' '#1079#1072#1076#1072#1085#1080#1077' ('#1064#1082#1091#1088#1085#1080#1082#1086#1074' '#1045'.'#1042'.)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 8
    Width = 425
    Height = 121
    Caption = #1044#1086#1084#1080#1085#1086#1096#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object Memo1: TMemo
      Left = 8
      Top = 16
      Width = 409
      Height = 89
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 136
    Width = 425
    Height = 169
    Caption = #1062#1077#1087#1086#1095#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object Memo2: TMemo
      Left = 8
      Top = 16
      Width = 409
      Height = 145
      Lines.Strings = (
        '')
      ScrollBars = ssHorizontal
      TabOrder = 0
    end
  end
  object BitBtn1: TBitBtn
    Left = 112
    Top = 312
    Width = 105
    Height = 25
    Caption = #1057#1063#1048#1058#1040#1058#1068
    TabOrder = 2
    OnClick = BitBtn1Click
    Kind = bkRetry
  end
  object BitBtn2: TBitBtn
    Left = 336
    Top = 312
    Width = 81
    Height = 25
    Caption = #1057#1058#1040#1056#1058
    TabOrder = 3
    OnClick = BitBtn2Click
    Kind = bkAll
  end
  object BitBtn3: TBitBtn
    Left = 224
    Top = 312
    Width = 105
    Height = 25
    Caption = #1054#1063#1048#1057#1058#1048#1058#1068
    TabOrder = 4
    OnClick = BitBtn3Click
    Kind = bkIgnore
  end
  object BitBtn4: TBitBtn
    Left = 8
    Top = 312
    Width = 97
    Height = 25
    Caption = #1057#1054#1047#1044#1040#1058#1068
    TabOrder = 5
    OnClick = BitBtn4Click
    Kind = bkYes
  end
  object OpenDialog1: TOpenDialog
    Filter = 'All files|*.*'
    Left = 400
    Top = 312
  end
  object SaveDialog1: TSaveDialog
    Filter = '*.txt|*.txt'
    Left = 368
    Top = 312
  end
end
