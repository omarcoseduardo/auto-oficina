# Etapa: Implementação das Classes em Dart

O objetivo desta etapa é transformar o diagrama de classes em classes reais, organizadas em arquivos separados, respeitando os conceitos de orientação a objetos, encapsulamento, construtores, mutabilidade e relacionamentos.

---

## Parte 1 — Estrutura do projeto

O grupo deverá criar um projeto Dart, organizado de forma que:

- Cada classe seja implementada em seu próprio arquivo `.dart`.
- Os nomes das classes, atributos e métodos sejam coerentes com a modelagem apresentada.
- Os relacionamentos definidos no diagrama sejam representados utilizando objetos e coleções.
- Os atributos sejam declarados com tipos adequados.
- Sejam utilizados corretamente `final`, `const` e variáveis mutáveis.
- As responsabilidades e regras de negócio sejam mantidas nas classes apropriadas.

> Não será necessário implementar interfaces gráficas em Flutter nesta etapa.

---

## Parte 2 — Implementação das classes

Cada classe deverá possuir, conforme suas características e responsabilidades:

- **Atributos:** todos os atributos previstos na modelagem, com seus respectivos tipos.
- **Construtores:** construtores que permitam criar objetos válidos, utilizando `required`, parâmetros opcionais e valores padrão quando apropriado.
- **Encapsulamento:** controle de acesso aos atributos, utilizando atributos privados, getters e setters quando necessários.
- **`copyWith()`:** método que permita criar uma nova instância do objeto, mantendo seus valores atuais e substituindo apenas os atributos informados.
- **`toMap()`:** método que converta os dados do objeto para uma estrutura `Map<String, dynamic>`.
- **`fromMap()`:** construtor nomeado ou `factory` que permita reconstruir um objeto a partir de um `Map<String, dynamic>`.
- **`factory`:** utilizar construtores `factory` quando apropriados, especialmente para criação e reconstrução de objetos.
- **`toString()`:** sobrescrever o método para fornecer uma representação textual compreensível do objeto.
- **Métodos de negócio:** implementar os métodos identificados na modelagem, respeitando as regras do sistema.

> **Atenção:** os métodos devem ser coerentes com cada classe. A implementação deverá considerar atributos imutáveis, relacionamentos entre objetos, conversões de tipos e regras de validação.

---

## Parte 3 — Regras de implementação

Durante o desenvolvimento, o grupo deverá observar que:

1. A **placa de um veículo** e a **data de abertura de um atendimento** não poderão ser alteradas após a criação do objeto.
2. A **situação de um atendimento** deverá permitir alterações válidas.
3. Os **valores dos tipos de trabalho** poderão ser reajustados.
4. O **total de um atendimento** deverá ser calculado com base nos trabalhos associados.
5. Um **atendimento não poderá ser concluído** sem possuir pelo menos um trabalho.
6. O uso de `copyWith()` **não deverá permitir alterações que violem as regras de imutabilidade** definidas.
7. Os métodos `toMap()` e `fromMap()` deverão permitir a conversão e reconstrução coerente dos dados, incluindo os relacionamentos quando aplicáveis.

---

## Parte 4 — Entrega obrigatória nesta aula

Até o final desta aula, cada grupo deverá entregar **obrigatoriamente**:

### 1. Projeto Dart criado

O projeto deverá possuir a estrutura de arquivos organizada, com as classes identificadas na modelagem anterior, mesmo que algumas ainda não estejam completamente implementadas.

### 2. Pelo menos uma classe totalmente implementada

O grupo deverá escolher uma das classes modeladas e implementá-la completamente, contendo:

- atributos;
- construtor;
- métodos de negócio;
- `copyWith()`;
- `toMap()`;
- `fromMap()`;
- `toString()`;
- demais recursos aplicáveis.

A classe deverá estar funcional, com código válido e **sem erros de compilação**.

### 3. Repositório público no GitHub

O projeto deverá ser publicado em um **repositório público**, contendo os arquivos desenvolvidos e a estrutura do projeto.

### 4. Arquivo da classe anexado separadamente

Além do link do repositório, o grupo deverá anexar diretamente nesta atividade o **arquivo `.dart` da classe implementada por completo**.

> Não será suficiente enviar apenas o link do GitHub.

---

## Como entregar

Na atividade, o grupo deverá enviar:

- [ ] Link do repositório público do GitHub, contendo o projeto Dart.
- [ ] Arquivo `.dart` anexado separadamente, referente à classe completamente implementada.

> **IMPORTANTE:** os dois itens são obrigatórios e deverão ser entregues ainda nesta aula. A ausência de qualquer um deles caracteriza **entrega incompleta**.

---

## Continuidade do projeto

Após esta entrega inicial, os grupos deverão continuar o desenvolvimento das demais classes, implementando os relacionamentos, os métodos de negócio e as conversões necessárias.

O projeto deverá evoluir a partir da modelagem elaborada pelo próprio grupo, mantendo a coerência entre o diagrama de classes e a implementação em Dart.
