program UtilCASA_V2;

uses
  Vcl.Forms,
  uFm_Princ in 'src\uFm_Princ.pas' {Fm_Princ},
  uDm_Princ in 'src\uDm_Princ.pas' {Dm_Princ: TDataModule},
  uLib_UtilCASA in 'lib\uLib_UtilCASA.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFm_Princ, Fm_Princ);
  Application.CreateForm(TDm_Princ, Dm_Princ);
  Application.Run;
end.
