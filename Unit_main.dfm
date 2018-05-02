object Form_Main: TForm_Main
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'dOPC_demo, ver. 0.1 [TS]'
  ClientHeight = 106
  ClientWidth = 338
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Memo_Tags: TMemo
    Left = 8
    Top = 8
    Width = 321
    Height = 89
    Alignment = taCenter
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' OPC-'#1089#1077#1088#1074#1077#1088#1091', '
      #1087#1086#1078#1072#1083#1091#1081#1089#1090#1072', '#1087#1086#1076#1086#1078#1076#1080#1090#1077
      '...')
    ParentFont = False
    ReadOnly = True
    TabOrder = 0
  end
  object Timer_ReaderTags: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = Timer_ReaderTagsTimer
    Left = 232
    Top = 40
  end
  object Timer_Starter: TTimer
    Enabled = False
    Interval = 500
    OnTimer = Timer_StarterTimer
    Left = 128
    Top = 40
  end
end
