unit uLib_UtilCASA;

interface

uses
  System.Classes, Vcl.StdCtrls, System.TypInfo,
  ///Clases para manejo de BD
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FireDAC.Comp.UI,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB;


/// <summary>
///   Clases Base
/// </summary>
type
  TUtilCASA = class
  private
    FRuta: string;
    FPCName: string;
    FPCUser: string;
    FSiglas: string;
    procedure SetSiglas(const Value: string);
  public
    property Ruta: string read FRuta;
    property PCName: string read FPCName;
    property PCUser: string read FPCUser;
    property Siglas: string read FSiglas write SetSiglas;
    constructor Create;
  end;
/// <summary>
///   Definicion de tipos para tipo de objeto
/// </summary>
  TTipo = (TFolder, TBaseDatos, TTabla, TTrigger, TGenerador);

/// <summary>
/// Definicion de puntero para identificar tipos de objetos
/// </summary>
  RTipo = record
    ID: Integer;
    Tipo: TTipo;
    IDPadre: Integer;
    BDCon: TFDConnection;
    ImageIndex: Integer;
  end;

  PTipo = ^RTipo ;

/// <summary>
///   Funciones generales
/// </summary>

procedure Log(Mensaje: string);
function TTipoToString( value: TTipo): string;

var
  Proyecto: TUtilCASA;
  memoLOG: TMemo;


implementation

uses
  System.SysUtils, Winapi.Windows;

{$REGION 'Funciones publicas generales'}
procedure Log(Mensaje: string);
var
  ArchLog: string;
  F: TextFile;
begin
  try
    ForceDirectories(ExtractFilePath(ParamStr(0)) + 'logs\');
    if Assigned(Proyecto) and (Proyecto.Siglas <> '') then
      ArchLog := ExtractFilePath(ParamStr(0)) + 'logs\log_' + Proyecto.Siglas + '_' + FormatDateTime('ddmmyyyy', Now) + '.log'
    else
      ArchLog := ExtractFilePath(ParamStr(0)) + 'logs\log_' + FormatDateTime('ddmmyyyy', Now) + '.log';
    AssignFile(F, ArchLog);
    if memoLOG <> nil then begin
      if FileExists(ArchLog) and (memoLOG.Lines.Count = 0) then
        memoLOG.Lines.LoadFromFile(ArchLog);
      memoLOG.Lines.Add(PChar(FormatDateTime('[dd/mm/yyyy hh:nn:ss] : ' + #9, now) + Mensaje));
    end;
    {$I-}
    if FileExists(ArchLog) then
      Append(F)
    else
      Rewrite(F);
    {$I+}
    if IOResult = 0 then begin
      if Mensaje = '' then
        writeln(F, PChar(''))
      else
        writeln(F, PChar(FormatDateTime('[dd/mm/yyyy hh:nn:ss] : ' + #9, now) + Mensaje));
    end;
    CloseFile(F);
  except

  end;
end;

function TTipoToString( value: TTipo ): string;
begin
    result := GetEnumName(typeInfo(TTipo ), Ord(value));
end;
{$ENDREGION}

{ TUtilCASA }

function GetComputerNameFromWindows: string;
var
  iLen: Cardinal;
begin
  iLen := MAX_COMPUTERNAME_LENGTH + 1;
  Result := StringOfChar(#0, iLen);
  GetComputerName(PChar(Result), iLen);
  SetLength(Result, iLen);
end;

function GetUserFromWindows: string;
var
  iLen: Cardinal;
begin
  iLen := 256;
  Result := StringOfChar(#0, iLen);
  GetUserName(PChar(Result), iLen);
  SetLength(Result, iLen);
end;

constructor TUtilCASA.Create;
begin
  FRuta := ExtractFilePath(ParamStr(0));
  FPCName := GetComputerNameFromWindows;
  FPCUser := GetUserFromWindows;
end;

procedure TUtilCASA.SetSiglas(const Value: string);
begin
  FSiglas := Value;
end;

initialization
  Proyecto := TUtilCASA.Create;

end.

