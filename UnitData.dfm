object Data: TData
  Height = 193
  Width = 361
  object memCovid: TFDMemTable
    CachedUpdates = True
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 144
    Top = 72
    object memCovidCOUNTRY: TStringField
      DisplayLabel = 'PA'#205'S'
      FieldName = 'COUNTRY'
      Size = 40
    end
    object memCovidCONFIRMED: TIntegerField
      DisplayLabel = 'CONFIRMADOS'
      FieldName = 'CONFIRMED'
      DisplayFormat = '#,##0'
    end
    object memCovidCASES: TIntegerField
      DisplayLabel = 'CASOS'
      FieldName = 'CASES'
      DisplayFormat = '#,##0'
    end
    object memCovidDEATHS: TIntegerField
      DisplayLabel = 'MORTES'
      FieldName = 'DEATHS'
      DisplayFormat = '#,##0'
    end
    object memCovidRECOVERED: TIntegerField
      DisplayLabel = 'RECUPERADOS'
      FieldName = 'RECOVERED'
      DisplayFormat = '#,##0'
    end
    object memCovidUPDATED_AT: TStringField
      DisplayLabel = 'ATUALIZADO EM'
      FieldName = 'UPDATED_AT'
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = memCovid
    Left = 216
    Top = 72
  end
end
