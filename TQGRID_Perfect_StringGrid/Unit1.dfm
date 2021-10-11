object Form1: TForm1
  Left = 232
  Top = 126
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TQGRID - Perfect StringGrid'
  ClientHeight = 618
  ClientWidth = 962
  Color = 6004707
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 17
  object GroupBox1: TGroupBox
    Left = 408
    Top = 0
    Width = 297
    Height = 337
    Caption = ' ProgressBar '
    TabOrder = 0
    object Label1: TLabel
      Left = 21
      Top = 172
      Width = 99
      Height = 17
      Caption = 'Diametre point :'
    end
    object Label2: TLabel
      Left = 21
      Top = 210
      Width = 56
      Height = 17
      Caption = 'Position :'
    end
    object Label9: TLabel
      Left = 14
      Top = 266
      Width = 47
      Height = 17
      Caption = 'Debut :'
    end
    object Label10: TLabel
      Left = 14
      Top = 303
      Width = 26
      Height = 17
      Caption = 'Fin :'
    end
    object TrackBar2: TTrackBar
      Left = 120
      Top = 210
      Width = 147
      Height = 44
      Max = 100
      Frequency = 10
      Position = 75
      TabOrder = 0
      OnChange = TrackBar2Change
    end
    object TrackBar1: TTrackBar
      Left = 120
      Top = 167
      Width = 147
      Height = 35
      Max = 50
      Min = 7
      Frequency = 5
      Position = 25
      TabOrder = 1
      OnChange = TrackBar1Change
    end
    object GroupBox2: TGroupBox
      Left = 139
      Top = 25
      Width = 144
      Height = 128
      Caption = ' Texte '
      TabOrder = 2
      object RadioButton6: TRadioButton
        Left = 21
        Top = 68
        Width = 116
        Height = 22
        Caption = 'Pourcentage'
        TabOrder = 0
        OnClick = RadioButton6Click
      end
      object RadioButton5: TRadioButton
        Left = 21
        Top = 98
        Width = 116
        Height = 22
        Caption = 'Valeur'
        TabOrder = 1
        OnClick = RadioButton5Click
      end
      object RadioButton4: TRadioButton
        Left = 21
        Top = 38
        Width = 106
        Height = 22
        Caption = 'Pas Texte'
        Checked = True
        TabOrder = 2
        TabStop = True
        OnClick = RadioButton4Click
      end
    end
    object GroupBox4: TGroupBox
      Left = 12
      Top = 25
      Width = 119
      Height = 128
      Caption = ' Forme '
      TabOrder = 3
      object RadioButton1: TRadioButton
        Left = 31
        Top = 31
        Width = 85
        Height = 23
        Caption = 'Bar'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 31
        Top = 63
        Width = 85
        Height = 22
        Caption = 'Cercle'
        TabOrder = 1
        OnClick = RadioButton2Click
      end
      object RadioButton3: TRadioButton
        Left = 31
        Top = 93
        Width = 75
        Height = 22
        Caption = 'Point'
        TabOrder = 2
        OnClick = RadioButton3Click
      end
    end
    object ColorBox7: TColorBox
      Left = 115
      Top = 262
      Width = 152
      Height = 22
      Selected = clYellow
      ItemHeight = 16
      TabOrder = 4
      OnChange = ColorBox7Change
    end
    object ColorBox8: TColorBox
      Left = 115
      Top = 299
      Width = 152
      Height = 22
      Selected = clRed
      ItemHeight = 16
      TabOrder = 5
      OnChange = ColorBox8Change
    end
  end
  object GroupBox3: TGroupBox
    Left = 408
    Top = 344
    Width = 297
    Height = 265
    Caption = ' CheckBox '
    TabOrder = 1
    object Label3: TLabel
      Left = 14
      Top = 63
      Width = 38
      Height = 17
      Caption = 'Stick :'
    end
    object Label4: TLabel
      Left = 14
      Top = 95
      Width = 85
      Height = 17
      Caption = 'Stick grayed :'
    end
    object Label5: TLabel
      Left = 14
      Top = 128
      Width = 77
      Height = 17
      Caption = 'Font check :'
    end
    object Label6: TLabel
      Left = 14
      Top = 162
      Width = 96
      Height = 17
      Caption = 'Font grayed 1 :'
    end
    object Label7: TLabel
      Left = 13
      Top = 196
      Width = 96
      Height = 17
      Caption = 'Font grayed 2 :'
    end
    object Label8: TLabel
      Left = 13
      Top = 229
      Width = 78
      Height = 17
      Caption = 'Tour check :'
    end
    object CheckBox2: TCheckBox
      Left = 14
      Top = 29
      Width = 108
      Height = 22
      Caption = 'Check 3D'
      TabOrder = 0
      OnClick = CheckBox2Click
    end
    object ColorBox1: TColorBox
      Left = 115
      Top = 59
      Width = 152
      Height = 22
      ItemHeight = 16
      TabOrder = 1
      OnChange = ColorBox1Change
    end
    object ColorBox2: TColorBox
      Left = 115
      Top = 92
      Width = 152
      Height = 22
      ItemHeight = 16
      TabOrder = 2
      OnChange = ColorBox2Change
    end
    object ColorBox3: TColorBox
      Left = 115
      Top = 124
      Width = 152
      Height = 22
      ItemHeight = 16
      TabOrder = 3
      OnChange = ColorBox3Change
    end
    object ColorBox4: TColorBox
      Left = 115
      Top = 158
      Width = 152
      Height = 22
      ItemHeight = 16
      TabOrder = 4
      OnChange = ColorBox4Change
    end
    object ColorBox5: TColorBox
      Left = 115
      Top = 192
      Width = 152
      Height = 22
      ItemHeight = 16
      TabOrder = 5
      OnChange = ColorBox5Change
    end
    object ColorBox6: TColorBox
      Left = 115
      Top = 225
      Width = 152
      Height = 22
      ItemHeight = 16
      TabOrder = 6
      OnChange = ColorBox6Change
    end
    object CheckBox4: TCheckBox
      Left = 140
      Top = 31
      Width = 102
      Height = 23
      Caption = 'Checked'
      TabOrder = 7
      OnClick = CheckBox4Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 712
    Top = 0
    Width = 241
    Height = 177
    Caption = ' Motif Etoile '
    TabOrder = 2
    object Label11: TLabel
      Left = 14
      Top = 52
      Width = 38
      Height = 17
      Caption = 'Stick :'
    end
    object Label12: TLabel
      Left = 16
      Top = 99
      Width = 58
      Height = 17
      Caption = 'Nombre :'
    end
    object Label13: TLabel
      Left = 16
      Top = 141
      Width = 36
      Height = 17
      Caption = 'Plein :'
    end
    object ColorBox9: TColorBox
      Left = 80
      Top = 48
      Width = 151
      Height = 22
      Selected = clRed
      ItemHeight = 16
      TabOrder = 0
      OnChange = ColorBox9Change
    end
    object SpinEdit1: TSpinEdit
      Left = 84
      Top = 94
      Width = 147
      Height = 27
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 3
      OnChange = SpinEdit1Change
    end
    object SpinEdit2: TSpinEdit
      Left = 84
      Top = 136
      Width = 147
      Height = 27
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 2
      OnChange = SpinEdit2Change
    end
  end
  object GroupBox6: TGroupBox
    Left = 712
    Top = 184
    Width = 241
    Height = 145
    Caption = ' Bouton valider '
    TabOrder = 3
    object Label14: TLabel
      Left = 14
      Top = 37
      Width = 47
      Height = 17
      Caption = 'Debut :'
    end
    object Label15: TLabel
      Left = 14
      Top = 68
      Width = 26
      Height = 17
      Caption = 'Fin :'
    end
    object Label16: TLabel
      Left = 14
      Top = 105
      Width = 44
      Height = 17
      Caption = 'Texte :'
    end
    object ColorBox10: TColorBox
      Left = 80
      Top = 25
      Width = 151
      Height = 22
      Selected = clYellow
      ItemHeight = 16
      TabOrder = 0
      OnChange = ColorBox10Change
    end
    object ColorBox11: TColorBox
      Left = 80
      Top = 63
      Width = 151
      Height = 22
      ItemHeight = 16
      TabOrder = 1
      OnChange = ColorBox11Change
    end
    object ColorBox12: TColorBox
      Left = 80
      Top = 103
      Width = 151
      Height = 22
      Selected = clWhite
      ItemHeight = 16
      TabOrder = 2
      OnChange = ColorBox12Change
    end
  end
  object GroupBox7: TGroupBox
    Left = 712
    Top = 416
    Width = 241
    Height = 76
    Caption = ' Evenement click'
    TabOrder = 4
    object CheckBox1: TCheckBox
      Left = 25
      Top = 31
      Width = 165
      Height = 23
      Caption = 'Messages evenement'
      TabOrder = 0
    end
  end
  object GroupBox8: TGroupBox
    Left = 712
    Top = 336
    Width = 241
    Height = 73
    Caption = ' BitmapItem '
    TabOrder = 5
    object CheckBox3: TCheckBox
      Left = 25
      Top = 31
      Width = 165
      Height = 23
      Caption = 'Checked'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox3Click
    end
  end
end
