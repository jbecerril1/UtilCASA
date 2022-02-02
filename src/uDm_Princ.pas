unit uDm_Princ;

interface

uses
  System.SysUtils, System.Classes, uLib_UtilCASA, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.UI;

type
  TDm_Princ = class(TDataModule)
    con_SqLite: TFDConnection;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm_Princ: TDm_Princ;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDm_Princ.DataModuleCreate(Sender: TObject);
begin
/// <summary>
///Inicializacion del sistema
/// </summary>
  Proyecto.Siglas := 'UtilCASA';
/// <summary>
///   Configuración de base de datos SQLite
/// </summary>
  try
    FDPhysSQLiteDriverLink1.VendorHome := Proyecto.Ruta;
    FDPhysSQLiteDriverLink1.VendorLib := 'sqlite3.dll';
    con_SqLite.Params.Database := 'UtilCASA.db';
    con_SqLite.Open();
  except
    on e:exception do begin
      Log('Error al abrir la base de datos: ' + e.Message);
    end;
  end;
end;

end.
