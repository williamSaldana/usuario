object FormUsuario: TFormUsuario
  Left = 355
  Top = 125
  Caption = 'Datos Usuario'
  ClientHeight = 453
  ClientWidth = 750
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
    Left = 48
    Top = 8
    Width = 673
    Height = 249
    Caption = 'Datos Personales'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 33
      Height = 13
      Caption = 'Codigo'
    end
    object Label2: TLabel
      Left = 16
      Top = 48
      Width = 37
      Height = 13
      Caption = 'Nombre'
    end
    object Label3: TLabel
      Left = 16
      Top = 72
      Width = 42
      Height = 13
      Caption = 'Telefono'
    end
    object Label4: TLabel
      Left = 16
      Top = 96
      Width = 84
      Height = 13
      Caption = 'Fecha nacimiento'
    end
    object Label5: TLabel
      Left = 16
      Top = 120
      Width = 25
      Height = 13
      Caption = 'Edad'
    end
    object Label6: TLabel
      Left = 16
      Top = 168
      Width = 33
      Height = 13
      Caption = 'Ciudad'
    end
    object Label7: TLabel
      Left = 16
      Top = 192
      Width = 54
      Height = 13
      Caption = 'Contrase'#241'a'
    end
    object Label8: TLabel
      Left = 16
      Top = 144
      Width = 67
      Height = 13
      Caption = 'Departamento'
    end
    object txtCodigo: TEdit
      Left = 120
      Top = 13
      Width = 153
      Height = 21
      TabOrder = 0
      OnExit = txtCodigoExit
      OnKeyPress = txtCodigoKeyPress
    end
    object txtNombre: TEdit
      Left = 120
      Top = 40
      Width = 153
      Height = 21
      TabOrder = 1
      OnKeyPress = txtNombreKeyPress
    end
    object txtTelefono: TEdit
      Left = 120
      Top = 64
      Width = 153
      Height = 21
      TabOrder = 2
      OnKeyPress = txtTelefonoKeyPress
    end
    object txtEdad: TEdit
      Left = 120
      Top = 109
      Width = 153
      Height = 21
      TabOrder = 4
      OnKeyPress = txtEdadKeyPress
    end
    object txtContrasenna: TEdit
      Left = 120
      Top = 184
      Width = 153
      Height = 21
      PasswordChar = '*'
      TabOrder = 7
    end
    object btnCrear: TButton
      Left = 384
      Top = 56
      Width = 75
      Height = 25
      Caption = 'Crear'
      TabOrder = 8
      OnClick = btnCrearClick
    end
    object btnModificar: TButton
      Left = 384
      Top = 88
      Width = 75
      Height = 25
      Caption = 'Modificar'
      TabOrder = 9
      OnClick = btnModificarClick
    end
    object btnEliminar: TButton
      Left = 384
      Top = 120
      Width = 75
      Height = 25
      Caption = 'Eliminar'
      TabOrder = 10
      OnClick = btnEliminarClick
    end
    object cmbDepartamento: TDBLookupComboBox
      Left = 120
      Top = 136
      Width = 153
      Height = 21
      KeyField = 'idDepartamento'
      ListField = 'nombreDepartamento'
      ListSource = DataSourceDepartamento
      TabOrder = 5
      OnClick = cmbDepartamentoClick
      OnExit = cmbDepartamentoExit
    end
    object cmbCiudad: TDBLookupComboBox
      Left = 120
      Top = 160
      Width = 153
      Height = 21
      KeyField = 'idCiudad'
      ListField = 'nombreCiudad'
      ListSource = DataSourceCiudad
      TabOrder = 6
    end
    object btnLimpiar: TButton
      Left = 384
      Top = 168
      Width = 75
      Height = 25
      Caption = 'Limpiar'
      TabOrder = 11
      OnClick = btnLimpiarClick
    end
    object DateTimePicker1: TDateTimePicker
      Left = 120
      Top = 91
      Width = 153
      Height = 21
      Date = 43994.000000000000000000
      Time = 0.409868206021201300
      TabOrder = 3
      OnChange = DateTimePicker1Change
    end
  end
  object DBGrid1: TDBGrid
    Left = 48
    Top = 263
    Width = 673
    Height = 177
    DataSource = DataSourceGrid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object ADOQuery1: TADOQuery
    Active = True
    Connection = DataModule2.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT idUsuario as Codigo,nombreUsuario as Nombre,telefonoUsuar' +
        'io as Telefono,fechaNacimiento as Fecha_Nacimiento,edadUsuario a' +
        's Edad, nombreCiudad as Ciudad '
      'FROM usuario inner join ciudad on idCiudad = ciudadUsuario;')
    Left = 8
    object ADOQuery1Codigo: TIntegerField
      FieldName = 'Codigo'
    end
    object ADOQuery1Nombre: TStringField
      FieldName = 'Nombre'
    end
    object ADOQuery1Telefono: TStringField
      FieldName = 'Telefono'
      Size = 15
    end
    object ADOQuery1Fecha_Nacimiento: TDateTimeField
      FieldName = 'Fecha_Nacimiento'
    end
    object ADOQuery1Edad: TIntegerField
      FieldName = 'Edad'
    end
    object ADOQuery1Ciudad: TStringField
      FieldName = 'Ciudad'
    end
  end
  object DataSourceGrid: TDataSource
    DataSet = ADOQuery1
    Left = 8
    Top = 32
  end
  object DataSourceCiudad: TDataSource
    DataSet = ADOQuery2
    Left = 8
    Top = 112
  end
  object DataSourceDepartamento: TDataSource
    DataSet = ADOQueryDepartamento
    Left = 8
    Top = 160
  end
  object ADOQueryDepartamento: TADOQuery
    Active = True
    Connection = DataModule2.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM departamento')
    Left = 8
    Top = 192
  end
  object ADOQuery2: TADOQuery
    Connection = DataModule2.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM ciudad')
    Left = 8
    Top = 80
  end
  object ADOQuery3: TADOQuery
    Active = True
    Connection = DataModule2.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from departamento')
    Left = 8
    Top = 272
  end
  object ADOQuery4: TADOQuery
    Active = True
    Connection = DataModule2.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM USUARIO')
    Left = 8
    Top = 320
    object ADOQuery4idUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object ADOQuery4nombreUsuario: TStringField
      FieldName = 'nombreUsuario'
    end
    object ADOQuery4telefonoUsuario: TStringField
      FieldName = 'telefonoUsuario'
      Size = 15
    end
    object ADOQuery4fechaNacimiento: TDateTimeField
      FieldName = 'fechaNacimiento'
    end
    object ADOQuery4edadUsuario: TIntegerField
      FieldName = 'edadUsuario'
    end
    object ADOQuery4ciudadUsuario: TIntegerField
      FieldName = 'ciudadUsuario'
    end
    object ADOQuery4contrasennaUsuario: TStringField
      FieldName = 'contrasennaUsuario'
    end
  end
  object ADOQueryConsulta: TADOQuery
    Active = True
    Connection = DataModule2.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from usuario')
    Left = 8
    Top = 368
  end
end
