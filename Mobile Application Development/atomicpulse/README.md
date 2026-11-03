# AtomicPulse --- Conexão Nuclear

Aplicativo Flutter educativo desenvolvido como protótipo mobile para
apresentar conteúdos relacionados à AMazul, à tecnologia nuclear e aos
programas estratégicos da Marinha do Brasil. O projeto prioriza
navegação entre telas, interface visual consistente, gerenciamento de
estado local e conteúdo de demonstração armazenado em arquivos JSON.

> **Estado do projeto:** protótipo acadêmico. Notícias, perfil e parte
> do conteúdo são dados locais/de demonstração. O recurso chamado
> "Gerador IA" ainda não integra um serviço de inteligência artificial:
> no código atual, ele cria questões repetidas de forma simulada.

## Objetivos

-   Apresentar informações introdutórias sobre a AMazul e aplicações da
    tecnologia nuclear.
-   Exibir notícias de demonstração e perguntas frequentes.
-   Oferecer um quiz com temporizador, pontuação, denúncia de questão e
    importação de perguntas em JSON ou TXT.
-   Demonstrar navegação entre telas, widgets Flutter e atualização de
    estado com `StatefulWidget`/`setState`.
-   Permitir personalização da cor de destaque da interface.

## Funcionalidades

-   **Splash screen:** exibe a identidade visual e encaminha para a
    navegação principal após alguns segundos.
-   **Home / Notícias:** carrega notícias do arquivo
    `assets/json/news.json`, destaca uma notícia e abre um resumo ao
    tocar em um item.
-   **Sobre a AMazul:** apresenta um resumo institucional e quatro
    pilares tecnológicos ilustrativos.
-   **Quiz:** permite selecionar um nível e uma quantidade de questões
    na aba "Gerador IA", ou colar conteúdo na aba "Personalizado" para
    importar um quiz JSON/TXT.
-   **Partida do quiz:** apresenta uma questão por vez, temporizador de
    30 segundos, pontuação de 10 pontos por resposta correta e opção de
    reportar uma questão.
-   **Perfil:** mostra estatísticas ilustrativas; os valores
    apresentados não são vinculados a uma conta ou persistência real.
-   **Configurações:** permite alterar a cor de destaque durante a
    execução.
-   **FAQ:** apresenta perguntas e respostas sobre AMazul, energia
    nuclear e o Reator Multipropósito Brasileiro.

## Tecnologias e dependências

-   **Flutter** com **Dart** (o `pubspec.yaml` declara Dart
    `>=3.0.0 <4.0.0`).
-   Material Design 3 e widgets nativos do Flutter.
-   `cupertino_icons` como dependência de ícones.
-   `flutter_test` e `flutter_lints` nas dependências de
    desenvolvimento.
-   Arquivos JSON locais para conteúdo de notícias e perguntas.
-   Não há backend, banco de dados, autenticação, integração de notícias
    ao vivo ou API de IA configurados no estado atual.

## Estrutura do projeto

``` text
atomicpulse/
├── assets/
│   ├── icons/icon_app.png
│   ├── images/logo.jpeg
│   └── json/
│       ├── news.json
│       └── quiz_example.json
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── news_model.dart
│   │   └── quiz_model.dart
│   ├── pages/
│   │   ├── splash_page.dart
│   │   ├── main_navigation_page.dart
│   │   ├── home_page.dart
│   │   ├── about_page.dart
│   │   ├── quiz_page.dart
│   │   ├── quiz_play_page.dart
│   │   ├── profile_page.dart
│   │   ├── settings_page.dart
│   │   └── faq_page.dart
│   ├── repositories/
│   │   ├── news_repository.dart
│   │   └── quiz_repository.dart
│   ├── theme/app_theme.dart
│   └── widgets/
│       ├── faq_buttom.dart
│       ├── news_card.dart
│       └── news_header.dart
├── test/widget_test.dart
├── pubspec.yaml
└── README.md
```

### Organização do código

-   **`pages/`**: telas e fluxos de navegação.
-   **`models/`**: modelos `NewsModel`, `QuestionModel` e `QuizModel`,
    que representam os dados utilizados pela interface.
-   **`repositories/`**: leitura de notícias do JSON e
    criação/importação de quizzes.
-   **`theme/`**: cores e estilos compartilhados.
-   **`widgets/`**: componentes de interface reutilizados.
-   **`assets/json/`**: conteúdo de demonstração editável sem alterar a
    lógica da interface.

## Pré-requisitos

1.  Instale o **Flutter SDK** e o **Dart SDK** compatível.
2.  Instale e configure uma plataforma de execução:
    -   **Android:** Android Studio, Android SDK e um emulador ou
        dispositivo com depuração USB habilitada.
    -   **Web:** Google Chrome instalado.
    -   **Windows/macOS/Linux:** ferramentas de compilação exigidas pelo
        Flutter para o sistema operacional.
3.  No terminal, confirme a instalação:

``` bash
flutter --version
flutter doctor
```

O arquivo `android/local.properties`, quando presente em uma máquina de
desenvolvimento, deve conter caminhos locais para o Android SDK e o
Flutter SDK. Ele é específico de cada computador e não deve ser
compartilhado como configuração universal.

## Como instalar e executar

Abra um terminal na pasta `atomicpulse`, onde está o arquivo
`pubspec.yaml`.

``` bash
flutter pub get
flutter run
```

Se houver mais de um dispositivo disponível, liste os destinos e
selecione um:

``` bash
flutter devices
flutter run -d <device_id>
```

Para executar no navegador Chrome:

``` bash
flutter run -d chrome
```

Para gerar um APK Android de release:

``` bash
flutter build apk --release
```

O APK, quando a compilação terminar com sucesso, costuma ser gerado em
`build/app/outputs/flutter-apk/app-release.apk`.

## Como usar o aplicativo

1.  Inicie o aplicativo; a tela de abertura encaminha para a área
    principal.
2.  Use a barra de navegação inferior para abrir **Home**, **Sobre**,
    **Quiz**, **Perfil** e **Configurações**.
3.  Na **Home**, leia a notícia em destaque, toque em uma notícia para
    ver o resumo e abra o FAQ pelo botão correspondente.
4.  Em **Sobre**, consulte o resumo da AMazul e os pilares apresentados.
5.  Em **Quiz**:
    -   **Gerador IA:** escolha Fácil, Médio ou Difícil, selecione a
        quantidade e inicie. No código atual, isso é uma simulação
        local, não uma chamada real a um modelo de IA (por enquanto).
    -   **Personalizado:** cole o conteúdo JSON ou TXT na caixa e
        escolha o botão de importação correspondente.
    -   Durante a partida, selecione uma alternativa antes de o
        temporizador zerar. Cada resposta correta vale 10 pontos. O
        botão de alerta marca a questão como reportada e anula sua
        pontuação.
6.  Em **Perfil**, veja os indicadores de exemplo. Eles são estáticos e
    não representam progresso persistido.
7.  Em **Configurações**, toque em uma cor para alterar a cor de
    destaque da interface durante a sessão.

## Como adicionar ou editar notícias

Edite `assets/json/news.json`. O arquivo contém uma lista de objetos com
os campos abaixo:

``` json
[
  {
    "id": "1",
    "title": "Título da notícia",
    "summary": "Resumo curto da notícia.",
    "category": "Ciência",
    "date": "2026-10-20",
    "url": "https://exemplo.org/noticia",
    "isHighlight": true
  }
]
```

-   `id`: identificador textual.
-   `title`: título.
-   `summary`: resumo mostrado na interface.
-   `category`: categoria exibida.
-   `date`: data em formato textual, preferencialmente `AAAA-MM-DD`.
-   `url`: endereço relacionado à notícia. A interface atual não navega
    automaticamente para esse endereço.
-   `isHighlight`: `true` para marcar uma notícia em destaque; caso
    nenhuma seja marcada, a primeira notícia disponível é usada.

Mantenha o JSON válido, use aspas duplas e não deixe vírgula após o
último campo. Depois de alterar assets, reinicie a aplicação se a
mudança não aparecer com hot reload.

## Como adicionar questões ao quiz JSON

Utilize `assets/json/quiz_example.json`. O arquivo de exemplo incluído
contém **50 questões**. Cada questão deve seguir este formato:

``` json
{
  "quizTitle": "Quiz de exemplo",
  "questions": [
    {
      "id": "q1",
      "question": "Qual é a pergunta?",
      "options": [
        "Alternativa A",
        "Alternativa B",
        "Alternativa C",
        "Alternativa D"
      ],
      "correctIndex": 1
    }
  ]
}
```

Regras importantes:

-   `quizTitle`: título do quiz.
-   `questions`: lista de questões.
-   `id`: identificador da questão.
-   `question`: enunciado.
-   `options`: lista de alternativas; o formato esperado pela interface
    é de **quatro alternativas**.
-   `correctIndex`: índice da alternativa correta, começando em zero
    (`0` = primeira, `1` = segunda, `2` = terceira, `3` = quarta).

### Formato TXT aceito pelo importador

O parser procura os marcadores `Pergunta:`, `A)`, `B)`, `C)`, `D)` e
`Correta:`. Exemplo:

``` text
Pergunta: Qual é a principal aplicação do RMB?
A) Produção de radioisótopos para medicina e pesquisa
B) Fabricação de celulares
C) Extração de petróleo
D) Construção de rodovias
Correta: 0
```

Em `Correta:`, use o índice de zero a três, não a letra da alternativa.
Cada questão precisa conter o enunciado e quatro alternativas.

### Integrantes

-   `[Alan Christopher] — RM: [567033]`
-   `[Guilherme Sena] — RM: [568101]`
-   `[Igor Dantas] — RM: [568337]`