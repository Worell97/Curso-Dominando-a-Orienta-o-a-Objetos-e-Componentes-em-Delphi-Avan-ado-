{ *******************************************************************************
  Empresa.....: ECO Sistemas Informática
  Sistema.....: DataModule : Sistema eco
  Analista....: teio2
  Programador.: TODOS
  Data criação: 26/jun/2001
  Módulo......:
  Função......:
  Obs.........:

  Histórico de alteração:
  ----------------------
  18-ago-02 - leitura no arquivo .ini dos parametros para ECF
  28-Ago-02 - ajustes para abertura em LINUX
  22/06/2005- teio-testes de abertura.
  14/09/2006- Teio-comissoes
  ******************************************************************************* }

Unit DataModule;

interface

uses
   unitParametrosEco, // unitVendedoresComissoes,
   Windows, Messages, Classes, Aurelius.Engine.ObjectManager,Aurelius.Drivers.FireDac,
   Graphics, Controls, Forms, Dialogs, Sysutils, IniFiles, SqlExpr, DB,
   IBServices, IBDatabase, FMTBcd, DnMenu, Geral, DBClient, ImgList, WideStrings,
   DBXCommon, Data.DBXInterBase, System.ImageList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
   FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
   FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
   FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase,
   Utilitarios, uEcoFDTransaction, Aurelius.Commands.Listeners, uTEstProdutoImagemPost, uTEstProdutoImagemPostDeletada,
   Aurelius.Drivers.Interfaces, Aurelius.Mapping.Setup, Aurelius.Engine.DatabaseManager, Aurelius.Mapping.Explorer,
   Aurelius.Sql.PostgreSQL, Aurelius.Schema.PostgreSQL, UControllerConexao, Math;

type
   TFDataModule = class(TDataModule)
      CDSFichaCliente: TClientDataSet;
      CDSFichaClienteSEQUENCIA: TIntegerField;
      CDSFichaClienteEMPRESA: TIntegerField;
      CDSFichaClienteCLIENTE: TIntegerField;
      CDSFichaClienteIDMOVIMENTO: TIntegerField;
      CDSFichaClienteIDENTIFICADOR: TIntegerField;
      CDSFichaClienteIDREGISTRADORA: TIntegerField;
      CDSFichaClienteIDPERIODO: TIntegerField;
      CDSFichaClienteIDCAIXA: TIntegerField;
      CDSFichaClienteDATACAIXA: TDateField;
      CDSFichaClienteHISTORICO: TStringField;
      CDSFichaClienteTIPO: TStringField;
      CDSFichaClienteVALOR: TFloatField;
      CDSFichaClienteUSUARIO: TStringField;
      CDSFichaFornecedor: TClientDataSet;
      CDSFichaFornecedorSEQUENCIA: TIntegerField;
      CDSFichaFornecedorEMPRESA: TIntegerField;
      CDSFichaFornecedorFORNECEDOR: TIntegerField;
      CDSFichaFornecedorIDMOVIMENTO: TIntegerField;
      CDSFichaFornecedorIDENTIFICADOR: TIntegerField;
      CDSFichaFornecedorIDREGISTRADORA: TIntegerField;
      CDSFichaFornecedorIDPERIODO: TIntegerField;
      CDSFichaFornecedorIDCAIXA: TIntegerField;
      CDSFichaFornecedorDATACAIXA: TDateField;
      CDSFichaFornecedorHISTORICO: TStringField;
      CDSFichaFornecedorTIPO: TStringField;
      CDSFichaFornecedorVALOR: TFloatField;
      CDSFichaFornecedorUSUARIO: TStringField;
      CDSRegistroForma: TClientDataSet;
      CDSRegistroFormaEMPRESA: TStringField;
      CDSRegistroFormaIDREGISTRO: TIntegerField;
      CDSRegistroFormaTIPOREGISTRO: TSmallintField;
      CDSRegistroFormaIDENTIFICADOR: TIntegerField;
      CDSRegistroFormaTIPOVALOR: TSmallintField;
      CDSRegistroFormaVALOR: TCurrencyField;
      CDSRegistroFormaIDCHEQUE: TIntegerField;
      ImageList1: TImageList;
      cdsBloqueioLiberado: TClientDataSet;
      cdsBloqueioLiberadoID: TIntegerField;
      cdsBloqueioLiberadoControle: TIntegerField;
      cdsBloqueioLiberadoData: TDateField;
      cdsBloqueioLiberadoHora: TTimeField;
      cdsBloqueioLiberadoStatus: TStringField;
      cdsBloqueioLiberadoTipo: TIntegerField;
      cdsBloqueioLiberadoCodVendedor: TStringField;
      cdsBloqueioLiberadoUsuario: TStringField;
      cdsBloqueioLiberadoCodigo: TStringField;
      cdsBloqueioLiberadoCliente: TStringField;
      cdsBloqueioLiberadoProduto: TStringField;
      cdsBloqueioLiberadoDocumento: TStringField;
      cdsBloqueioLiberadoParcela: TStringField;
      cdsBloqueioLiberadoValorJuros: TCurrencyField;
      cdsBloqueioLiberadoDescJuros: TCurrencyField;
      cdsBloqueioLiberadoPercMaxJuros: TCurrencyField;
      cdsBloqueioLiberadoPercReducaoJuros: TCurrencyField;
      cdsBloqueioLiberadoValorMulta: TCurrencyField;
      cdsBloqueioLiberadoDescMulta: TCurrencyField;
      cdsBloqueioLiberadoPercMaxMulta: TCurrencyField;
      cdsBloqueioLiberadoPercReducaoMulta: TCurrencyField;
      cdsBloqueioLiberadoValorDesconto: TCurrencyField;
      cdsBloqueioLiberadoPercMaxDescDocumento: TCurrencyField;
      cdsBloqueioLiberadoTotalDaVenda: TCurrencyField;
      cdsBloqueioLiberadoObs: TStringField;
      cdsBloqueioLiberadoPercMaxDescProduto: TCurrencyField;
      cdsBloqueioLiberadoPercDescProduto: TCurrencyField;
      cdsBloqueioLiberadoQtdeVendida: TCurrencyField;
      cdsBloqueioLiberadoCondicaoPagto: TStringField;
      cdsBloqueioLiberadoPrecoVendido: TCurrencyField;
      cdsBloqueioLiberadoValorJuroCap: TCurrencyField;
      cdsBloqueioLiberadoDescJuroCap: TCurrencyField;
      cdsBloqueioLiberadoPercMaxJuroCap: TCurrencyField;
      cdsBloqueioLiberadoPercReducaoJuroCap: TCurrencyField;
      cdsBloqueioLiberadoLucroValor: TCurrencyField;
      cdsBloqueioLiberadoLucroPerc: TCurrencyField;
      CDSFichaClienteOBSERVACAO: TBlobField;
      CDSFichaFornecedorOBSERVACAO: TBlobField;
      cdsBloqueioLiberadoMesAno: TStringField;
      cdsBloqueioLiberadoLimiteUtilizado: TCurrencyField;
      cdsBloqueioLiberadoPercLimiteExcedido: TCurrencyField;
      cdsBloqueioLiberadoCPFCNPJ: TStringField;
      CDSFichaClienteEmpresaUtilCredito: TIntegerField;
      cdsBloqueioLiberadoPercEdicaoPreco: TFloatField;
      cdsBloqueioLiberadoPercDescAtacado: TCurrencyField;
    FDConnection: TFDConnection;
    FDTransaction: TFDTransaction;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDEventAlerter: TFDEventAlerter;
    FDStoredProc: TFDStoredProc;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    QueryDataServidor: TFDQuery;
    QueryPesquisa: TFDQuery;
    QueryTrabalho: TFDQuery;
    SQLVerificaBloqueio: TFDStoredProc;
    SQLBloqueio: TFDStoredProc;
      procedure DataModuleCreate(Sender: TObject);
      procedure DataModuleDestroy(Sender: TObject);
   private
      FMinhaConexao: TFireDacConnectionAdapter;
      FConexaoBasePostgres: IDBConnection;
      FConnectionFb, FConnectionPg: TFDConnection;
      procedure MapeandoTabelasBancoPostegres;
      procedure ConectarBancoPostegres;
   public
      { Public declarations }
      procedure Bloqueia(MenuEstado: TEstados; Tabela, Codigo: String);
      procedure Desbloqueia(MenuEstado: TEstados; Tabela, Codigo: String);
      procedure GravaChequeMovimento(ChequeMovimentoNew: TChequeMovimento; const LiberarValores: boolean = True);

      procedure ExtornaTRecChequeMovimento(Empresa: string; IDBaixa: integer; IDMovimento: integer; Historico: string);

      function GravaFichaCliente: Integer;
      procedure GravaFichaFornecedor;
      procedure GravaAuditoria(CDSAuditoria: TClientDataSet);
      procedure GravarFormaRegistro;
      procedure GravaRefresh(Pedido: String = '');
      function VerificaSituacaoDoCheque(IdCheque: Integer): String;
      function GetGenerator(const NomeGenerator: string; const Incrementar: boolean = True): Integer;

      {procedure BeginTransaction;
      procedure CommitFreeAndNil;
      procedure RollbackFreeAndNil;}
      function GetManager: TObjectManager;
      function CreateObjectManager: TObjectManager;
   end;

   TTypeAtividade = (taOficina, taHotel, taConveniencia, taRestaurante, taAssistenciaTecnica);

   { Atividades }
   TNomenclatura = Class(TPersistent)
   private
      { Private declarations }
      fPlural  : string;
      fSingular: string;
   protected
      { Protected declarations }
   public
      { Public declarations }
      property Plural  : string read fPlural write fPlural;
      property Singular: string read fSingular write fSingular;
   end;

   { Atividades }
   TAtividade = Class(TPersistent)
   private
      { Private declarations }
      fTypeAtividade: TTypeAtividade;
      fAtividade    : string;
      fVendedor     : TNomenclatura;
      fMecanico     : TNomenclatura;
      fPrisma       : TNomenclatura;
      procedure SetTypeAtividade(const Value: TTypeAtividade);
      procedure SetAtividade(const Value: string);
      function GetTypeAtividade(const Value: string): TTypeAtividade;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      property TypeAtividade: TTypeAtividade read fTypeAtividade write SetTypeAtividade;
      property Atividade: string read fAtividade write SetAtividade;
      property Prisma: TNomenclatura read fPrisma write fPrisma;
      property Vendedor: TNomenclatura read fVendedor write fVendedor;
      property Mecanico: TNomenclatura read fMecanico write fMecanico;
   end;

var
   FDataModule   : TFDataModule;
   TD            : TTransactionDesc; // Variavel de transacao global do sConnection
   TD1           : TTransactionDesc; // Variavel de transacao global do sConnection
   EcoTransaction: IEcoTransaction;  // Variavel para transação global usada a partir do delphi 2007.

   ecPrm      : TGerParametro;
   sConectando: boolean = false; // para testar se ja o SCon. esta aberto na criacao.
   // OperacoesTEF: TOperacoesTEF;
   Atividade: TAtividade;

   { Tipo de registro 'tr' TVenRegistroForma }
const
   trRegistroPedido: Byte     = 1;
   trRegistroSaida: Byte      = 2;
   trRegistroBaixaDcto: Byte  = 3;
   trRegistroSangria: Byte    = 4;
   trRegistroSuprimento: Byte = 5;
   trRegistroDevolucao: Byte  = 6;

   { Tipo de valor 'tv' TVenRegistroForma }
const
   tvRecebidoDinheiro: Byte    = 1;
   tvRecebidoChequeVista: Byte = 2;
   tvRecebidoChequePrazo: Byte = 3;
   tvRecebidoCartao: Byte      = 4;
   tvRecebidoCrediario: Byte   = 5;
   tvRecebidoConvenio: Byte    = 6;
   tvCreditoUtilizado: Byte    = 7;
   tvCreditoConcedido: Byte    = 8;
   tvSaidaDinheiro: Byte       = 9;
   tvSaidaChequeVista: Byte    = 10;
   tvSaidaChequePrazo: Byte    = 11;
   tvBaixaParcela: Byte        = 12;
   tvCreditoTroca: Byte        = 13;
   tvSaidaChequeEmpresa: Byte  = 14;
   tvRecebidoCartaoVista: Byte = 15;
   tvValeTroco: Byte           = 16;
   tvRecebidoValeTroco: Byte   = 17;
   tvRecebidoCartaFrete: Byte  = 18;
   tvTroco: Byte               = 19;
   tvRecebidoRequisicao: Byte  = 20;

type
   TValoresPagamento = record
      Dinheiro: Currency;
      Cartao: Currency;
      ChequeAVista: Currency;
      ChequePre: Currency;
      ValeTroco: Currency;
      Crediario: Currency;
      Convenio: Currency;
      Credito: Currency;
      TrocoEmValeTroco: Currency;
   end;

type
   TParamsCupom = record
      NumeroPedido: String;
      AbrirCupom: Boolean;
      FecharCupom: Boolean;
      MontarFormas: Boolean;
      NumeroValeTroco: String;
      ValoresPagamento: TValoresPagamento;
      NFAgrupada: Boolean;
      DescontoNoPedido: Double;
   end;

implementation

{$R *.DFM}

procedure TFDataModule.ConectarBancoPostegres;
begin
   FConnectionFb := TControllerConexao.GetInstance.GetConexaoPadrao(TAplicacao.ECO, False, Concat(ExtractFilePath(Application.ExeName),'\eco.ini'));
   FConnectionFb.Connected := True;
   FConnectionPg := TControllerConexao.GetInstance.GetConexaoPadrao(TAplicacao.RelatorioLocal);
   FConnectionPg.Connected := True;
   FConexaoBasePostgres := TFireDacConnectionAdapter.Create(FConnectionPg, False);
   Self.MapeandoTabelasBancoPostegres;
end;

function TFDataModule.CreateObjectManager: TObjectManager;
begin
  Result := TObjectManager.Create(FMinhaConexao);
end;


procedure TFDataModule.DataModuleCreate(Sender: TObject);
var
   IniFile           : TIniFile;
   sModulo, sDLL, aux: string;
   sMens             : string;
begin
   System.Randomize;

   if (upperCase(FormatSettings.ShortDateFormat) <> 'DD/MM/AAAA') and (upperCase(FormatSettings.ShortDateFormat) <> 'DD/MM/YYYY') then
   begin
      Mensagem('O formato da data não esta configurado corretamente(dd/MM/aaaa)', tmErro);
      Application.Terminate;
   end;

   if (FormatSettings.DecimalSeparator <> ',') then
   begin
      Mensagem('O formato para o Ponto decimal esta incorreto(,)', tmErro);
      Application.Terminate;
   end;

   if (FormatSettings.ThousandSeparator <> '.') then
   begin
      Mensagem('O formato para o agrupamento de digitos esta incorreto(.)', tmErro);
      Application.Terminate;
   end;

   if (FormatSettings.TimeSeparator <> ':') then
   begin
      Mensagem('O formato para o separador de horas esta incorreto(:)', tmErro);
      Application.Terminate;
   end;

   FDConnection.Connected := False;
   Aux                   := ChangeFileExt(Application.ExeName, '.ini');

   IniFile := TIniFile.Create(UpperCase(Aux));
   sDll    := IniFile.ReadString('Preferencias', 'Firebird', 'GDS32.DLL');
   sModulo := 'windows';

   { try
     try
     sConectando := True; //  para saltar o IF no AfterConnection;

     aux := IniFile.ReadString (sModulo, 'dados', '');

     sConnection.Params.Values['DataBase'] := Aux;

     if IniFile.ReadString ('Preferencias', 'BaseEco', 'N') = 'S' then
     sConnection.Params.Values['Password'] := 'Senha da ECO';

     sConnection.Connected := True;
     except
     sConnection.Params.Values['Password'] := '305020';
     sConnection.Connected := True;
     end;

     sConectando := sConnection.Connected;
     except
     sConectando := False;

     Mensagem('O caminho para os dados em: ' + Aux + ', não foi encontrado, '          +
     'ou a senha do usuário SYSDBA está incorreta.                 ' + #13#10 +
     'Verifique o eco.Ini', tmErro);
     IniFile.Free;
     Application.Terminate;
     Exit;
     end; }

   sMens := '';

   { if Pos('C:\', UpperCase(Aux)) > 0 then begin
     iRetorno := FileAge(Aux);

     if iRetorno <= 0 then begin
     Mensagem('O caminho para os dados em: '+Aux+', não foi encontrado, '          +
     'ou a senha do usuário SYSDBA está incorreta.             ' + #13#10 +
     'Verifique o eco.Ini', tmErro);
     IniFile.Free;
     Application.Terminate;
     end;

     DataArq := Trunc(FileDateToDateTime(iRetorno));

     if Date < DataArq then
     sMens := 'ATENÇÃO: A data deste computador não coincide com a data do banco de dados!';
     end else begin
     DataX   := 0;
     DataArq := 0;

     try
     EcoOpen(QueryDataServidor);
     except
     sMens := 'Erro na Abertura do QueryDataServidor';
     end;

     try
     DataArq := QueryDataServidor.FieldByName('DataServidor').AsDateTime;
     except
     sMens :=  'Erro na QueryDataServidor';
     end;

     QueryDataServidor.Close;

     try
     DataX := Date;
     except
     sMens := 'Erro na DataX';
     end;

     if DataX <> DataArq then
     sMens := 'ATENÇÃO: A data deste computador não coincide com a data do servidor!';
     end;

     if sMens <> '' then begin
     Mensagem(sMens, tmInforma);
     IniFile.Free;
     Application.Terminate;
     Exit;
     end; }

   Atividade          := TAtividade.Create;
   TD.TransactionID   := 1;
   TD.IsolationLevel  := xilReadCommitted;
   TD1.TransactionID  := 2;
   TD1.IsolationLevel := xilReadCommitted;
   ServidorScripts    := IniFile.ReadString('windows', 'scripts', 'scripts');
   ServidorLog        := IniFile.ReadString('windows', 'log', 'log');

   UsuarioLog                     := IniFile.ReadString('Preferencias', 'usuario', 'SUPERVISOR');
   EmpresaLog                     := IniFile.ReadString('Preferencias', 'empresa', '01');
   ProgramaLog                    := IniFile.ReadString('Preferencias', 'Programa', '');
   Desenvolvimento                := IniFile.ReadString('Preferencias', 'Desenvolvimento', 'S') = 'S';
   DiretorioDoExeNovo             := IniFile.ReadString('Preferencias', 'DiretorioDoExeNovo', '');
   DiretorioDeRelatorios          := Trim(IniFile.ReadString('Preferencias', 'DiretorioDeRelatorios', '\EcoSis\Relatorios'));
   DiretorioDeRelatorios          := IncludeTrailingPathDelimiter(DiretorioDeRelatorios);
   PesquisaIncrementalDosProdutos := IniFile.ReadString('Preferencias', 'PesquisaIncrementalDosProdutos', 'S') = 'S';
   PesquisaIncrementalDosClientes := IniFile.ReadString('Preferencias', 'PesquisaIncrementalDosClientes', 'S') = 'S';
   SelecionaQtdeProdutoAutomatico := IniFile.ReadString('Preferencias', 'SelecionaQtdeProdutoAutomatico', 'N') = 'S';
   ModeloDoPedido                 := IniFile.ReadInteger('Preferencias', 'ModeloDoPedido', 0);
   ModeloPedidoReduzido           := IniFile.ReadInteger('Preferencias', 'ModeloPedidoReduzido', 0);
   Atividade.Atividade            := IniFile.ReadString('Preferencias', 'Atividade', 'OFICINA');
   cNumeroDigitosBomba            := IniFile.ReadInteger('Preferencias', 'NumeroDigitosBomba', 6);
   MonitorarTempoSelects          := IniFile.ReadString('Preferencias', 'MonitorarTempoSelects', 'N') = 'S';

   IdEstacao := IniFile.ReadInteger('estacao', 'ID', 1);
   IdEstacao := iif(IdEstacao = 1, GetLocalIPMachine.Oct4, IdEstacao);

   PesquisaIncremental  := IniFile.ReadString('estacao', 'PesquisaIncremental', 'S') = 'S';
   NotaServicoSeparada  := IniFile.ReadString('estacao', 'NotaServicoSeparada', 'N') = 'S';
   GeraLogRegistroVenda := IniFile.ReadString('estacao', 'GeraLogRegistroVenda', 'N') = 'S';

   PaginaPedidoOrcamento := IniFile.ReadString('impressoras', 'PaginaPedidoOrcamento', 'RAZAO');

   ecPrm         := TGerParametro.Create(FDConnection);
   ecPrm.Empresa := EmpresaLog;
   ecPrm.Estacao := IdEstacao;

   PortaSerial := 1; // default

   IniFile.Free;
   Self.ConectarBancoPostegres;

end;

procedure TFDataModule.DataModuleDestroy(Sender: TObject);
begin
   FreeAndNil(ecPrm);
   FreeAndNil(Atividade);
   FDConnection.Connected := False;
end;

procedure TFDataModule.Bloqueia(MenuEstado: TEstados; Tabela, Codigo: String);
begin
   if MenuEstado in [meEdita] then
   begin // se menu está em estado de edição...
      // Rotina de verificação de bloqueio
      SQLVerificaBloqueio.Params[0].Value := Tabela; // nome da tabela para bloquear
      SQLVerificaBloqueio.Params[1].Value := Codigo; // código para bloquear
      SQLVerificaBloqueio.ExecProc;                  // verifica se já não está bloqueado por outro usuário

      // Rotina de bloqueio
      SQLBloqueio.Params[0].Value := Tabela;  // nome da tabela
      SQLBloqueio.Params[1].Value := Codigo;  // código para bloquear
      SQLBloqueio.Params[2].Value := 'B';     // Opção "B" = Bloqueio
      SQLBloqueio.Params[3].Value := Usuario; // nome do usuário que deseja efetuar o bloqueio
      SQLBloqueio.ExecProc;                   // executa bloqueio ou gera exceção se o mesmo já existir para outro usuário
   end;
end;

procedure TFDataModule.Desbloqueia(MenuEstado: TEstados; Tabela, Codigo: String);
begin
   // Rotina de desbloqueio
   SQLBloqueio.Params[0].Value := Tabela;  // nome da tabela para desbloquear
   SQLBloqueio.Params[1].Value := Codigo;  // código para desbloquear
   SQLBloqueio.Params[2].Value := 'D';     // Opção "D" = Desbloqueio
   SQLBloqueio.Params[3].Value := Usuario; // nome do usuário que deseja efetuar o desbloqueio
   SQLBloqueio.ExecProc;                   // executa desbloqueio
end;

(*
  {--------------------------------------------------------------------------}
  { o cheque esta na fora empresa                                            }
  {   -----------------------------------------------------------------------}
  {   | Comissao = BC-Baixa CR / DB,                G-Gera, N-nda            }
  {   |   ------------------------------------------------------------------ }
  {   |   | IDMovimento                                                      }
  {   |   |    ------------------------------------------------------------- }
  {   | BC| 01 - CHEQUE RECEBIDO NO CONTAS A RECEBER                         }    1 - CHEQUE RECEBIDO NO CONTAS A RECEBER
  { x | BC| 02 - CHEQUE DADO COMO TROCO NO CONTAS A RECEBER                  } x  2 - CHEQUE DADO COMO TROCO NO CONTAS A RECEBER
  {   | G | 03 - CHEQUE RECEBIDO NA REGISTRADORA REGISTRO DE PEDIDO          }    3 - CHEQUE RECEBIDO NA REGISTRADORA REGISTRO DE PEDIDO
  { x | BC| 04 - CHEQUE DADO COMO TROCO NA REGISTRADORA REGISTRO DE PEDIDO   } x  4 - CHEQUE DADO COMO TROCO NA REGISTRADORA REGISTRO DE PEDIDO
  {   | BC| 05 - UTILIZACAO DE VALOR DISPONIVEL DO CHEQUE NA REGISTRADORA    }    5 - UTILIZACAO DE VALOR DISPONIVEL DO CHEQUE NA REGISTRADORA
  {   | BD| 06 - DEVOLUCAO DE CHEQUE 1ª APRESENTACAO                         }    6 - DEVOLUCAO DE CHEQUE 1ª APRESENTACAO
  {   | BD| 07 - DEVOLUCAO DE CHEQUE 2ª APRESENTACAO                         }    7 - DEVOLUCAO DE CHEQUE 2ª APRESENTACAO
  { x | BC| 08 - CHEQUE UTILIZADO EM SAIDAS DA REGISTRADORA                  } x  8 - CHEQUE UTILIZADO EM SAIDAS DA REGISTRADORA
  {   |   | 09 - TRANSF. CHEQUE P/ CAIXA          (FECHAMENTO REGISTRADORA)  }    9 - TRANSF. CHEQUE P/ CAIXA          (FECHAMENTO REGISTRADORA)
  {   |   | 10 - TRANSF. CHEQUE P/ CONTAS RECEBER (FECHAMENTO REGISTRADORA)  }   10 - TRANSF. CHEQUE P/ CONTAS RECEBER (FECHAMENTO REGISTRADORA)
  {   |   | 11 - TRANSF. CHEQUE P/ CAIXA          (SANGRIA)                  }   11 - TRANSF. CHEQUE P/ CAIXA          (SANGRIA)
  {   |   | 12 - TRANSF. CHEQUE P/ CONTAS RECEBER (SANGRIA)                  }   12 - TRANSF. CHEQUE P/ CONTAS RECEBER (SANGRIA)
  {   | B | 13 - UTILIZACAO VALOR DISPONIVEL BAIXA DE DCTOS CONT. RECEBER    }   13 - UTILIZACAO VALOR DISPONIVEL BAIXA DE DCTOS CONT. RECEBER
  {   |   | 14 - ENTRADA DO CHEQUE ATRAVEZ DA DIGITACAO DE CHEQUE            }   14 - ENTRADA DO CHEQUE ATRAVEZ DA DIGITACAO DE CHEQUE
  {   |   | 15 - TRANSFERENCIA DO CHEQUE PARA CAIXA TRABALHO                 }   15 - TRANSFERENCIA DO CHEQUE PARA CAIXA TRABALHO
  { x | B | 16 - NEGOCIACAO DO CHEQUE C/ FACTORING                           } x 16 - NEGOCIACAO DO CHEQUE C/ FACTORING
  {   |   | 17 - ENTRADA DO CHEQUE ATRAVEZ DE LANCAMENTO DO CAIXA            }   17 - ENTRADA DO CHEQUE ATRAVEZ DE LANCAMENTO DO CAIXA
  { x | B | 18 - SAIDA DO CHEQUE ATRAVEZ DE LANCAMENTO DO CAIXA              } x 18 - SAIDA DO CHEQUE ATRAVEZ DE LANCAMENTO DO CAIXA
  { x | B | 19 - DEPOSITO                                                    } x 19 - DEPOSITO
  {   |   | 20 - CHEQUE RECEBIDO COMO TROCO NO CONTAS A PAGAR                }   20 - CHEQUE RECEBIDO COMO TROCO NO CONTAS A PAGAR
  {   |   | 21 - TRANSF. AUTOMATICA P/ CAIXA DE TRAB. ATRAVES CONTAS A PAGAR }   21 - TRANSF. AUTOMATICA P/ CAIXA DE TRAB. ATRAVES CONTAS A PAGAR
  { x | BC| 22 - UTILIZACAO DE CHEQUE NA BAIXA DE CONTAS A PAGAR             } x 22 - UTILIZACAO DE CHEQUE NA BAIXA DE CONTAS A PAGAR
  { x | BC| 23 - NEGOCIACAO DO CHEQUE C/ BANCO                               } x 23 - NEGOCIACAO DO CHEQUE C/ BANCO
  {   |   | 24 - CHEQUE RECEBIDO NA QUITACAO DE CHEQUE                       }   24 - CHEQUE RECEBIDO NA QUITACAO DE CHEQUE
  {   | BC| 25 - UTILIZACAO VALOR DISPONIVEL QUITACAO DE CHEQUE              }   25 - UTILIZACAO VALOR DISPONIVEL QUITACAO DE CHEQUE
  { x | BC| 26 - CHEQUE DADO COMO TROCO NA QUITACAO DE CHEQUE                } x 26 - CHEQUE DADO COMO TROCO NA QUITACAO DE CHEQUE
  {   |   | 27 - CHEQUE RECEBIDO NA REGISTRADORA BAIXA CONTAS A RECEBER      }   27 - CHEQUE RECEBIDO NA REGISTRADORA BAIXA CONTAS A RECEBER
  {   |   |      TRANSF. AUTOMATICA P/ CAIXA DE TRAB. ATRAVES CONTAS A PAGAR }   28 - PAGAMENTO ANTECIPADO A FORNECEDORES
  {   | BC| 28 - UTILIZACAO DE CHEQUE NA ANTECIPACAO DE PAGTO A FORNECEDOR   }   29 - UTILIZACAO DE CHEQUE NA ANTECIPACAO DE PAGTO A FORNECEDOR
  {   | BC| 29 - QUITAÇÃO DO CHEQUE                                          }   30 - QUITAÇÃO DO CHEQUE
  {   |   | 30 - TRANSFERENCIA ENTRE CAIXAS                                  }   31 - TRANSFERENCIA ENTRE CAIXAS
  {   |   | 31 - TRANSFERENCIA ENTRE EMPRESA                                 }   32 - TRANSFERENCIA ENTRE EMPRESA
  {   |   | 33 - CHEQUE CUSTODIADO                                           }   33 - CHEQUE CUSTODIADO

  // atencao no GERAL ESTA O ARRAY DE DEFINICOES DESTAS VARIAVEIS, QUANDO FOR ISERIR AQUI
  // OBSERVE TipoMovimentoCheque E ALTERE O ARRAY

  {   | BD| 50 - comissao - EXTORNO DE QUITACAO DE CHEQUES                   }   50 - REC615RA-qdo extorna quitacao
  {   | BC| 51 - comissao - CANCELAMENTO DE DEVOLUCAO DE CHQS ALINEA 11/12   }   51 - REC611RA-qdo cancela as alinea 11/12
  {              Dentre outros cancelamentos                                 }
  {--------------------------------------------------------------------------}
*)

procedure TFDataModule.GravaChequeMovimento(ChequeMovimentoNew: TChequeMovimento; const LiberarValores: boolean = True);
// ha casos q nao existe a comissao
begin

end;

procedure TFDataModule.ExtornaTRecChequeMovimento(Empresa: string; IDBaixa: integer; IDMovimento: integer; Historico: string);
begin

end;

procedure TFDataModule.GravaAuditoria(CDSAuditoria: TClientDataSet);
   function NovaSequencia: Integer;
   begin
      with QueryPesquisa do
      begin
         Sql.Clear;
         Sql.Add('SELECT Max(Codigo) As Sequencia ' + 'FROM   TGerAuditoria            ' + 'WHERE  Empresa = :Empresa       ');

         ParamByName('Empresa').AsString := Empresa;

         EcoOpen(QueryPesquisa);
         Result := StrToIntDef(FieldByName('Sequencia').asString, 0) + 1;
      end;
   end;

begin
   with QueryTrabalho do
   begin
      SqlAddString := 'INSERT INTO TGerAuditoria ( ';
      SqlAddValues := 'VALUES ( ';
      SqlAddWhere  := '';

      IntNotNull('EMPRESA        ', CDSAuditoria.FieldByName('Empresa').AsInteger);
      IntNotNull('CODIGO         ', NovaSequencia);
      StrNotNull('TABELA         ', 030, CDSAuditoria.FieldByName('Tabela').AsString);
      StrNotNull('CAMPOALTERADO  ', 030, CDSAuditoria.FieldByName('CampoAlterado').AsString);
      IntNotNull('IDENTIFICADOR  ', CDSAuditoria.FieldByName('Identificador').AsInteger);
      StrNotNull('TIPOCAMPO      ', 010, CDSAuditoria.FieldByName('TipoCampo').AsString);
      StrNotNull('VALOROLD       ', 255, CDSAuditoria.FieldByName('ValorOld').AsString);
      StrNotNull('VALORNEW       ', 255, CDSAuditoria.FieldByName('ValorNew').AsString);
      StrNotNull('USUARIO)       ', 015, CDSAuditoria.FieldByName('Usuario').AsString);

      Sql.Clear;
      Sql.Add(SqlAddString + SqlAddValues + SqlAddWhere);
      ExecSql;
   end;
end;

function TFDataModule.VerificaSituacaoDoCheque(IdCheque: Integer): String;
var
   JaFoiDepositado: Boolean;
begin
   Result          := '';
   JaFoiDepositado := False;

   with QueryTrabalho do
   begin
      Sql.Clear;
      Sql.Add('Select IdMovimento                         ' + 'From   TRecChequeMovimento                 ' +
         'Where  IdMovimento not in (5,13,21,24) AND ' + '       IdCheque = :IdCheque                ' +
         'Order By Sequencia                         ');

      ParamByName('IdCheque').AsInteger := IdCheque;

      Open;
      while not eof do
      begin
         if FieldByName('IdMovimento').AsInteger in [1, 3, 9, 10, 11, 12, 14, 17, 20, 25] then
            Result := 'N';
         if FieldByName('IdMovimento').AsInteger in [2, 4, 8, 16, 18, 22, 23, 26] then
            Result := 'B';
         if FieldByName('IdMovimento').AsInteger in [6] then
            Result := 'D';
         if FieldByName('IdMovimento').AsInteger in [] then
            Result := 'R';
         if FieldByName('IdMovimento').AsInteger in [7] then
            Result := 'S';
         if FieldByName('IdMovimento').AsInteger in [29] then
            Result := 'Q';
         if FieldByName('IdMovimento').AsInteger in [19] then
         begin // Deposito
            Result          := iif(JaFoiDepositado, 'R', 'B');
            JaFoiDepositado := True;
         end;
         Next;
      end;
   end;
end;

function TFDataModule.GravaFichaCliente: Integer;
var
   IdSequencia: Integer;

   function NovaSequencia: Integer;
   begin
      with QueryPesquisa do
      begin
         Sql.Clear;
         Sql.Add('SELECT Max(Sequencia) As Sequencia ' + 'FROM   TRecFichaClienteLcto       ');

         EcoOpen(QueryPesquisa);
         Result := StrToIntDef(FieldByName('Sequencia').asString, 0) + 1;
      end;
   end;

begin
   { Campo: IdMovimento
     {====+======+========================================================== }
   { ID | TIPO | DESCRICAO
     {====+======+========================================================== }
   { 1 |  C   | CREDITO REFERENTE DEVOLUCAO DE VENDA }
   { 2 |  D   | PAGAMENTO DE CRÉDITO EM LCTO NO CAIXA }
   { 3 |  D   | UTILIZACAO DE CREDITO EM BAIXA CONTAS A RECEBER }

   { 4 |  D   | UTILIZACAO DE CREDITO EM REGISTRO DE PEDIDO-SAIDA }
   { 4 |  C   | CREDITO GERADO POR TROCO PENDENTE NA VENDA }

   { 5 |  D   | UTILIZACAO DE CREDITO EM SAIDA DA REGISTRADORA }
   { 6 |  C   | CREDITO REF. DEVOLUCAO CHEQUE REPASSADO AO CLIENTE }
   { 7 |  D   | UTILIZAÇÃO DE CRÉDITO NA QUITAÇÃO DE CHEQUE }
   { 8 |  C   | CREDITO CONCEDIDO NA BAIXA DE DOCUMENTO }

   { 9 |  D   | UTILIZACAO DE VALE TROCO EM REGISTRO DE PEDIDO-SAIDA }
   { 9 |  C   | VALE TROCO GERADO POR TROCO PENDENTE NA VENDA }

   { 10 |  C   | CREDITO CONCEDIDO NO CANCELAMENTO DE ITENS A SEREM ENTREGUES (ENTREGA FUTURA) }
   { 11 |  D   | DEBITO NO ESTORNO DE CANCELAMENTO DE ITENS A SEREM ENTREGUES (ENTREGA FUTURA) }

   { 12 |  C   | CREDITO CONCEDIDO EM CAMPANHA DE VENDA }

   { 13 |  C   | CREDITO CONCEDIDO BAIXA DE CONTAS A PAGAR COM PERMUTA }
   { 14 |  D   | DEBITO NO CANCELAMENTO DE BAIXA DE CONTAS A PAGAR COM PERMUTA }

   { 15 |  C   ! CREDITO DO DOCUMENTO LANCADO PELO CONTAS A RECEBER }
   { 15 |  D   ! DEBITO DO DOCUMENTO ALTERADO OU EXCLUIDO DO CONTAS A RECEBER }
   IdSequencia := 0;
   with QueryTrabalho do
   begin
      CDSFichaCliente.First;
      while not CDSFichaCliente.Eof do
      begin
         IDSequencia := NovaSequencia;
         Sql.Clear;
         Sql.Add('INSERT INTO TRecFichaClienteLcto (                        ' + 'Sequencia,                                                '
            + 'Empresa,                                                  ' + 'Cliente,                                                  ' +
            'IdMovimento,                                              ' + 'Identificador,                                            ' +
            'IdRegistradora,                                           ' + 'IdPeriodo,                                                ' +
            'IdCaixa,                                                  ' + 'DataCaixa,                                                ' +
            'Historico,                                                ' + 'Observacao,                                               ' +
            'Tipo,                                                     ' + 'Valor,                                                    ' +
            'Usuario,                                                  ' + 'EmpresaUtilCredito)                                       ' +
            'VALUES(:Sequencia,                                        ' + '       :Empresa,                                          ' +
            '       :Cliente,                                          ' + '       :IdMovimento,                                      ' +
            '       :Identificador,                                    ' + '       :IdRegistradora,                                   ' +
            '       :IdPeriodo,                                        ' + '       :IdCaixa,                                          ' +
            '       :DataCaixa,                                        ' + '       :Historico,                                        ' +
            '   ' + QuotedStr(CDSFichaClienteObservacao.AsString) + ', ' + '       :Tipo,                                             ' +
            '       :Valor,                                            ' + '       :Usuario,                                          ' +
            '       :EmpresaUtilCredito)                               ');

         ParamByName('Sequencia').AsInteger          := IDSequencia;
         ParamByName('Empresa').AsInteger            := CDSFichaClienteEmpresa.AsInteger;
         ParamByName('Cliente').AsInteger            := CDSFichaClienteCliente.AsInteger;
         ParamByName('IdMovimento').AsInteger        := CDSFichaClienteIdMovimento.AsInteger;
         ParamByName('Identificador').AsInteger      := CDSFichaClienteIdentificador.AsInteger;
         ParamByName('IdRegistradora').AsInteger     := CDSFichaClienteIdRegistradora.AsInteger;
         ParamByName('IdPeriodo').AsInteger          := CDSFichaClienteIdPeriodo.AsInteger;
         ParamByName('IdCaixa').AsInteger            := CDSFichaClienteIdCaixa.AsInteger;
         ParamByName('DataCaixa').AsDate             := CDSFichaClienteDataCaixa.AsDateTime;
         ParamByName('Historico').AsString           := CDSFichaClienteHistorico.AsString;
         ParamByName('Tipo').AsString                := CDSFichaClienteTipo.AsString;
         ParamByName('Valor').AsCurrency             := CDSFichaClienteValor.AsCurrency;
         ParamByName('Usuario').AsString             := CDSFichaClienteUsuario.AsString;
         ParamByName('EmpresaUtilCredito').AsInteger := CDSFichaClienteEmpresaUtilCredito.AsInteger;
         ExecSql;

         CDSFichaCliente.Next;
      end;
      CDSFichaCliente.CancelUpdates;
   end;
   Result := IDSequencia;
end;

procedure TFDataModule.GravarFormaRegistro;
var
   Valor: Currency;
Const
   TipoRegistro: Array [1 .. 06] of String = ('01-Ped ', '02-Sai ', '03-Bxa ', '04-San ', '05-Sup ', '06-Dev ');

   TipoValor: Array [1 .. 20] of String = ('01-Dinheiro recebido            ', '02-Cheque a vista recebido      ',
      '03-Cheque a prazo recebido      ', '04-Cartao de credito            ', '05-Crediario                    ',
      '06-Convenio                     ', '07-Credito de cliente utilizado ', '08-Saida de credito de cliente  ',
      '09-Saida de dinheiro            ', '10-Saida de cheque a vista      ', '11-Saida em cheque a prazo      ',
      '12-Baixa em parcelas            ', '13-Credito troca de mercadoria  ', '14-Cheque da empresa            ',
      '15-Cartao vista                 ', '16-Saida de Vale Troco          ', '17-Vale Troco Utilizado         ',
      '18-Carta Frete                  ', '19-Troco                        ', '20-Requisicao                   ');
begin
   with QueryTrabalho do
   begin
      CDSRegistroForma.First;
      while not CDSRegistroForma.eof do
      begin
         Valor := ABS(CDSRegistroFormaValor.AsCurrency);

         if CDSRegistroFormaTipoValor.AsInteger in [8, 9, 10, 11, 12, 16, 19] then
            Valor := Valor * (-1);

         SqlAddString := 'INSERT INTO TVenRegistroForma ( ';
         SqlAddValues := 'VALUES ( ';
         SqlAddWhere  := '';
         StrNotNull('EMPRESA       ', 02, CDSRegistroFormaEmpresa.AsString);
         IntNotNull('IDREGISTRO    ', CDSRegistroFormaIdRegistro.AsInteger);
         IntNotNull('TIPOREGISTRO  ', CDSRegistroFormaTipoRegistro.AsInteger);
         IntNull('IDENTIFICADOR ', CDSRegistroFormaIdentificador.AsInteger);
         IntNotNull('TIPOVALOR     ', CDSRegistroFormaTipoValor.AsInteger);
         NumNotNull('VALOR         ', 02, Valor);
         IntNull('IDCHEQUE      ', CDSRegistroFormaIdCheque.AsInteger);
         StrNotNull('DESCRICAO)    ', 40, TipoRegistro[CDSRegistroFormaTipoRegistro.AsInteger] +
            TipoValor[CDSRegistroFormaTipoValor.AsInteger]);

         Sql.Clear;
         Sql.Add(SqlAddString + SqlAddValues + SqlAddWhere);
         ExecSql;

         CDSRegistroForma.Next;
      end;

      CDSRegistroForma.CancelUpdates;
   end;
end;

procedure TFDataModule.MapeandoTabelasBancoPostegres;
var
  MapSetup: TMappingSetup;
  DBManager: TDatabaseManager;
  MappingExplorer: TMappingExplorer;

begin
  MapSetup := TMappingSetup.Create;
  try
    try
       MapSetup.MappedClasses.RegisterClass(TTEstProdutoImagemPost);
       MapSetup.MappedClasses.RegisterClass(TTEstProdutoImagemPostDeletada);

       MappingExplorer := TMappingExplorer.Create(MapSetup);

       DBManager := TDatabaseManager.Create(FConexaoBasePostgres, MappingExplorer);
       if not DBManager.ValidateDatabase then
       begin
         DBManager.UpdateDatabase;
       end;
    except
      on e: exception do
      begin
         MessageDlg(Concat('Não foi possível Mapear a Base de Dados PostgreSQL. Detalhes do Erro: ', #10#13, E.Message), mtWarning, [mbOk], ZeroValue);
      end;
    end;
  Finally
    FreeAndNil(MappingExplorer);
    FreeAndNil(MapSetup);
    FreeAndNil(DBManager);
  end;
end;

procedure TFDataModule.GravaFichaFornecedor;

   function NovaSequencia: Integer;
   begin
      with QueryPesquisa do
      begin
         Sql.Clear;
         Sql.Add('SELECT Max(Sequencia) As Sequencia ' + 'FROM   TPagFichaFornecedorLcto     ');

         EcoOpen(QueryPesquisa);
         Result := StrToIntDef(FieldByName('Sequencia').asString, 0) + 1;
      end;
   end;

begin
   { Campo: IdMovimento }
   { 1 - CREDITO REFERENTE DEVOLUCAO DE COMPRA }
   { 2 - CANCELAMENTO DE DEVOLUCAO DE COMPRA }
   { 3 - UTILIZACAO DE SALDO EM BAIXA DE DOCUMENTO CONTAS A PAGAR }
   { 4 - CREDITO REFERENTE DEVOLUCAO DE CHEQUE }
   { 5 - PAGAMENTO ANTECIPADO }
   { 6 - DEVOLUÇÃO DE CREDITO DO FORNECEDOR }
   { 7 - TROCO DEIXADO COMO CREDITO NA BAIXA DE DOCUMENTO CONTAS A PAGAR }

   with QueryTrabalho do
   begin
      CDSFichaFornecedor.First;
      while not CDSFichaFornecedor.Eof do
      begin
         Sql.Clear;
         Sql.Add('INSERT INTO TPagFichaFornecedorLcto (                        ' +
            'Sequencia,                                                   ' +
            'Empresa,                                                     ' +
            'Fornecedor,                                                  ' +
            'IdMovimento,                                                 ' +
            'Identificador,                                               ' +
            'IdCaixa,                                                     ' +
            'DataCaixa,                                                   ' +
            'Historico,                                                   ' +
            'Observacao,                                                  ' +
            'Tipo,                                                        ' +
            'Valor,                                                       ' +
            'Usuario)                                                     ' +
            'VALUES(:Sequencia,                                           ' +
            '       :Empresa,                                             ' +
            '       :Cliente,                                             ' +
            '       :IdMovimento,                                         ' +
            '       :Identificador,                                       ' +
            '       :IdCaixa,                                             ' +
            '       :DataCaixa,                                           ' +
            '       :Historico,                                           ' + '   ' + QuotedStr(CDSFichaFornecedorObservacao.AsString) +
            ', ' + '       :Tipo,                                                ' +
            '       :Valor,                                               ' +
            '       :Usuario)                                             ');

         ParamByName('Sequencia').AsInteger     := NovaSequencia;
         ParamByName('Empresa').AsInteger       := CDSFichaFornecedorEmpresa.AsInteger;
         ParamByName('Cliente').AsInteger       := CDSFichaFornecedorFornecedor.AsInteger;
         ParamByName('IdMovimento').AsInteger   := CDSFichaFornecedorIdMovimento.AsInteger;
         ParamByName('Identificador').AsInteger := CDSFichaFornecedorIdentificador.AsInteger;
         ParamByName('IdCaixa').AsInteger       := CDSFichaFornecedorIdCaixa.AsInteger;
         ParamByName('DataCaixa').AsDate        := CDSFichaFornecedorDataCaixa.AsDateTime;
         ParamByName('Historico').AsString      := CDSFichaFornecedorHistorico.AsString;
         ParamByName('Tipo').AsString           := CDSFichaFornecedorTipo.AsString;
         ParamByName('Valor').AsCurrency        := CDSFichaFornecedorValor.AsCurrency;
         ParamByName('Usuario').AsString        := CDSFichaFornecedorUsuario.AsString;
         ExecSql;

         CDSFichaFornecedor.Next;
      end;

      CDSFichaFornecedor.CancelUpdates;
   end;
end;

function TFDataModule.GetGenerator(const NomeGenerator: string; const Incrementar: boolean = True): Integer;
const
   S = 'Select Cast(GEN_ID(%S, %S) as Integer) as ProxSeq from rdb$DataBase;';
begin
   Result := 0;
   with QueryPesquisa do
   begin
      try
         Sql.Clear;
         Sql.Add(Format(S, [NomeGenerator, iif(Incrementar, '1', '0')]));

         if EcoOpen(QueryPesquisa) then
            Result := FieldByName('ProxSeq').asInteger;
      finally
         Close;
      end;
   end;
end;

function TFDataModule.GetManager: TObjectManager;
begin
   Result := TObjectManager.Create(FMinhaConexao);
end;

procedure TFDataModule.GravaRefresh(Pedido: String = '');
begin
   with QueryTrabalho do
   begin
      Sql.Clear;
      Sql.Add('UPDATE TVenRefresh Set Identificador = case when identificador>=1000 then 1 else (Identificador+1) end ');
      EcoExecSql(QueryTrabalho);
      if (Pedido <> '') then
      begin
         Sql.Clear;
         Sql.Add('UPDATE TVenPedido Set                                                  ' +
            '       Refresh = Case when Refresh is null then 1 else (Refresh+1) end ' + 'WHERE  Empresa = :Empresa AND ' +
            '       Codigo  = :Pedido      ');
         ParamByName('Empresa').AsString := Empresa;
         ParamByName('Pedido').AsString  := Pedido;
         EcoExecSql(QueryTrabalho);
      end;
   end;
end;

{ TAtividade }
constructor TAtividade.Create;
begin
   fPrisma   := TNomenclatura.Create;
   fVendedor := TNomenclatura.Create;
   fMecanico := TNomenclatura.Create;

   TypeAtividade := taOficina;
end;

destructor TAtividade.Destroy;
begin
   FreeAndNil(fPrisma);
   FreeAndNil(fVendedor);
   FreeAndNil(fMecanico);
   inherited;
end;

function TAtividade.GetTypeAtividade(const Value: string): TTypeAtividade;
begin
   Result := taOficina;
   if Value = 'OFICINA' then
      Result := taOficina;
   if Value = 'HOTEL' then
      Result := taHotel;
   if Value = 'CONVENIENCIA' then
      Result := taConveniencia;
   if Value = 'RESTAURANTE' then
      Result := taRestaurante;
   if Value = 'ASSISTENCIA' then
      Result := taAssistenciaTecnica;

   if Value = '1' then
      Result := taOficina;
   if Value = '2' then
      Result := taHotel;
   if Value = '3' then
      Result := taConveniencia;
   if Value = '4' then
      Result := taRestaurante;
   if Value = '5' then
      Result := taAssistenciaTecnica;
end;

procedure TAtividade.SetAtividade(const Value: string);
begin
   if UpperCase(Value) = fAtividade then
      exit;

   fAtividade    := UpperCase(Value);
   TypeAtividade := GetTypeAtividade(fAtividade);
end;

procedure TAtividade.SetTypeAtividade(const Value: TTypeAtividade);
begin
   fTypeAtividade := Value;
   case fTypeAtividade of
      taOficina:
         begin
            fPrisma.Singular   := 'Prisma';
            fVendedor.Singular := 'Vendedor';
            fMecanico.Singular := 'Mecânico';

            fPrisma.Plural   := 'Prismas';
            fVendedor.Plural := 'Vendedores';
            fMecanico.Plural := 'Mecânicos';
         end;
      taHotel:
         begin
            fPrisma.Singular   := 'Apto';
            fVendedor.Singular := 'Vendedor';
            fMecanico.Singular := 'Atendente';

            fPrisma.Plural   := 'Apartamentos';
            fVendedor.Plural := 'Vendedores';
            fMecanico.Plural := 'Atendentes';
         end;
      taConveniencia:
         begin
            fPrisma.Singular   := 'Mesa';
            fVendedor.Singular := 'Atendente';
            fMecanico.Singular := 'Atendente';

            fPrisma.Plural   := 'Mesas/Controles';
            fVendedor.Plural := 'Vendedores';
            fMecanico.Plural := 'Atendentes';
         end;
      taRestaurante:
         begin
            fPrisma.Singular   := 'Mesa';
            fVendedor.Singular := 'Vendedor';
            fMecanico.Singular := 'Atendente';

            fPrisma.Plural   := 'Mesas/Controles';
            fVendedor.Plural := 'Vendedores';
            fMecanico.Plural := 'Atendentes';
         end;
      taAssistenciaTecnica:
         begin
            fPrisma.Singular   := 'OS';
            fVendedor.Singular := 'Atendente';
            fMecanico.Singular := 'Técnico';

            fPrisma.Plural   := 'ORDEM DE SERVIÇO';
            fVendedor.Plural := 'Atendentes';
            fMecanico.Plural := 'Técnicos';
         end;
   end;
end;

end.
