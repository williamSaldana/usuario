unit FRM_LOGIN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    txtUsuario: TEdit;
    txtContrasenna: TEdit;
    btnIngresar: TButton;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery1idUsuario: TIntegerField;
    ADOQuery1nombreUsuario: TStringField;
    ADOQuery1telefonoUsuario: TStringField;
    ADOQuery1fechaNacimiento: TDateTimeField;
    ADOQuery1edadUsuario: TIntegerField;
    ADOQuery1ciudadUsuario: TIntegerField;
    ADOQuery1contrasennaUsuario: TStringField;
    procedure btnIngresarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  const

  C1 = 52845;
  C2 = 11719;

implementation

uses FRM_USUARIO;

{$R *.dfm}

//encriptar datos



//desencriptar datos
function encriptar(const S: String; Key: Word): String;
var
        I: byte;
        resultado,resultado1  : string;
        y : integer;
      begin
      resultado := '';
        SetLength(Result,Length(S));
        for I := 1 to Length(S) do begin
            Result[I] := char(byte(S[I]) xor (Key shr 8));
            Key := (byte(Result[I]) + Key) * C1 + C2;
        end;
end;


procedure TForm1.btnIngresarClick(Sender: TObject);
  var desencriptado : string;
  var desencriptado2 : string;
  begin
    if(txtUsuario.Text='') and (txtContrasenna.Text='')then
      begin
        ShowMessage('llene todos los campos');
      end
    else
      begin


         ADOQuery1.Close;
        ADOQuery1.SQL.Clear;
        ADOQuery1.SQL.Add('SELECT * FROM usuario WHERE idUsuario =:USUARIO');
        ADOQuery1.parameters.ParamByName('USUARIO').Value:=txtUsuario.text;
        ADOQuery1.Open;

        desencriptado:=encriptar(txtContrasenna.Text,10);

        if(ADOQuery1idUsuario.Value=StrToUInt(txtUsuario.Text)) and (ADOQuery1contrasennaUsuario.AsString=desencriptado) then
          begin
            ShowMessage('datos correctos');
            FormUsuario.show;
          end
        else
          begin
            ShowMessage('datos incorrectos');
            txtUsuario.Text:='';
            txtContrasenna.Text:='';
            txtUsuario.SetFocus;
          end;
      end;

  end;

end.
