unit uFm_Princ;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ToolWin, Vcl.ComCtrls, Vcl.Menus, Vcl.ExtCtrls, Vcl.Tabs, Vcl.DockTabSet,
  Vcl.StdCtrls;

type
  TFm_Princ = class(TForm)
    stat1: TStatusBar;
    mm1: TMainMenu;
    tlb1: TToolBar;
    pnl_db: TPanel;
    BasedeDatos1: TMenuItem;
    NuevaConexin1: TMenuItem;
    spl1: TSplitter;
    pnl_Cnt: TPanel;
    tv1: TTreeView;
    pgc_Det: TPageControl;
    spl2: TSplitter;
    pm_db: TPopupMenu;
    NuevaConexin2: TMenuItem;
    ts_propiedades: TTabSheet;
    ts_2: TTabSheet;
    DockTabSet1: TDockTabSet;
    pnl_Dock: TPanel;
    lv_campos: TListView;
    NuevaCarpeta1: TMenuItem;
    N1: TMenuItem;
    mmo_1: TMemo;
    btnNvoFolder: TToolButton;
    btnNuevaConexion: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure tv1Click(Sender: TObject);
    procedure pm_dbPopup(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InicializaArbol;
  end;

var
  Fm_Princ: TFm_Princ;

implementation

uses
  uDm_Princ, uLib_UtilCASA, uFm_RegFolder;

{$R *.dfm}

procedure TFm_Princ.FormCreate(Sender: TObject);
begin
  InicializaArbol;
end;

procedure TFm_Princ.InicializaArbol;
  procedure LiberarArbol(arbol: TTreeView);
  var
    i: integer;
  begin
    for i := arbol.Items.Count - 1 downto 0 do begin
      Dispose(arbol.Items[i].Data);
    end;
    arbol.Items.Clear;
  end;
begin
  LiberarArbol(tv1);
  Dm_Princ.AgregaNodo(tv1, nil, TFolder, 0, -1);
  tv1.AutoExpand := True;
end;

procedure TFm_Princ.pm_dbPopup(Sender: TObject);
begin
  if tv1.Selected <> nil then begin
    case PTipo(tv1.Selected.Data).Tipo of
      TFolder: Begin
        Dm_Princ.act_NvoFolder.Enabled := True;
        Dm_Princ.act_NvoFolder.Visible := True;

      End;
      TBaseDatos: Begin
        Dm_Princ.act_NvoFolder.Enabled := False;
        Dm_Princ.act_NvoFolder.Visible := False;
      End;

    end;
  end;

end;

procedure TFm_Princ.tv1Click(Sender: TObject);
begin
  mmo_1.lines.Clear;
  if tv1.Selected <> nil then begin
    mmo_1.Lines.Add('ID : ' + PTipo(tv1.Selected.Data).ID.ToString);
    mmo_1.Lines.Add('Tipo : ' + TTipoToString(PTipo(tv1.Selected.Data).Tipo));
    mmo_1.Lines.Add('IdPadre : ' + PTipo(tv1.Selected.Data).IDPadre.ToString);
    mmo_1.Lines.Add('Image Index : ' + PTipo(tv1.Selected.Data).ImageIndex.ToString);
  end;
end;

end.
