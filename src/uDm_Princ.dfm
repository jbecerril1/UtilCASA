object Dm_Princ: TDm_Princ
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  PixelsPerInch = 96
  object con_SqLite: TFDConnection
    ConnectionName = 'UtilCasaSQLite'
    Params.Strings = (
      'Database=F:\Proyectos11\UtilCASA\Win32\Debug\UtilCASA.db'
      'DriverID=SQLite')
    Left = 104
    Top = 24
  end
  object fdgxwtcrsr1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 384
    Top = 24
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    VendorLib = 'sqlite3.dll'
    Left = 248
    Top = 24
  end
end
