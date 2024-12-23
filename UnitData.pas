unit UnitData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  RESTRequest4D, REST.Types, System.JSON, System.DateUtils, Vcl.Dialogs, Winapi.Windows;

type
  TData = class(TDataModule)
    memCovid: TFDMemTable;
    memCovidCOUNTRY: TStringField;
    memCovidCONFIRMED: TIntegerField;
    memCovidCASES: TIntegerField;
    memCovidDEATHS: TIntegerField;
    memCovidRECOVERED: TIntegerField;
    memCovidUPDATED_AT: TStringField;
    DataSource1: TDataSource;
    function VerificaConexaoAPI : Boolean;
    function ListarCasosPais : Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Data: TData;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UnitPrincipal;

{$R *.dfm}



{ TData }

function TData.ListarCasosPais: Boolean;
var
  LResponse: IResponse;
  LJsonValue: TJSONValue;
  LJsonArray: TJSONArray;
  LJsonObject: TJSONObject;
  I: Integer;
  FilterText: string;
  UpdatedAt: TDateTime;
begin
  Try
    Result := False;
    if UnitData.Data.VerificaConexaoAPI then
    begin
      // Verifica se o memCovid est� ativo
      if not UnitData.Data.memCovid.Active then
        UnitData.Data.memCovid.Open
      else
      begin
        // Limpa os dados e mant�m a estrutura
        UnitData.Data.memCovid.EmptyDataSet;
      end;
      // Faz a requisi��o para a API
      LResponse := TRequest.New.BaseURL('https://covid19-brazil-api.now.sh/api/report/v1/countries')
        .Accept('application/json')
        .Get;

      if LResponse.StatusCode = 200 then
      begin
        // Analisa o JSON de retorno
        LJsonValue := TJSONObject.ParseJSONValue(LResponse.Content);
        try
          if (LJsonValue <> nil) and (LJsonValue is TJSONObject) then
          begin
            LJsonArray := TJSONObject(LJsonValue).GetValue<TJSONArray>('data');

            // Preenche o MemTable com os dados do JSON
            for I := 0 to LJsonArray.Count - 1 do
            begin
              LJsonObject := LJsonArray.Items[I] as TJSONObject;
              UnitData.Data.memCovid.Append;
              UnitData.Data.memCovid.FieldByName('COUNTRY').AsString     := LJsonObject.GetValue<string>('country','');
              UnitData.Data.memCovid.FieldByName('CONFIRMED').AsInteger  := LJsonObject.GetValue<Integer>('confirmed',0);
              UnitData.Data.memCovid.FieldByName('CASES').AsInteger      := LJsonObject.GetValue<Integer>('cases',0);
              UnitData.Data.memCovid.FieldByName('DEATHS').AsInteger     := LJsonObject.GetValue<Integer>('deaths',0);
              UnitData.Data.memCovid.FieldByName('RECOVERED').AsInteger  := LJsonObject.GetValue<Integer>('recovered',0);

              // Tratamento da data
              if LJsonObject.GetValue<string>('updated_at', '') <> '' then
              begin
                // Converte a string da data para o formato TDateTime
                UpdatedAt := ISO8601ToDate(LJsonObject.GetValue<string>('updated_at', ''));
                UnitData.Data.memCovid.FieldByName('UPDATED_AT').AsDateTime := UpdatedAt;
              end;

              UnitData.Data.memCovid.Post;
            end;
          end;
          Result := True;
        finally
          LJsonValue.Free;
        end;
      end
      else
        ShowMessage('Erro ao acessar API: ' + LResponse.StatusCode.ToString);
    end
    else
      ShowMessage('API indispon�vel.');
  Except
    on E: Exception do
    begin
      // Exibe uma mensagem de erro para o usu�rio
      ShowMessage('N�o foi poss�vel acessar os dados no momento. Verifique sua conex�o com a internet ou tente novamente mais tarde.');
      // Registra o erro no log ou na sa�da de depura��o
      {$IFDEF DEBUG}
      OutputDebugString(PChar('Erro em Button1Click: ' + E.Message));
      {$ENDIF}
    end;
  End;
end;

function TData.VerificaConexaoAPI: Boolean;
var
  LResponse: IResponse;
begin
  Result := False;

  LResponse := TRequest.New.BaseURL('https://covid19-brazil-api.now.sh/api/status/v1')
    .Accept('application/json')
    .Get;

  if LResponse.StatusCode = 200 then
  begin
    Result := True;
  end;
end;

end.
