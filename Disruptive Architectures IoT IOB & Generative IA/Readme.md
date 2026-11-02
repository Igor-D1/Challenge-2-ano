## Integrantes

| Nome | RM |
|---|---|
| Alan Christopher Gonzaga Miranda | 567033 |
| Guilherme Santos Sena | 568101 |
| Igor Dantas da Silva | 568337 |

**Turma:** 2TDS — Análise e Desenvolvimento de Sistemas · FIAP · 2026

---

# AtomicPulse — Camada IoT & Redes

> **Disruptive Architectures: IoT, IoB & Generative IA**
> Challenge FIAP 2026 · 2TDS (Agosto) · Empresa parceira: **AMazul / Marinha do Brasil**

---

## Sobre este documento

Este README documenta a **proposta de Internet das Coisas (IoT) e Redes** do projeto
AtomicPulse, desenvolvida para a disciplina de Disruptive Architectures.

Conforme o escopo da Sprint 1, esta entrega é **conceitual**: descreve a aplicação de
IoT no projeto, os componentes previstos, a forma de comunicação e o fluxo de dados —
sem implementação física nesta etapa.

---

## O projeto em uma frase

O **AtomicPulse** é um aplicativo mobile gamificado que aproxima a sociedade da
tecnologia nuclear, apresentando suas aplicações reais (medicina, energia, indústria,
agricultura) de forma acessível e envolvente — combatendo a associação
**"nuclear = bomba"** que domina o imaginário popular.

O app combina duas frentes:

| Frente | O que faz |
|---|---|
| **Engajamento (Jogo)** | Quiz com 3 níveis de dificuldade, sistema de XP e streaks, salas com QR Code para palestras e eventos |
| **Inteligência (Radar)** | Monitoramento de notícias e menções públicas sobre energia nuclear, com classificação por tema, sentimento e urgência |

**Empresa parceira:** AMazul (Amazônia Azul Tecnologias de Defesa S.A.), empresa pública
vinculada ao Ministério da Defesa por meio do Comando da Marinha, responsável por
tecnologias do Programa Nuclear da Marinha (PNM), do PROSUB e do Programa Nuclear Brasileiro.

---

## Onde o IoT entra neste projeto

O AtomicPulse é, na sua essência, um **produto digital**. Não há sensor de radiação,
reator ou equipamento físico no escopo — e isso é uma decisão de projeto, não uma
limitação.

A camada de IoT do AtomicPulse é a **telemetria do próprio aplicativo**: o celular do
usuário é o dispositivo conectado, o app é o sensor de comportamento, e cada interação
gera um evento que viaja pela rede até a API.

### Por que isso é IoT

Internet das Coisas não é sinônimo de hardware industrial. A definição técnica é:
**dispositivo com capacidade de sensoriamento, conectado em rede, gerando dados que
alimentam uma decisão**. O smartphone atende aos três critérios:

| Critério de IoT | Como o AtomicPulse atende |
|---|---|
| **Dispositivo com sensoriamento** | O app captura eventos de uso: partida iniciada, resposta dada, nível concluído, notícia aberta, tempo de sessão |
| **Conectividade em rede** | O dispositivo envia esses eventos à API por MQTT sobre a rede móvel ou Wi-Fi |
| **Dado que vira decisão** | A AMazul recebe métricas de engajamento real e usa isso para orientar a comunicação |

### Necessidade atendida

O projeto tem um problema concreto de medição. O Radar mostra **o que o público fala**
sobre energia nuclear na internet. Mas não mostra **o que o público faz** dentro da
plataforma: quantas pessoas jogam, onde desistem, qual tema gera mais erro, qual nível
é mais difícil.

Sem essa camada, a AMazul investe em comunicação sem saber o que funciona.

| Necessidade do projeto | Como a telemetria resolve |
|---|---|
| Saber se o app realmente engaja | Mede sessões, partidas concluídas e tempo de uso |
| Identificar onde o público desiste | Registra o ponto exato de abandono em cada fluxo |
| Descobrir quais temas geram mais dúvida | Cruza erros do quiz com os 4 pilares (medicina, energia, defesa, combustível) |
| Dar à AMazul prova de alcance | Painel com números reais de uso, sem depender de estimativa |
| Retroalimentar o Radar | O comportamento do público orienta quais temas priorizar na curadoria de notícias |

---

## Componentes previstos

| Componente | Função | Onde fica |
|---|---|---|
| **Aplicativo AtomicPulse (Flutter)** | Atua como sensor: captura eventos de uso e os publica na rede | Dispositivo do usuário |
| **SDK de telemetria** | Camada dentro do app que empacota, enfileira e envia os eventos com tolerância a falha de rede | Dentro do app |
| **Broker MQTT** | Recebe os eventos publicados pelos dispositivos e os distribui para a API | Nuvem |
| **API de telemetria** | Valida, normaliza e persiste os eventos recebidos | Nuvem / servidor da aplicação |
| **Banco de dados** | Armazena o histórico de eventos e as métricas agregadas | Nuvem (Oracle) |
| **Painel de engajamento** | Consolida os dados em indicadores para a AMazul | Interface web / dentro do app |

> **Nota:** nenhum componente exige hardware dedicado. Toda a camada roda em
> infraestrutura de software já prevista no projeto.

---

## Comunicação e redes

A arquitetura usa dois protocolos, cada um na camada onde faz sentido:

1. **App → Broker (MQTT)** — o app publica eventos em tópicos organizados por tipo
   (`quiz/partida`, `quiz/resposta`, `noticia/abertura`). O MQTT foi escolhido porque
   mantém conexão persistente, tem payload mínimo e sobrevive a oscilações de rede
   móvel — cenário comum no uso real de um app.
2. **Broker → API (MQTT)** — a API assina os tópicos de interesse e processa os eventos
   de forma assíncrona, sem bloquear a experiência do usuário.
3. **API → Painel (HTTPS/REST)** — o painel de engajamento consulta os dados agregados
   via HTTPS, com autenticação.

**Por que MQTT e não apenas HTTP:** o app gera muitos eventos pequenos e frequentes.
HTTP exigiria uma requisição completa com cabeçalho a cada evento, o que consome bateria
e banda. O MQTT mantém uma conexão aberta e envia apenas o payload — mais eficiente em
dispositivo móvel, que é justamente o dispositivo desta camada.

**Tolerância a falha:** o SDK mantém uma fila local. Se o dispositivo estiver sem rede,
os eventos ficam armazenados e são enviados quando a conexão retorna — garantindo que
nenhum dado de engajamento seja perdido.

---

## Fluxo de dados

┌──────────────────┐ │ USUÁRIO │ Interage com o app: joga o quiz, │ (DISPOSITIVO) │ lê notícia,
entra em sala └────────┬─────────┘ │ ação do usuário ▼ ┌──────────────────┐ │ APP 
ATOMIC │ Captura o evento e o empacota │ PULSE + SDK │ (tipo, timestamp, contexto)
└────────┬─────────┘ │ MQTT (rede móvel ou Wi-Fi) │ fila local se estiver offline ▼
┌──────────────────┐ │ BROKER MQTT │ Recebe e distribui os eventos │ │ por tópico
└────────┬─────────┘ │ assinatura de tópico ▼ ┌──────────────────┐ │ API DE │ Valida,
normaliza e persiste │ TELEMETRIA │ os eventos recebidos └────────┬─────────┘ │ gravação ▼
┌──────────────────┐ │ BANCO DE DADOS │ Histórico de eventos e │ (ORACLE) │ métricas
agregadas └────────┬─────────┘ │ HTTPS / REST ▼ ┌──────────────────┐ │ PAINEL DE
│ Consolida indicadores de │ ENGAJAMENTO │ engajamento para a AMazul └────────┬─────────┘ │
▼ ┌──────────────────────────────────────────────────┐ │ RESULTADO PARA A AMAZUL │ │
• Quantas pessoas jogam e até onde chegam │ │ • Quais temas geram mais erro no quiz │ │
• Onde o público abandona a experiência │ │ • Quais notícias geram mais interesse │ │
• Base objetiva para orientar a comunicação │ └──────────────────────────────────────────────────┘



**Resumo do caminho:** o usuário interage com o app, o app captura o evento, o evento
viaja por MQTT até o broker, a API processa e grava, e o painel transforma o histórico
em indicador de engajamento para a AMazul.

---

## Benefício gerado

- **Mede o que o Radar não mede.** O Radar mostra o que o público fala; a telemetria
  mostra o que o público faz. Juntas, as duas camadas dão à AMazul uma visão completa.
- **Substitui estimativa por dado.** A AMazul passa a saber o alcance real das suas
  ações de comunicação, em vez de trabalhar com suposição.
- **Orienta a curadoria de conteúdo.** Se um tema gera muito erro no quiz, ele precisa
  de mais conteúdo educativo — e a telemetria identifica isso automaticamente.
- **Melhora o produto com o uso.** Cada sessão alimenta a evolução do app: onde há
  abandono, onde há engajamento, o que precisa ser ajustado.
- **Custo zero de hardware.** Toda a camada roda em software já previsto no projeto,
  sem aquisição de equipamento e sem aumento de complexidade operacional.

---

## Materiais do projeto

O documento completo da solução (pitch de Compliance & QA), com problema, público-alvo,
funcionalidades, diferenciais e comparativo de mercado, está disponível em:

📄 **[AtomicPulse — Entrega Final QA (PDF)](../docs/AtomicPulse_EntregaFinal_QA.pdf)**

> Para que o link funcione, coloque o arquivo PDF na pasta `docs/` na raiz do repositório,
> mantendo o nome `AtomicPulse_EntregaFinal_QA.pdf`.

### Outros materiais

| Material | Onde encontrar |
|---|---|
| Vídeo de apresentação (YouTube, não listado) | *(inserir link)* |
| Fluxograma em imagem | `./fluxograma-iot.png` |
| Documento-mestre do projeto | `../docs/Contexto_Projeto_Challenge_AMazul.docx` |

---


## Escopo desta entrega

Esta entrega contempla **exclusivamente a ideação** da camada de IoT e Redes, conforme
definido no edital da Sprint 1:

- ✅ Descrição da aplicação e sua contribuição ao projeto
- ✅ Componentes previstos e suas funções
- ✅ Forma de comunicação entre dispositivos e sistema
- ✅ Fluxograma do caminho dos dados
- ❌ Implementação física do sistema (fora do escopo desta etapa)

---

## Referências

- **AMazul** — Amazônia Azul Tecnologias de Defesa S.A. · [amazul.marinha.mil.br](https://www.amazul.marinha.mil.br)
- **FIAP** — Challenge 2026, 2º ano de ADS, turma de agosto
