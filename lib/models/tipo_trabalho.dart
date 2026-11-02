/// Representa um tipo de serviço que pode ser associado a um atendimento.
///
/// Em `ItemAtendimento`, [idTipoTrabalho] pode ser usado como chave estrangeira
/// e [valorPadrao] como valor inicial do item. O item deve guardar seu próprio
/// valor unitário para preservar o preço combinado quando este tipo for
/// reajustado futuramente.
class TipoTrabalho {
  /// Identificador do tipo de trabalho no cadastro.
  final int idTipoTrabalho;

  /// Descrição apresentada para o serviço, com até 100 caracteres.
  final String descricao;

  double _valorPadrao;

  /// Valor padrão cobrado por este tipo de trabalho.
  double get valorPadrao => _valorPadrao;

  /// Cria um tipo de trabalho validando seus dados de cadastro.
  factory TipoTrabalho({
    required int idTipoTrabalho,
    required String descricao,
    required double valorPadrao,
  }) {
    if (idTipoTrabalho <= 0) {
      throw ArgumentError.value(
        idTipoTrabalho,
        'idTipoTrabalho',
        'Deve ser um identificador positivo.',
      );
    }

    return TipoTrabalho._(
      _validarValor(valorPadrao),
      idTipoTrabalho: idTipoTrabalho,
      descricao: _validarDescricao(descricao),
    );
  }

  TipoTrabalho._(
    this._valorPadrao, {
    required this.idTipoTrabalho,
    required this.descricao,
  });

  /// Atualiza o valor padrão após validar que ele é finito e não negativo.
  void reajustarValor(double novoValor) {
    _valorPadrao = _validarValor(novoValor);
  }

  /// Cria uma cópia, substituindo somente os dados informados.
  TipoTrabalho copyWith({
    int? idTipoTrabalho,
    String? descricao,
    double? valorPadrao,
  }) {
    return TipoTrabalho(
      idTipoTrabalho: idTipoTrabalho ?? this.idTipoTrabalho,
      descricao: descricao ?? this.descricao,
      valorPadrao: valorPadrao ?? _valorPadrao,
    );
  }

  /// Converte o objeto para as chaves usadas pela tabela `tipo_trabalho`.
  Map<String, dynamic> toMap() {
    return {
      'id_tipo_trabalho': idTipoTrabalho,
      'descricao': descricao,
      'valor_padrao': _valorPadrao,
    };
  }

  /// Reconstrói um tipo de trabalho a partir dos dados da tabela.
  factory TipoTrabalho.fromMap(Map<String, dynamic> map) {
    final descricao = map['descricao'];
    if (descricao is! String) {
      throw const FormatException('O campo "descricao" deve conter um texto.');
    }

    return TipoTrabalho(
      idTipoTrabalho: _converterParaInt(
        map['id_tipo_trabalho'],
        'id_tipo_trabalho',
      ),
      descricao: descricao,
      valorPadrao: _converterParaDouble(map['valor_padrao'], 'valor_padrao'),
    );
  }

  @override
  String toString() {
    return 'TipoTrabalho('
        'idTipoTrabalho: $idTipoTrabalho, '
        'descricao: $descricao, '
        'valorPadrao: $_valorPadrao)';
  }

  static String _validarDescricao(String descricao) {
    final descricaoNormalizada = descricao.trim();
    if (descricaoNormalizada.isEmpty) {
      throw ArgumentError.value(
        descricao,
        'descricao',
        'Não pode ficar vazia.',
      );
    }
    if (descricaoNormalizada.runes.length > 100) {
      throw ArgumentError.value(
        descricao,
        'descricao',
        'Deve ter no máximo 100 caracteres.',
      );
    }
    return descricaoNormalizada;
  }

  static double _validarValor(double valor) {
    if (!valor.isFinite || valor < 0) {
      throw ArgumentError.value(
        valor,
        'valorPadrao',
        'Deve ser um valor numérico finito e não negativo.',
      );
    }
    return valor;
  }

  static int _converterParaInt(Object? valor, String campo) {
    if (valor is int) {
      return valor;
    }
    if (valor is num && valor.isFinite && valor == valor.toInt()) {
      return valor.toInt();
    }
    if (valor is String) {
      final convertido = int.tryParse(valor.trim());
      if (convertido != null) {
        return convertido;
      }
    }
    throw FormatException('O campo "$campo" deve conter um número inteiro.');
  }

  static double _converterParaDouble(Object? valor, String campo) {
    if (valor is num) {
      return valor.toDouble();
    }
    if (valor is String) {
      final convertido = double.tryParse(valor.trim());
      if (convertido != null) {
        return convertido;
      }
    }
    throw FormatException('O campo "$campo" deve conter um valor numérico.');
  }
}
