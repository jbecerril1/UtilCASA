object Fm_RegFolder: TFm_RegFolder
  Left = 0
  Top = 0
  Caption = 'Fm_RegFolder'
  ClientHeight = 238
  ClientWidth = 750
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 15
  object upd_ObtDB: TFDUpdateSQL
    ConnectionName = 'UtilCasaSQLite'
    InsertSQL.Strings = (
      'INSERT INTO DATABASES'
      '(TYPE_DATABASE, ALIAS_DATABASE, TYPE_CON, SERVER_NAME, '
      '  SERVER_PORT, LIB_PATH, SERVER_USER, SERVER_PASS, '
      '  ID_PARENT)'
      
        'VALUES (:NEW_TYPE_DATABASE, :NEW_ALIAS_DATABASE, :NEW_TYPE_CON, ' +
        ':NEW_SERVER_NAME, '
      
        '  :NEW_SERVER_PORT, :NEW_LIB_PATH, :NEW_SERVER_USER, :NEW_SERVER' +
        '_PASS, '
      '  :NEW_ID_PARENT);'
      'SELECT LAST_INSERT_AUTOGEN() AS ID_DATABASE')
    ModifySQL.Strings = (
      'UPDATE DATABASES'
      
        'SET TYPE_DATABASE = :NEW_TYPE_DATABASE, ALIAS_DATABASE = :NEW_AL' +
        'IAS_DATABASE, '
      '  TYPE_CON = :NEW_TYPE_CON, SERVER_NAME = :NEW_SERVER_NAME, '
      '  SERVER_PORT = :NEW_SERVER_PORT, LIB_PATH = :NEW_LIB_PATH, '
      
        '  SERVER_USER = :NEW_SERVER_USER, SERVER_PASS = :NEW_SERVER_PASS' +
        ', '
      '  ID_PARENT = :NEW_ID_PARENT'
      'WHERE ID_DATABASE = :OLD_ID_DATABASE;'
      'SELECT ID_DATABASE'
      'FROM DATABASES'
      'WHERE ID_DATABASE = :NEW_ID_DATABASE')
    DeleteSQL.Strings = (
      'DELETE FROM DATABASES'
      'WHERE ID_DATABASE = :OLD_ID_DATABASE')
    FetchRowSQL.Strings = (
      
        'SELECT ID_DATABASE, TYPE_DATABASE, ALIAS_DATABASE, TYPE_CON, SER' +
        'VER_NAME, '
      '  SERVER_PORT, LIB_PATH, SERVER_USER, SERVER_PASS, ID_PARENT'
      'FROM DATABASES'
      'WHERE ID_DATABASE = :OLD_ID_DATABASE')
    Left = 536
    Top = 168
  end
  object qry_ObtDB: TFDQuery
    Active = True
    BeforeOpen = qry_ObtDBBeforeOpen
    Connection = Dm_Princ.con_SqLite
    UpdateObject = upd_ObtDB
    SQL.Strings = (
      'select * from databases where id_database = :id_database')
    Left = 128
    Top = 152
    ParamData = <
      item
        Name = 'ID_DATABASE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 1
      end>
    object qry_ObtDBID_DATABASE: TFDAutoIncField
      FieldName = 'ID_DATABASE'
      Origin = 'ID_DATABASE'
      ProviderFlags = [pfInWhere, pfInKey]
    end
    object qry_ObtDBTYPE_DATABASE: TIntegerField
      FieldName = 'TYPE_DATABASE'
      Origin = 'TYPE_DATABASE'
    end
    object qry_ObtDBALIAS_DATABASE: TWideStringField
      FieldName = 'ALIAS_DATABASE'
      Origin = 'ALIAS_DATABASE'
      Required = True
      Size = 60
    end
    object qry_ObtDBTYPE_CON: TIntegerField
      FieldName = 'TYPE_CON'
      Origin = 'TYPE_CON'
      Required = True
    end
    object qry_ObtDBSERVER_NAME: TWideStringField
      FieldName = 'SERVER_NAME'
      Origin = 'SERVER_NAME'
      Size = 150
    end
    object qry_ObtDBSERVER_PORT: TIntegerField
      FieldName = 'SERVER_PORT'
      Origin = 'SERVER_PORT'
    end
    object qry_ObtDBLIB_PATH: TWideStringField
      FieldName = 'LIB_PATH'
      Origin = 'LIB_PATH'
      Size = 256
    end
    object qry_ObtDBSERVER_USER: TWideStringField
      FieldName = 'SERVER_USER'
      Origin = 'SERVER_USER'
      Size = 24
    end
    object qry_ObtDBSERVER_PASS: TWideStringField
      FieldName = 'SERVER_PASS'
      Origin = 'SERVER_PASS'
      Size = 24
    end
    object qry_ObtDBID_PARENT: TIntegerField
      FieldName = 'ID_PARENT'
      Origin = 'ID_PARENT'
      Required = True
    end
  end
  object ds_1: TDataSource
    DataSet = qry_ObtDB
    Left = 488
    Top = 72
  end
end
