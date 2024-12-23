unit UnitPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, RESTRequest4D, REST.Types, System.JSON, System.DateUtils;

type
  TuntPrincipal = class(TForm)
    DBGrid1: TDBGrid;
    btnBuscar: TButton;
    Panel1: TPanel;
    rgOrdenar: TRadioGroup;
    Panel2: TPanel;
    edtPais: TEdit;
    Label1: TLabel;
    procedure btnBuscarClick(Sender: TObject);
    procedure rgOrdenarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  untPrincipal: TuntPrincipal;

implementation

{$R *.dfm}

uses UnitData;

procedure TuntPrincipal.btnBuscarClick(Sender: TObject);
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
    if UnitData.Data.ListarCasosPais then
    begin
      // Move o cursor para o primeiro registro ap�s o preenchimento
      if not UnitData.Data.memCovid.IsEmpty then
        UnitData.Data.memCovid.First;

      FilterText := Trim(edtPais.Text);
      if FilterText <> '' then
      begin
        // Aplica o filtro para buscar pelo nome do pa�s (case-insensitive)
        UnitData.Data.memCovid.Filter := Format('UPPER(COUNTRY) LIKE ''%%%s%%''', [UpperCase(FilterText)]);
        UnitData.Data.memCovid.Filtered := True;

        if UnitData.Data.memCovid.RecordCount = 0 then
          ShowMessage('Nenhum pa�s encontrado com esse nome.');
      end
      else
        UnitData.Data.memCovid.Filtered := False;
    end;
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

procedure TuntPrincipal.rgOrdenarClick(Sender: TObject);
begin
  if not UnitData.Data.memCovid.Active then
    Exit;

  case rgOrdenar.ItemIndex of
    0: // Casos Confirmados
      UnitData.Data.memCovid.IndexFieldNames := 'CONFIRMED';
    1: // Mortes
      UnitData.Data.memCovid.IndexFieldNames := 'DEATHS';
    2: // Recuperados
      UnitData.Data.memCovid.IndexFieldNames := 'RECOVERED';
  else
    UnitData.Data.memCovid.IndexFieldNames := ''; // Sem ordena��o
  end;
  // Move o cursor para o primeiro registro ap�s o preenchimento
  if not UnitData.Data.memCovid.IsEmpty then
    UnitData.Data.memCovid.First;
end;

end.
