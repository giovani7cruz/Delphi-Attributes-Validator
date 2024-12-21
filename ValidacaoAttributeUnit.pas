(******************************************************************************

 Criado pelo Professor Giovani Da Cruz

 https://giovanidacruz.com.br


 Nesta unidade vamos colocar nossas validações personalizadas

*******************************************************************************)

unit ValidacaoAttributeUnit;

interface

uses
  System.SysUtils, System.Classes;

type
  ValidacaoAttribute = class(TCustomAttribute)
  private
    FMensagem: string;
  public
    constructor Create(const Mensagem: string);
    property Mensagem: string read FMensagem;
  end;

implementation

{ ValidacaoAttribute }

constructor ValidacaoAttribute.Create(const Mensagem: string);
begin
  FMensagem := Mensagem;
end;

end.
