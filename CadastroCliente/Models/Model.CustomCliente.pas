unit Model.CustomCliente;

interface

uses
  System.Classes, System.SysUtils, Model.CustomBase, Model.CustomEndereco;

type
  TrCustomCliente = class(TrCustomBase)
  private
    FEndereco: TrCustomEndereco;
    FNome: string;
    FIdentidade: string;
    FCPF: string;
    FTelefone: string;
    FEmail: string;
  public
    constructor Create(AOwner: TObject); override;
    destructor Destroy; override;

    property Nome: string read FNome write FNome;
    property Identidade: string read FIdentidade write FIdentidade;
    property CPF: string read FCPF write FCPF;
    property Telefone: string read FTelefone write FTelefone;
    property Email: string read FEmail write FEmail;
    property Endereco: TrCustomEndereco read FEndereco write FEndereco;
  end;

implementation

{ TpCustomCliente }

constructor TrCustomCliente.Create(AOwner: TObject);
begin
  inherited Create(AOwner);

  FEndereco := TrCustomEndereco.Create(Self);
end;

destructor TrCustomCliente.Destroy;
begin
  FreeAndNil(FEndereco);
  inherited;
end;

end.
