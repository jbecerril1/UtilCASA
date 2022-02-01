unit uLib_UtilCASA;

interface

uses
  System.Classes;

type
  TUtilCASA = class
  private
    FRuta: string;
    FPCName: string;
    FPCUser: string;
  public
    property Ruta: string read FRuta;
    property PCName: string read FPCName;
    property PCUser: string read FPCUser;
    constructor Create;
  end;

implementation

uses
  System.SysUtils, Winapi.Windows;

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


end.
