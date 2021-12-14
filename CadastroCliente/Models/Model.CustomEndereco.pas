unit Model.CustomEndereco;

interface

uses
  System.Classes, System.SysUtils, Model.CustomBase;

type
  TrCustomEndereco = class(TrCustomBase)
  private
    FCep: string;
    FLogradouro: string;
    FNumero: integer;
    FComplemento: string;
    FBairro: string;
    FCidade: string;
    FEstado: string;
    FPais: string;
  public
    constructor Create(AOwner: TObject); override;

    property Cep: string read FCep write FCep;
    property Logradouro: string read FLogradouro write FLogradouro;
    property Numero: integer read FNumero write FNumero;
    property Complemento: string read FComplemento write FComplemento;
    property Bairro: string read FBairro write FBairro;
    property Cidade: string read FCidade write FCidade;
    property Estado: string read FEstado write FEstado;
    property Pais: string read FPais write FPais;
  end;

implementation

{ TpCustomEndereco }

constructor TrCustomEndereco.Create(AOwner: TObject);
begin
  inherited Create(AOwner);

  FPais := 'Brasil';
end;

end.
