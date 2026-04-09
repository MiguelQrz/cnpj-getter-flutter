class Telefone {
  final String ddd;
  final String numero;
  final bool isFax;

  Telefone({
    required this.ddd,
    required this.numero,
    required this.isFax,
  });

  factory Telefone.fromJson(Map<String, dynamic> json) {
    return Telefone(
      ddd: json['ddd'] as String? ?? '',
      numero: json['numero'] as String? ?? '',
      isFax: json['is_fax'] as bool? ?? false,
    );
  }
}

class Qsa {
  final String nomeSocio;
  final String cnpjCpfSocio;
  final String qualificacaoSocio;
  final String dataEntradaSociedade;
  final String identificadorSocio;
  final String faixaEtaria;

  Qsa({
    required this.nomeSocio,
    required this.cnpjCpfSocio,
    required this.qualificacaoSocio,
    required this.dataEntradaSociedade,
    required this.identificadorSocio,
    required this.faixaEtaria,
  });

  factory Qsa.fromJson(Map<String, dynamic> json) {
    return Qsa(
      nomeSocio: json['nome_socio'] as String? ?? '',
      cnpjCpfSocio: json['cnpj_cpf_socio'] as String? ?? '',
      qualificacaoSocio: json['qualificacao_socio'] as String? ?? '',
      dataEntradaSociedade: json['data_entrada_sociedade'] as String? ?? '',
      identificadorSocio: json['identificador_socio'] as String? ?? '',
      faixaEtaria: json['faixa_etaria'] as String? ?? '',
    );
  }
}

class CnpjData {
  final String cnpj;
  final String razaoSocial;
  final String nomeFantasia;
  final String situacaoCadastral;
  final String dataSituacaoCadastral;
  final String matrizFilial;
  final String dataInicioAtividade;
  final String cnaePrincipal;
  final List<String> cnaesSecundarios;
  final int cnaesSecundariosCount;
  final String naturezaJuridica;
  final String logradouro;
  final String numero;
  final String complemento;
  final String bairro;
  final String cep;
  final String uf;
  final String municipio;
  final String email;
  final List<Telefone> telefones;
  final String capitalSocial;
  final String porteEmpresa;
  final String? opcaoSimples;
  final String? dataOpcaoSimples;
  final String? opcaoMei;
  final String? dataOpcaoMei;
  final List<Qsa> qsa;

  CnpjData({
    required this.cnpj,
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.situacaoCadastral,
    required this.dataSituacaoCadastral,
    required this.matrizFilial,
    required this.dataInicioAtividade,
    required this.cnaePrincipal,
    required this.cnaesSecundarios,
    required this.cnaesSecundariosCount,
    required this.naturezaJuridica,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cep,
    required this.uf,
    required this.municipio,
    required this.email,
    required this.telefones,
    required this.capitalSocial,
    required this.porteEmpresa,
    required this.opcaoSimples,
    required this.dataOpcaoSimples,
    required this.opcaoMei,
    required this.dataOpcaoMei,
    required this.qsa,
  });

  factory CnpjData.fromJson(Map<String, dynamic> json) {
    return CnpjData(
      cnpj: json['cnpj'] as String? ?? '',
      razaoSocial: json['razao_social'] as String? ?? '',
      nomeFantasia: json['nome_fantasia'] as String? ?? '',
      situacaoCadastral: json['situacao_cadastral'] as String? ?? '',
      dataSituacaoCadastral: json['data_situacao_cadastral'] as String? ?? '',
      matrizFilial: json['matriz_filial'] as String? ?? '',
      dataInicioAtividade: json['data_inicio_atividade'] as String? ?? '',
      cnaePrincipal: json['cnae_principal'] as String? ?? '',
      cnaesSecundarios: (json['cnaes_secundarios'] as List<dynamic>?)
              ?.map((item) => item as String)
              .toList() ??
          [],
      cnaesSecundariosCount: json['cnaes_secundarios_count'] as int? ?? 0,
      naturezaJuridica: json['natureza_juridica'] as String? ?? '',
      logradouro: json['logradouro'] as String? ?? '',
      numero: json['numero'] as String? ?? '',
      complemento: json['complemento'] as String? ?? '',
      bairro: json['bairro'] as String? ?? '',
      cep: json['cep'] as String? ?? '',
      uf: json['uf'] as String? ?? '',
      municipio: json['municipio'] as String? ?? '',
      email: json['email'] as String? ?? '',
      telefones: (json['telefones'] as List<dynamic>?)
              ?.map((item) => Telefone.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
      capitalSocial: json['capital_social'] as String? ?? '',
      porteEmpresa: json['porte_empresa'] as String? ?? '',
      opcaoSimples: json['opcao_simples'] as String?,
      dataOpcaoSimples: json['data_opcao_simples'] as String?,
      opcaoMei: json['opcao_mei'] as String?,
      dataOpcaoMei: json['data_opcao_mei'] as String?,
      qsa: (json['QSA'] as List<dynamic>?)
              ?.map((item) => Qsa.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
