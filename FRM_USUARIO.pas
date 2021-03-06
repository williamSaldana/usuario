unit FRM_USUARIO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBCtrls, StdCtrls, ADODB, ComCtrls;

type
  TFormUsuario = class(TForm)
    ADOQuery1: TADOQuery;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    txtCodigo: TEdit;
    txtNombre: TEdit;
    txtTelefono: TEdit;
    txtEdad: TEdit;
    txtContrasenna: TEdit;
    btnCrear: TButton;
    btnModificar: TButton;
    btnEliminar: TButton;
    Label8: TLabel;
    cmbDepartamento: TDBLookupComboBox;
    cmbCiudad: TDBLookupComboBox;
    DataSourceGrid: TDataSource;
    DBGrid1: TDBGrid;
    DataSourceCiudad: TDataSource;
    DataSourceDepartamento: TDataSource;
    ADOQueryDepartamento: TADOQuery;
    ADOQuery2: TADOQuery;
    btnLimpiar: TButton;
    ADOQuery3: TADOQuery;
    ADOQuery4: TADOQuery;
    DateTimePicker1: TDateTimePicker;
    ADOQuery4idUsuario: TIntegerField;
    ADOQuery4nombreUsuario: TStringField;
    ADOQuery4telefonoUsuario: TStringField;
    ADOQuery4fechaNacimiento: TDateTimeField;
    ADOQuery4edadUsuario: TIntegerField;
    ADOQuery4ciudadUsuario: TIntegerField;
    ADOQuery4contrasennaUsuario: TStringField;
    ADOQueryConsulta: TADOQuery;
    ADOQuery1Codigo: TIntegerField;
    ADOQuery1Nombre: TStringField;
    ADOQuery1Telefono: TStringField;
    ADOQuery1Fecha_Nacimiento: TDateTimeField;
    ADOQuery1Edad: TIntegerField;
    ADOQuery1Ciudad: TStringField;
    procedure btnCrearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtCodigoExit(Sender: TObject);
    procedure cmbDepartamentoExit(Sender: TObject);
    procedure btnLimpiarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure txtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure txtNombreKeyPress(Sender: TObject; var Key: Char);
    procedure txtTelefonoKeyPress(Sender: TObject; var Key: Char);
    procedure txtEdadKeyPress(Sender: TObject; var Key: Char);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure cmbDepartamentoClick(Sender: TObject);
  private
    { Private declarations }
    procedure ActualizarConsulta;
    procedure LimpiarCampos;
    procedure BloquearCampos;
    procedure HabilitarCampos;
    procedure HabilitarCiudad;
    procedure BloqueoNumeros;
    procedure Calcularedad;
  public
    { Public declarations }

  end;

var
  FormUsuario: TFormUsuario;

const
  C1 = 52845;
  C2 = 11719;

implementation

uses U_DATAMODULO;

{$R *.dfm}

// encriptar datos
function encriptar(const S: String; Key: Word): String;
var
  I: byte;
begin
  SetLength(Result, Length(S));
  for I := 1 to Length(S) do
  begin
    Result[I] := Char(byte(S[I]) xor (Key shr 8));
    Key := (byte(Result[I]) + Key) * C1 + C2;
  end;
end;

procedure TFormUsuario.ActualizarConsulta;
begin
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add
    ('SELECT idUsuario as Codigo,nombreUsuario as Nombre,telefonoUsuario as Telefono,fechaNacimiento as Fecha_Nacimiento,edadUsuario as Edad, nombreCiudad as Ciudad FROM usuario inner join ciudad on idCiudad = ciudadUsuario');
  ADOQuery1.Open;
end;

procedure TFormUsuario.LimpiarCampos;
begin
  txtCodigo.Text := '';
  txtNombre.Text := '';
  txtTelefono.Text := '';
  txtEdad.Text := '';
  txtContrasenna.Text := '';
  cmbDepartamento.KeyValue := Null;
  cmbCiudad.KeyValue := Null;
  DateTimePicker1.Date := StrToDate('01/01/1900');
end;

procedure TFormUsuario.BloquearCampos;
begin
  txtNombre.Enabled := false;
  txtNombre.Color := clGray;
  txtTelefono.Enabled := false;
  txtTelefono.Color := clGray;
  DateTimePicker1.Enabled := false;
  DateTimePicker1.Color := clGray;
  txtEdad.Enabled := false;
  txtEdad.Color := clSilver;
  txtContrasenna.Enabled := false;
  txtContrasenna.Color := clGray;
  cmbDepartamento.Enabled := false;
  cmbDepartamento.Color := clGrayText;
  cmbCiudad.Enabled := false;
  cmbCiudad.Color := clGrayText;
  DateTimePicker1.Enabled := false;
end;

procedure TFormUsuario.HabilitarCampos;
begin
  txtNombre.Enabled := true;
  txtNombre.Color := clWhite;
  txtTelefono.Enabled := true;
  txtTelefono.Color := clWhite;
  DateTimePicker1.Enabled := true;
  DateTimePicker1.Color := clWhite;
//  txtEdad.Enabled := true;
  txtEdad.Color := clSilver;
  txtContrasenna.Enabled := true;
  txtContrasenna.Color := clWhite;
  txtNombre.SetFocus;
  ADOQueryDepartamento.Open;
  cmbDepartamento.Enabled := true;
  cmbDepartamento.Color := clWhite;
  cmbCiudad.Enabled := false;
  cmbCiudad.Color := clWhite;
  DateTimePicker1.Enabled := true;
end;

procedure TFormUsuario.BloqueoNumeros;
begin

end;

procedure TFormUsuario.HabilitarCiudad;
begin
  ADOQueryDepartamento.SQL.Clear;
  ADOQueryDepartamento.SQL.Add('select * from departamento');
  ADOQueryDepartamento.Open;

  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Add('SELECT * FROM ciudad WHERE idCiudad=:Codigo ');
  ADOQuery2.Parameters.ParamByName('Codigo').Value :=
    Trim(cmbDepartamento.KeyValue);
  ADOQuery2.Open;
  cmbCiudad.Enabled := true;
  cmbCiudad.SetFocus;
end;

procedure TFormUsuario.Calcularedad;
var
  fecha, fecha2: TDate;
  day, month, year: Word;
  day2, month2, year2: Word;
  edad: Integer;
begin
  fecha2 := Date;
  fecha := DateTimePicker1.Date;
  DecodeDate(fecha, year, month, day);
  DecodeDate(fecha2, year2, month2, day2);
  edad := year2 - year;
  txtEdad.Text := IntToStr(edad);

end;

procedure TFormUsuario.btnCrearClick(Sender: TObject);
var
  encode: string;
begin

  if (txtCodigo.Text = '') then

  begin
    ShowMessage('Ingrese el codigo');
    Exit;
  end

  else
    ADOQueryConsulta.Close;
  ADOQueryConsulta.SQL.Clear;
  ADOQueryConsulta.SQL.Add('SELECT * FROM usuario WHERE idUsuario =:Codigo');
  ADOQueryConsulta.Parameters.ParamByName('Codigo').Value :=
    Trim(txtCodigo.Text);
  ADOQueryConsulta.Open;

  if (txtCodigo.Text = ADOQueryConsulta.FieldByName('idUsuario').AsString) then
  begin
    ShowMessage('El usuario :Codigo , :Nombre ya esta registrado');
    ADOQuery1.Parameters.ParamByName('Codigo').Value := Trim(txtCodigo.Text);
    ADOQuery1.Parameters.ParamByName('Nombre').Value := Trim(txtNombre.Text);
    ActualizarConsulta;
    Exit;
  end

  else

    TRY
      DataModule2.ADOConnection1.BeginTrans;

      ADOQuery1.SQL.Clear;
      ADOQuery1.SQL.Add('INSERT INTO usuario VALUES ' +
        '(:Codigo,:Nombre,:Telefono,:Fecha,:Edad,:Ciudad,:Contrasenna)');
      encode := encriptar(txtContrasenna.Text, 10);
      ADOQuery1.Parameters.ParamByName('Codigo').Value := Trim(txtCodigo.Text);
      ADOQuery1.Parameters.ParamByName('Nombre').Value := Trim(txtNombre.Text);
      ADOQuery1.Parameters.ParamByName('Telefono').Value :=
        Trim(txtTelefono.Text);
      ADOQuery1.Parameters.ParamByName('Fecha').Value :=
        DateToStr(DateTimePicker1.Date);
      ADOQuery1.Parameters.ParamByName('Edad').Value := Trim(txtEdad.Text);
      ADOQuery1.Parameters.ParamByName('Ciudad').Value :=
        Trim(cmbCiudad.KeyValue);
      ADOQuery1.Parameters.ParamByName('Contrasenna').Value := Trim(encode);
      ADOQuery1.ExecSQL;

      DataModule2.ADOConnection1.CommitTrans;
    EXCEPT
      DataModule2.ADOConnection1.RollbackTrans;

      Exit;
    END;

  ActualizarConsulta;
  LimpiarCampos;
  BloquearCampos;
  ShowMessage('Se registro con exito');
  txtCodigo.SetFocus;
end;

procedure TFormUsuario.FormCreate(Sender: TObject);
begin
  BloquearCampos;
  txtContrasenna.Visible := false;
  Label7.Visible := false;
  DateTimePicker1.Date := StrToDate('01/01/1900');
end;

procedure TFormUsuario.txtCodigoExit(Sender: TObject);
begin

  if (txtCodigo.Text = '') then
  begin
    ShowMessage('Ingrese el codigo');
    Exit;
  end
  else
  begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Add
      ('SELECT idUsuario as Codigo,nombreUsuario as Nombre,telefonoUsuario as Telefono,fechaNacimiento as Fecha_Nacimiento,edadUsuario as Edad, nombreCiudad as Ciudad '
      + 'FROM usuario inner join ciudad on idCiudad = ciudadUsuario WHERE idUsuario =:Codigo');
    ADOQuery1.Parameters.ParamByName('Codigo').Value := Trim(txtCodigo.Text);
    ADOQuery1.Open;

    if (txtCodigo.Text = ADOQuery1.FieldByName('Codigo').AsString) then
    begin
      ShowMessage('El codigo ''' + txtCodigo.Text + ''' ya esta registrado');

    end
  end;
  ADOQueryDepartamento.Open;
  HabilitarCampos;

  if (txtCodigo.Text = '') then
  begin
    ShowMessage('Inserte el codigo');
    Exit;
  end
  else
  begin
    ADOQueryConsulta.SQL.Clear;
    ADOQueryConsulta.SQL.Add('SELECT * from usuario WHERE idUsuario =:Codigo');
    ADOQueryConsulta.Parameters.ParamByName('Codigo').Value :=
      Trim(txtCodigo.Text);
    ADOQueryConsulta.Open;

    if not ADOQuery1.Eof then
    begin
      txtCodigo.Text := ADOQueryConsulta.FieldByName('idUsuario').AsString;
      txtNombre.Text := ADOQueryConsulta.FieldByName('nombreUsuario').AsString;
      txtTelefono.Text := ADOQueryConsulta.FieldByName
        ('telefonoUsuario').AsString;
      DateTimePicker1.Date := ADOQuery1Fecha_Nacimiento.Value;
      Calcularedad;
      cmbCiudad.KeyValue := ADOQueryConsulta.FieldByName
        ('ciudadUsuario').AsString;

      ADOQuery3.SQL.Clear;
      ADOQuery3.SQL.Add
        ('SELECT * FROM ciudad WHERE departamentoCiudad=:Ciudad');
      ADOQuery3.Parameters.ParamByName('Ciudad').Value :=
        Trim(ADOQueryConsulta.FieldByName('ciudadUsuario').Value);
      ADOQuery3.Open;

      cmbDepartamento.KeyValue := ADOQuery3.FieldByName
        ('departamentoCiudad').AsString;
      HabilitarCiudad;
      Calcularedad;
      ActualizarConsulta;
      Exit;
    end;
  end;

  ActualizarConsulta;

  Exit;
  HabilitarCampos;
  cmbCiudad.Enabled := false;

end;

procedure TFormUsuario.cmbDepartamentoClick(Sender: TObject);
begin
  HabilitarCiudad;
end;

procedure TFormUsuario.cmbDepartamentoExit(Sender: TObject);
begin
  HabilitarCiudad;
end;

procedure TFormUsuario.DateTimePicker1Change(Sender: TObject);
begin
  Calcularedad;

end;

procedure TFormUsuario.DBGrid1CellClick(Column: TColumn);
begin
  HabilitarCampos;

  ADOQuery3.SQL.Clear;
  ADOQuery3.SQL.Add('SELECT idDepartamento FROM departamento ' +
    'INNER JOIN ciudad on idDepartamento=departamentoCiudad ' +
    'INNER JOIN usuario on idCiudad=ciudadUsuario where nombreCiudad=:Ciudad;');
  ADOQuery3.Parameters.ParamByName('Ciudad').Value :=
    DBGrid1.DataSource.DataSet.Fields[5].Value;
  ADOQuery3.Open;

  ADOQueryConsulta.SQL.Clear;
  ADOQueryConsulta.SQL.Add
    ('select idCiudad from ciudad where nombreCiudad=:Nombre');
  ADOQueryConsulta.Parameters.ParamByName('Nombre').Value :=
    DBGrid1.DataSource.DataSet.Fields[5].Value;
  ADOQueryConsulta.Open;

  txtCodigo.Text := DBGrid1.DataSource.DataSet.Fields[0].Value;
  txtNombre.Text := DBGrid1.DataSource.DataSet.Fields[1].Value;
  txtTelefono.Text := DBGrid1.DataSource.DataSet.Fields[2].Value;
  DateTimePicker1.Date := DBGrid1.DataSource.DataSet.Fields[3].Value;
  Calcularedad;
  cmbDepartamento.KeyValue := ADOQuery3.FieldByName('idDepartamento').Value;
  HabilitarCiudad;
  cmbCiudad.KeyValue := ADOQueryConsulta.FieldByName('idCiudad').Value;

end;

procedure TFormUsuario.btnLimpiarClick(Sender: TObject);
begin
  LimpiarCampos;
  BloquearCampos;
  txtCodigo.SetFocus;
end;

procedure TFormUsuario.btnModificarClick(Sender: TObject);

/// ////////////////////

begin
  if (txtCodigo.Text = '') or (txtNombre.Text = '') or (txtTelefono.Text = '')
    or (txtEdad.Text = '') then
  begin
    ShowMessage('Datos sin registrar');
    Exit;
  end
  else
    txtContrasenna.Visible := true;
  Label7.Visible := true;

  if MessageDlg('desea modificar los datos con el codigo: ''' + txtCodigo.Text +
    ''' ??', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    ADOQueryConsulta.SQL.Clear;
    ADOQueryConsulta.SQL.Add('select * from usuario where idUsuario=:Codigo');
    ADOQueryConsulta.Parameters.ParamByName('Codigo').Value :=
      Trim(txtCodigo.Text);
    ADOQueryConsulta.Open;

    if (txtCodigo.Text <> ADOQueryConsulta.FieldByName('idusuario').AsString)
    then
    begin
      ShowMessage('El codigo :Codigo no esta registrado');
      ADOQueryConsulta.Parameters.ParamByName('Codigo').Value :=
        Trim(txtCodigo.Text);
      ActualizarConsulta;
      LimpiarCampos;
      Exit;
    end
    else
    begin

      if (txtCodigo.Text = (ADOQueryConsulta.FieldByName('idUsuario').AsString))
        and (txtNombre.Text = (ADOQueryConsulta.FieldByName('nombreUsuario')
        .AsString)) and
        (txtTelefono.Text = (ADOQueryConsulta.FieldByName('telefonoUsuario')
        .AsString)) and (DateTimePicker1.Date = ADOQueryConsulta.FieldByName
        ('fechaNacimiento').Value) and
        (txtEdad.Text = (ADOQueryConsulta.FieldByName('edadUsuario').AsString))
        and (cmbCiudad.KeyValue = (ADOQueryConsulta.FieldByName('ciudadUsuario')
        .AsString)) then
      begin
        ShowMessage('No hay cambio en los datos');
      end
      else

      begin

        try

          DataModule2.ADOConnection1.BeginTrans;

          ADOQuery3.SQL.Clear;
          ADOQuery3.SQL.Add
            ('INSERT INTO Cusuario VALUES(:Codigo,:Nombre,:Telefono,:Fecha,:Edad,:Ciudad,:Contrasenna)');
          ADOQuery3.Parameters.ParamByName('Codigo').Value :=
            Trim(txtCodigo.Text);
          ADOQuery3.Parameters.ParamByName('Nombre').Value :=
            Trim(txtNombre.Text);
          ADOQuery3.Parameters.ParamByName('Telefono').Value :=
            Trim(txtTelefono.Text);
          ADOQuery3.Parameters.ParamByName('Fecha').Value :=
            Trim(DateToStr(DateTimePicker1.Date));
          ADOQuery3.Parameters.ParamByName('Edad').Value := Trim(txtEdad.Text);
          ADOQuery3.Parameters.ParamByName('Ciudad').Value :=
            Trim(cmbCiudad.KeyValue);
          ADOQuery3.Parameters.ParamByName('Contrasenna').Value :=
            Trim(txtContrasenna.Text);
          ADOQuery3.ExecSQL;

          DataModule2.ADOConnection1.CommitTrans;

        except

          DataModule2.ADOConnection1.RollbackTrans;
          Exit;

        end;

        TRY
          DataModule2.ADOConnection1.BeginTrans;

          ADOQuery4.SQL.Clear;
          ADOQuery4.SQL.Add('SELECT * FROM usuario where idUsuario=:"Codigo"');
          ADOQuery4.Parameters.ParamByName('Codigo').Value :=
            StrToInt(Trim(txtCodigo.Text));
          ADOQuery4.Open;
          ADOQuery4.Edit;
          ADOQuery4idUsuario.Value := StrToInt(txtCodigo.Text);
          ADOQuery4nombreUsuario.Value := txtNombre.Text;
          ADOQuery4telefonoUsuario.Value := txtTelefono.Text;
          ADOQuery4fechaNacimiento.Value := DateTimePicker1.Date;
          ADOQuery4edadUsuario.Value := StrToInt(txtEdad.Text);
          ADOQuery4ciudadUsuario.Value := cmbCiudad.KeyValue;
          ADOQuery4contrasennaUsuario.Value := txtContrasenna.Text;

          ADOQuery4.Post;

          ShowMessage('Los datos han sido modificados');

          DataModule2.ADOConnection1.CommitTrans;

        EXCEPT

          DataModule2.ADOConnection1.RollbackTrans;
          Exit;

        END;

      end;
    end;

    ActualizarConsulta;
    LimpiarCampos;

  end;
  BloquearCampos;
  txtCodigo.SetFocus;
end;

procedure TFormUsuario.btnEliminarClick(Sender: TObject);
begin
  if (txtCodigo.Text = '') then
  begin
    ShowMessage('Inserte el codigo');
    Exit;
  end
  else
  begin
    ADOQueryConsulta.SQL.Clear;
    ADOQueryConsulta.SQL.Add('SELECT * FROM usuario WHERE idUsuario=:Codigo ');
    ADOQueryConsulta.Parameters.ParamByName('Codigo').Value := Trim(txtCodigo.Text);
    ADOQueryConsulta.Open;

    if MessageDlg('quieres eliminar datos con un codigo ''' + txtCodigo.Text +
      ''' ??', mtConfirmation, [mbYes, mbNo], 0) = mrNo then
    begin

      if (txtCodigo.Text <> ADOQuery1.FieldByName('idUsuario').AsString) then

        ShowMessage('El codigo ''' + txtCodigo.Text + ''' no esta registrado');
      ActualizarConsulta;
      Exit;
    end
    else
    begin

      TRY
        DataModule2.ADOConnection1.BeginTrans;

        ADOQueryConsulta.SQL.Clear;
        ADOQueryConsulta.SQL.Add('DELETE FROM usuario WHERE idUsuario= ''' +
          txtCodigo.Text + ''' ');
        ADOQueryConsulta.ExecSQL;

        ActualizarConsulta;
        LimpiarCampos;

        ShowMessage('los datos se han eliminado con exito');

        DataModule2.ADOConnection1.CommitTrans;
      EXCEPT
        DataModule2.ADOConnection1.RollbackTrans;

        Exit;
      END;
    end;
  end;
  BloquearCampos;
  txtCodigo.SetFocus;
end;

procedure TFormUsuario.txtCodigoKeyPress(Sender: TObject; var Key: Char);
var
  I: Integer;

begin

  // controlar entrada solo n�meros y punto decimal
  if (StrScan('0123456789.' + chr(7) + chr(8), Key) = nil) then
    Key := #0;
  // cambiar punto decimal por coma
  if Key = '.' then
    Key := ',';
  // controlar entrada una sola coma
  for I := 1 to Length(txtCodigo.Text) do
    if (copy(txtCodigo.Text, I, 1) = ',') and not(StrScan(',', Key) = nil) then
      Key := #0;

end;

procedure TFormUsuario.txtNombreKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['0' .. '9'] then
  begin
    // Application.MessageBox('No puedes escribir numeros en �sta casilla!', 'Error de validaci�n');
    Key := #0;

  end;
end;

procedure TFormUsuario.txtTelefonoKeyPress(Sender: TObject; var Key: Char);
var
  I: Integer;

begin

  // controlar entrada solo n�meros y punto decimal
  if (StrScan('0123456789.' + chr(7) + chr(8), Key) = nil) then
    Key := #0;

  // cambiar punto decimal por coma
  if Key = '.' then
    Key := ',';
  // controlar entrada una sola coma
  for I := 1 to Length(txtCodigo.Text) do
    if (copy(txtCodigo.Text, I, 1) = ',') and not(StrScan(',', Key) = nil) then
      Key := #0;

end;

procedure TFormUsuario.txtEdadKeyPress(Sender: TObject; var Key: Char);
var
  I: Integer;

begin

  // controlar entrada solo n�meros y punto decimal
  if (StrScan('0123456789.' + chr(7) + chr(8), Key) = nil) then
  begin
    Key := #0;

  end
  else
  begin

  end;
  // cambiar punto decimal por coma
  if Key = '.' then
    Key := ',';
  // controlar entrada una sola coma
  for I := 1 to Length(txtCodigo.Text) do
    if (copy(txtCodigo.Text, I, 1) = ',') and not(StrScan(',', Key) = nil) then
      Key := #0;

end;

end.
