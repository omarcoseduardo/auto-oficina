import 'veiculo.dart';

class Responsavel {
  String _nome;
  final String documento; // final: não pode ser alterado após a criação
  String _telefone;
  String _email;
  final List<Veiculo> _veiculos; // 1 responsável -> 0..* veículos

  // construtor privado: só é chamado depois que os dados foram validados
  Responsavel._({
    required this._nome,
    required this.documento,
    required this._telefone,
    required this._email,
    required this._veiculos,
  });

  // factory: valida e normaliza os dados antes de criar o objeto
  factory Responsavel({
    required String nome,
    required String documento,
    required String telefone,
    required String email,
    List<Veiculo> veiculos = const [],
  }) {
    return Responsavel._(
      nome: _validarNome(nome),
      documento: _validarDocumento(documento),
      telefone: _validarTelefone(telefone),
      email: _validarEmail(email),
      veiculos: List.of(veiculos),
    );
  }

  // reconstrói o objeto a partir de um Map (os veículos não são incluídos
  // para evitar referência circular, já que o Veiculo serializa seu responsável)
  factory Responsavel.fromMap(Map<String, dynamic> map) {
    return Responsavel(
      nome: map['nome'] as String,
      documento: map['documento'] as String,
      telefone: map['telefone'] as String,
      email: map['email'] as String,
    );
  }

  // getters e setters
  String get nome => _nome;
  set nome(String valor) => _nome = _validarNome(valor);

  String get telefone => _telefone;
  set telefone(String valor) => _telefone = _validarTelefone(valor);

  String get email => _email;
  set email(String valor) => _email = _validarEmail(valor);

  // métodos de negócio
  List<Veiculo> listarVeiculos() => List.unmodifiable(_veiculos);

  void atualizarTelefone(String telefone) => this.telefone = telefone;

  void adicionarVeiculo(Veiculo veiculo) {
    if (_veiculos.contains(veiculo)) {
      throw StateError('Veículo já vinculado a este responsável');
    }
    _veiculos.add(veiculo);
  }

  bool removerVeiculo(Veiculo veiculo) => _veiculos.remove(veiculo);

  // documento não entra no copyWith para respeitar a imutabilidade
  Responsavel copyWith({
    String? nome,
    String? telefone,
    String? email,
    List<Veiculo>? veiculos,
  }) {
    return Responsavel(
      nome: nome ?? _nome,
      documento: documento,
      telefone: telefone ?? _telefone,
      email: email ?? _email,
      veiculos: veiculos ?? _veiculos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': _nome,
      'documento': documento,
      'telefone': _telefone,
      'email': _email,
    };
  }

  @override
  String toString() {
    return 'Responsavel(nome: $_nome, documento: $documento, '
        'telefone: $_telefone, email: $_email, '
        'veiculos: ${_veiculos.length})';
  }

  // validações
  static String _validarNome(String valor) {
    final nome = valor.trim();
    if (nome.isEmpty) {
      throw ArgumentError('Nome não pode ser vazio');
    }
    return nome;
  }

  // aceita CPF (11 dígitos) ou CNPJ (14 dígitos), com ou sem máscara
  static String _validarDocumento(String valor) {
    final digitos = valor.replaceAll(RegExp(r'\D'), '');
    if (digitos.length != 11 && digitos.length != 14) {
      throw ArgumentError('Documento deve ser um CPF ou CNPJ válido');
    }
    return digitos;
  }

  // aceita telefone fixo (10 dígitos) ou celular (11 dígitos) com DDD
  static String _validarTelefone(String valor) {
    final digitos = valor.replaceAll(RegExp(r'\D'), '');
    if (digitos.length != 10 && digitos.length != 11) {
      throw ArgumentError('Telefone deve conter DDD e 8 ou 9 dígitos');
    }
    return digitos;
  }

  static String _validarEmail(String valor) {
    final email = valor.trim();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      throw ArgumentError('E-mail inválido');
    }
    return email;
  }
}
