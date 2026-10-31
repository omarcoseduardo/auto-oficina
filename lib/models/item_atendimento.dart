import 'tipo_trabalho.dart';

/// Representa um trabalho executado dentro de um atendimento.
///
/// Cada item referencia um [TipoTrabalho], guarda a [quantidade] realizada e
/// mantém o seu próprio [valorUnitario]. Esse valor é uma cópia do preço no
/// momento em que o item foi criado, então reajustar o [TipoTrabalho] depois
/// (`reajustarValor()`) não altera itens de atendimentos já registrados.
class ItemAtendimento {
  /// Tipo de trabalho executado (coluna `id_tipo_trabalho`).
  final TipoTrabalho tipo;

  /// Valor cobrado por unidade, fixado na criação do item.
  final double valorUnitario;

  int _quantidade;

  /// Quantidade executada; sempre maior que zero.
  int get quantidade => _quantidade;

  /// Altera a quantidade após validar que ela é positiva.
  set quantidade(int novaQuantidade) {
    _quantidade = _validarQuantidade(novaQuantidade);
  }

  /// Cria um item validando seus dados.
  ///
  /// Se [valorUnitario] não for informado, usa o `valorPadrao` atual de [tipo].
  factory ItemAtendimento({
    required TipoTrabalho tipo,
    required int quantidade,
    double? valorUnitario,
  }) {
    return ItemAtendimento._(
      tipo,
      _validarValorUnitario(valorUnitario ?? tipo.valorPadrao),
      _validarQuantidade(quantidade),
    );
  }

  ItemAtendimento._(this.tipo, this.valorUnitario, this._quantidade);

  /// Calcula o subtotal do item: `quantidade * valorUnitario`,
  /// arredondado para centavos.
  double calcularSubtotal() {
    return (_quantidade * valorUnitario * 100).round() / 100;
  }

  /// Cria uma cópia, substituindo somente a quantidade.
  ///
  /// [tipo] e [valorUnitario] são imutáveis e, por isso, não podem ser
  /// trocados por aqui; isso preserva o preço combinado do item.
  ItemAtendimento copyWith({int? quantidade}) {
    return ItemAtendimento(
      tipo: tipo,
      quantidade: quantidade ?? _quantidade,
      valorUnitario: valorUnitario,
    );
  }

  /// Converte o objeto para as chaves usadas pela tabela `item_atendimento`.
  ///
  /// Inclui o tipo de trabalho aninhado em `tipo_trabalho` para que o item
  /// possa ser reconstruído sem consultar outra fonte.
  Map<String, dynamic> toMap() {
    return {
      'id_tipo_trabalho': tipo.idTipoTrabalho,
      'quantidade': _quantidade,
      'valor_unitario': valorUnitario,
      'tipo_trabalho': tipo.toMap(),
    };
  }

  /// Reconstrói um item a partir dos dados da tabela.
  ///
  /// O tipo de trabalho vem de [tipo], quando informado (por exemplo, já
  /// carregado do cadastro), ou do mapa aninhado em `tipo_trabalho`.
  factory ItemAtendimento.fromMap(
    Map<String, dynamic> map, {
    TipoTrabalho? tipo,
  }) {
    final TipoTrabalho tipoItem;
    if (tipo != null) {
      tipoItem = tipo;
    } else {
      final tipoMap = map['tipo_trabalho'];
      if (tipoMap is! Map<String, dynamic>) {
        throw const FormatException(
          'Informe o tipo de trabalho ou o campo "tipo_trabalho".',
        );
      }
      tipoItem = TipoTrabalho.fromMap(tipoMap);
    }

    final idReferenciado = map['id_tipo_trabalho'];
    if (idReferenciado != null &&
        _converterParaInt(idReferenciado, 'id_tipo_trabalho') !=
            tipoItem.idTipoTrabalho) {
      throw const FormatException(
        'O campo "id_tipo_trabalho" não corresponde ao tipo de trabalho.',
      );
    }

    return ItemAtendimento(
      tipo: tipoItem,
      quantidade: _converterParaInt(map['quantidade'], 'quantidade'),
      valorUnitario: _converterParaDouble(
        map['valor_unitario'],
        'valor_unitario',
      ),
    );
  }

  @override
  String toString() {
    return 'ItemAtendimento('
        'tipo: ${tipo.descricao}, '
        'quantidade: $_quantidade, '
        'valorUnitario: $valorUnitario, '
        'subtotal: ${calcularSubtotal()})';
  }

  static int _validarQuantidade(int quantidade) {
    if (quantidade <= 0) {
      throw ArgumentError.value(
        quantidade,
        'quantidade',
        'Deve ser maior que zero.',
      );
    }
    return quantidade;
  }

  static double _validarValorUnitario(double valor) {
    if (!valor.isFinite || valor < 0) {
      throw ArgumentError.value(
        valor,
        'valorUnitario',
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