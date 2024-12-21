(******************************************************************************

 Criado pelo Professor Giovani Da Cruz

 https://giovanidacruz.com.br

*******************************************************************************)
program PrjAtributos;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.RTTI,
  ValidacaoAttributeUnit in 'ValidacaoAttributeUnit.pas';

type
  { Classe de Exemplo }
  TMinhaClasse = class
  private
    FNome: string;
  public
    // Aplicando o atributo de validação
    [Validacao('O campo Nome é obrigatório.')]
    property Nome: string read FNome write FNome;
  end;

procedure ValidarPropriedades(Objeto: TObject);
var
  Contexto: TRttiContext;
  TipoRtti: TRttiType;
  Propriedade: TRttiProperty;
  Atributo: TCustomAttribute;
begin
  Contexto := TRttiContext.Create;
  try
    TipoRtti := Contexto.GetType(Objeto.ClassType);

    // Itera sobre as propriedades da classe
    for Propriedade in TipoRtti.GetProperties do
    begin
      // Verifica se a propriedade tem o atributo de validação
      for Atributo in Propriedade.GetAttributes do
      begin
        if Atributo is ValidacaoAttribute then
        begin
          { Se o valor da propriedade estiver vazio,
          lança uma exceção com a mensagem do atributo }
          if Propriedade.GetValue(Objeto).ToString = '' then
            raise Exception.Create(ValidacaoAttribute(Atributo).Mensagem);
        end;
      end;
    end;
  finally
    Contexto.Free;
  end;
end;


var
  Obj: TMinhaClasse;
begin

  Obj := TMinhaClasse.Create;
  try

    { Caso de validação com erros --------------------- }
    Obj.Nome := ''; // Propriedade sem valor

    try
      ValidarPropriedades(Obj); // Chama a validação
    except
      on E: Exception do
        Writeln(E.Message); // Exibe a mensagem de erro: "O campo Nome é obrigatório."
    end;

    { Caso de validação OK ---------------- }
    Obj.Nome := 'Giovani'; // Propriedade com Valor

    try
      ValidarPropriedades(Obj); // Chama a validação, que deverá funcionar
    except
      on E: Exception do
        Writeln(E.Message); // sem erros
    end;

  finally
    Obj.Free;
  end;

  Readln;
end.
