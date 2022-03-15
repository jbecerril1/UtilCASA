unit uDm_Princ;

interface

uses
  System.SysUtils, System.Classes, uLib_UtilCASA, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite,
  FireDAC.Comp.UI, System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList,
  Vcl.Controls, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Vcl.ComCtrls, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDm_Princ = class(TDataModule)
    con_SqLite: TFDConnection;
    fdgxwtcrsr1: TFDGUIxWaitCursor;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    actlst_Menu: TActionList;
    imgl_16: TImageList;
    imgl_32: TImageList;
    act_NuevaConexion: TAction;
    act_NvoFolder: TAction;
    fdphysfbdrvrlnk1: TFDPhysFBDriverLink;
    qry_InsFolder: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure act_NuevaConexionExecute(Sender: TObject);
    procedure act_NvoFolderExecute(Sender: TObject);
  private    { Private declarations }
    procedure AgregaFolder(var TreeView: TTreeView; var Padre: TTreeNode; Caption: string; TIpo: TTipo);
  public    { Public declarations }
    procedure AgregaNodo(var TreeView: TTreeView; Padre: TTreeNode; TIpo: TTipo; IdHijo, IdPadre: integer);
  end;

var
  Dm_Princ: TDm_Princ;


implementation

uses
  uFm_Princ;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDm_Princ.act_NuevaConexionExecute(Sender: TObject);
var
  Nodo: TTreeNode;
begin
  Nodo := Fm_Princ.tv1.Selected;
  AgregaFolder(Fm_Princ.tv1, Nodo , 'Nueva Base', TBaseDatos);
end;

procedure TDm_Princ.act_NvoFolderExecute(Sender: TObject);
var
  Nodo: TTreeNode;
begin
  Nodo := Fm_Princ.tv1.Selected;
  AgregaFolder(Fm_Princ.tv1, Nodo, 'Nuevo Folder', TFolder);
end;

procedure TDm_Princ.AgregaFolder(var TreeView: TTreeView; var Padre: TTreeNode; Caption: string; TIpo: TTipo);
begin
  if Padre <> nil then begin
    if ptipo(Padre.Data).Tipo <> TFolder then
      raise Exception.Create('Error, no puedes agregar un contenedor.');
    qry_InsFolder.ParamByName('ID_PARENT').AsInteger := ptipo(Padre.Data).ID;
  end else
    qry_InsFolder.ParamByName('ID_PARENT').AsInteger := 0;
  if TIpo = TFolder then
    qry_InsFolder.ParamByName('TYPE_DATABASE').AsInteger := 0
  else
    qry_InsFolder.ParamByName('TYPE_DATABASE').AsInteger := 1;
    qry_InsFolder.ParamByName('ALIAS_DATABASE').AsString := Caption;
  qry_InsFolder.ExecSQL;
  Fm_Princ.InicializaArbol;
end;

procedure TDm_Princ.AgregaNodo(var TreeView: TTreeView; Padre: TTreeNode; TIpo: TTipo; IdHijo, IdPadre: Integer);
var
  Det: PTipo;
  Paso: Integer;
  Nodo: TTreeNode;
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  qry.ConnectionName := con_SqLite.ConnectionName;
  if IdPadre = -1 then begin
    qry.SQL.Text := //
      'SELECT'#13 + //
      ' D.ID_DATABASE,'#13 + //
      '	D.TYPE_DATABASE,'#13 + //
      '	D.ALIAS_DATABASE,'#13 + //
      '	D.ID_PARENT'#13 + //
      'FROM'#13 + //
      '	DATABASES D'#13 + //
      'WHERE'#13 + //
      '	D.ID_PARENT = :ID_PARENT'#13 + //
      'ORDER BY'#13 + //
      '	D.ID_DATABASE';
    qry.ParamByName('ID_PARENT').AsInteger := 0;
    qry.Open();
    while not qry.Eof do begin
      Nodo := TreeView.Items.AddChild(nil, qry.FieldByName('ALIAS_DATABASE').AsString);
      New(Det);
      Det.IDPadre := 0;
      Det.ID := qry.FieldByName('ID_DATABASE').AsInteger;
      if qry.FieldByName('TYPE_DATABASE').AsInteger = 0 then
        Det.Tipo := TFolder
      else
        Det.Tipo := TBaseDatos;
      case Det.TIpo of
        TFolder:
          Nodo.ImageIndex := 15;
        TBaseDatos:
          Nodo.ImageIndex := 0;
      end;
      Nodo.SelectedIndex := Nodo.ImageIndex;
      Nodo.StateIndex := Nodo.ImageIndex;
      Nodo.ExpandedImageIndex := Nodo.ImageIndex;
      Nodo.Expanded := True;
      Det.ImageIndex := Nodo.ImageIndex;
      Nodo.Data := Det;
      AgregaNodo(TreeView, Nodo, Det.Tipo, Det.ID, Det.ID);
      Nodo.Expanded := True;
      qry.next;
    end;
  end else begin
    qry.SQL.Text := //
      'SELECT'#13 + //
      ' D.ID_DATABASE,'#13 + //
      '	D.TYPE_DATABASE,'#13 + //
      '	D.ALIAS_DATABASE,'#13 + //
      '	D.ID_PARENT'#13 + //
      'FROM'#13 + //
      '	DATABASES D'#13 + //
      'WHERE'#13 + //
      '	D.ID_PARENT = :ID_PARENT'#13 + //
      'ORDER BY'#13 + //
      '	D.ID_DATABASE';
    qry.ParamByName('ID_PARENT').AsInteger := IdPadre;
    qry.Open();
      while not qry.Eof do begin
        New(Det);
        Det.ID := qry.FieldByName('ID_DATABASE').AsInteger;
        if Padre <> nil then
          Det.IDPadre := IdPadre
        else
          Det.IDPadre := 0;
        Nodo := TreeView.Items.AddChild(Padre, qry.FieldByName('ALIAS_DATABASE').AsString);
        if qry.FieldByName('TYPE_DATABASE').AsInteger = 0 then
          Det.Tipo := TFolder
        else
          Det.Tipo := TBaseDatos;
        case Det.TIpo of
          TFolder:
            Nodo.ImageIndex := 15;
          TBaseDatos:
            Nodo.ImageIndex := 0;
        end;
        Nodo.SelectedIndex := Nodo.ImageIndex;
        Nodo.StateIndex := Nodo.ImageIndex;
        Nodo.ExpandedImageIndex := Nodo.ImageIndex;
        Nodo.Expanded := True;
        Det.ImageIndex := Nodo.ImageIndex;
        Nodo.Data := Det;
        AgregaNodo(TreeView, Nodo, Det.Tipo, qry.FieldByName('ID_DATABASE').AsInteger, Det.ID);
        Nodo.Expanded := True;
        qry.next;
      end;
  end;
  qry.Close;
  qry.Free;
end;

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
    Log('Conexión establecida: ' + con_SqLite.Params.Database);
  except
    on e: exception do begin
      Log('Error al abrir la base de datos: ' + e.Message);
    end;
  end;
end;

end.

