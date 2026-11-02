# Sistema de Oficina Automotiva

Projeto acadêmico em Dart para implementar as classes de um sistema de
gerenciamento de oficina automotiva, seguindo o diagrama e as orientações da
atividade.

## Objetivo

O sistema modela responsáveis, veículos, atendimentos, tipos de trabalho e os
itens associados a cada atendimento. Nesta etapa, o foco de implementação é a
classe `TipoTrabalho`. As demais classes já possuem arquivos próprios e serão
desenvolvidas nas próximas etapas.

## Estrutura do projeto

```text
lib/
└── models/
    ├── atendimento.dart
    ├── item_atendimento.dart
    ├── responsavel.dart
    ├── tipo_trabalho.dart
    └── veiculo.dart
docs/
├── Sistema de Oficina Automotiva.pdf
└── etapa-implementacao-classes-dart.md
```

## Classe `TipoTrabalho`

A classe representa um serviço que pode ser incluído em um atendimento. Ela
contém o identificador, a descrição e o valor padrão do serviço. O identificador
pode ser usado como referência em `ItemAtendimento`, e o valor padrão pode ser
usado para iniciar o valor unitário do item. Cada item deve manter seu próprio
valor unitário para preservar o preço combinado mesmo após reajustes no cadastro
do tipo de trabalho.

A implementação inclui:

- validação do identificador, da descrição e do valor;
- reajuste do valor padrão com `reajustarValor()`;
- cópia de instâncias com `copyWith()`;
- conversão para mapa e reconstrução com `toMap()` e `fromMap()`;
- representação textual com `toString()`.

## Requisitos

- Dart SDK `3.13.0` ou superior, antes da versão `4.0.0`;
- dependências definidas em `pubspec.yaml`.

## Preparação e análise

Na raiz do projeto, instale as dependências:

```bash
dart pub get
```

Para analisar o código:

```bash
dart analyze
```

Esta etapa contém os modelos, mas ainda não possui uma aplicação executável ou
interface gráfica.

## Exemplo de uso

```dart
import 'package:auto_oficina/models/tipo_trabalho.dart';

void main() {
  final tipo = TipoTrabalho(
    idTipoTrabalho: 1,
    descricao: 'Troca de óleo',
    valorPadrao: 150.00,
  );

  print(tipo.toMap());

  tipo.reajustarValor(160.00);
  print(tipo);
}
```

## Entrega da atividade

Conforme as instruções da atividade, a entrega deve incluir:

1. o link do repositório público no GitHub;
2. o arquivo `.dart` da classe totalmente implementada, anexado separadamente
   na atividade.

O diagrama e as orientações completas estão disponíveis na pasta `docs/`.
