program UtilCASA_V2;

uses
  Vcl.Forms,
  uFm_Princ in 'src\uFm_Princ.pas' {Fm_Princ};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFm_Princ, Fm_Princ);
  Application.Run;
end.
