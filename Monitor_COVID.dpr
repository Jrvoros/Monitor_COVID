program Monitor_COVID;

uses
  Vcl.Forms,
  UnitPrincipal in 'UnitPrincipal.pas' {untPrincipal},
  UnitData in 'UnitData.pas' {Data: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TuntPrincipal, untPrincipal);
  Application.CreateForm(TData, Data);
  Application.Run;
end.