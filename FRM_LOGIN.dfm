object Form1: TForm1
  Left = 490
  Top = 169
  Caption = 'Form1'
  ClientHeight = 314
  ClientWidth = 277
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 64
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object Label2: TLabel
    Left = 104
    Top = 120
    Width = 54
    Height = 13
    Caption = 'Contrase'#241'a'
  end
  object txtUsuario: TEdit
    Left = 72
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object txtContrasenna: TEdit
    Left = 72
    Top = 144
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object btnIngresar: TButton
    Left = 88
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Ingresar'
    TabOrder = 2
    OnClick = btnIngresarClick
  end
  object ADOConnection1: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=Epsi062019*;Persist Security Info=T' +
      'rue;User ID=sa;Initial Catalog=usuario'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 16
    Top = 40
  end
  object ADOQuery1: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from usuario')
    Left = 24
    Top = 88
    object ADOQuery1idUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object ADOQuery1nombreUsuario: TStringField
      FieldName = 'nombreUsuario'
    end
    object ADOQuery1telefonoUsuario: TStringField
      FieldName = 'telefonoUsuario'
      Size = 15
    end
    object ADOQuery1fechaNacimiento: TDateTimeField
      FieldName = 'fechaNacimiento'
    end
    object ADOQuery1edadUsuario: TIntegerField
      FieldName = 'edadUsuario'
    end
    object ADOQuery1ciudadUsuario: TIntegerField
      FieldName = 'ciudadUsuario'
    end
    object ADOQuery1contrasennaUsuario: TStringField
      FieldName = 'contrasennaUsuario'
    end
  end
  object ADOQuery2: TADOQuery
    Active = True
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from usuario')
    Left = 16
    Top = 160
  end
end
