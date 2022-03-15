unit uFm_RegFolder;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Param,
  FireDAC.Phys.Intf, FireDAC.Comp.Client, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet;

type
  TFm_RegFolder = class(TForm)
    upd_ObtDB: TFDUpdateSQL;
    qry_ObtDB: TFDQuery;
    qry_ObtDBID_DATABASE: TFDAutoIncField;
    qry_ObtDBTYPE_DATABASE: TIntegerField;
    qry_ObtDBALIAS_DATABASE: TWideStringField;
    qry_ObtDBTYPE_CON: TIntegerField;
    qry_ObtDBSERVER_NAME: TWideStringField;
    qry_ObtDBSERVER_PORT: TIntegerField;
    qry_ObtDBLIB_PATH: TWideStringField;
    qry_ObtDBSERVER_USER: TWideStringField;
    qry_ObtDBSERVER_PASS: TWideStringField;
    qry_ObtDBID_PARENT: TIntegerField;
    ds_1: TDataSource;
    procedure qry_ObtDBBeforeOpen(DataSet: TDataSet);
  private
    FID_DATABASE: Integer;
    procedure SetID_DATABASE(const Value: Integer);
    { Private declarations }
  public
    { Public declarations }
    property ID_DATABASE: Integer read FID_DATABASE write SetID_DATABASE;
  end;

var
  Fm_RegFolder: TFm_RegFolder;

implementation

{$R *.dfm}

procedure TFm_RegFolder.qry_ObtDBBeforeOpen(DataSet: TDataSet);
begin
  qry_ObtDB.ParamByName('ID_DATABASE').AsInteger := FID_DATABASE;
end;

procedure TFm_RegFolder.SetID_DATABASE(const Value: Integer);
begin
  FID_DATABASE := Value;
end;

end.
