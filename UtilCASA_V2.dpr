program UtilCASA_V2;

uses
  Vcl.Forms,
  uFm_Princ in 'src\uFm_Princ.pas' {Fm_Princ},
  uDm_Princ in 'src\uDm_Princ.pas' {Dm_Princ: TDataModule},
  uLib_UtilCASA in 'lib\uLib_UtilCASA.pas',
  UFrm_BaseHor in 'lib\forms\UFrm_BaseHor.pas' {FrmEdicionHor: TFrame},
  UFrm_BaseVer in 'lib\forms\UFrm_BaseVer.pas' {FrmEdicionVer: TFrame},
  uFm_RegFolder in 'src\uFm_RegFolder.pas' {Fm_RegFolder};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDm_Princ, Dm_Princ);
  Application.CreateForm(TFm_Princ, Fm_Princ);
  Application.Run;
end.
