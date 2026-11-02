# ⚛️ AtomicPulse — Challenge FIAP 2026 (AMazul)

> **Solução Digital Gamificada e Monitoramento da Informação sobre Tecnologia Nuclear**
>
> **Turma:** 2TDS (Análise e Desenvolvimento de Sistemas — 2º ano)
>
> **Empresa Parceira:** AMazul (Amazônia Azul Tecnologias de Defesa S.A.)

---

## 📌 Sumário

- [1. Sobre o Projeto](#1-sobre-o-projeto)
- [2. O Desafio e a Problemática](#2-o-desafio-e-a-problemática)
- [3. A Solução Proposta](#3-a-solução-proposta)
- [4. Funcionalidades Principais](#4-funcionalidades-principais)
- [5. Sistema de Ranking e Gamificação](#5-sistema-de-ranking-e-gamificação)
- [6. Referências de Mercado](#6-referências-de-mercado)
- [7. Arquitetura da Solução por Disciplina](#7-arquitetura-da-solução-por-disciplina)
- [8. Camada IoT — Telemetria do Aplicativo](#8-camada-iot--telemetria-do-aplicativo)
- [9. Integrantes](#9-integrantes)

---

## 1. Sobre o Projeto

O **AtomicPulse** é uma plataforma digital desenvolvida para responder ao **Challenge FIAP 2026**, em parceria com a **AMazul**. O projeto combina engajamento educacional (através de um aplicativo mobile gamificado) com um motor de inteligência e escuta social (**Radar de Informação**), permitindo desmistificar o uso da energia nuclear no Brasil e combater a desinformação na fonte.

---

## 2. O Desafio e a Problemática

- **Problemática:** A tecnologia e a energia nuclear ainda enfrentam forte rejeição social devido à falta de informação. A associação popular predominante é que _"tecnologia nuclear = bomba ou desastre"_, ignorando suas aplicações pacíficas cruciais.
- **O Desafio:** _"Como desenvolver uma solução digital inovadora e interativa capaz de aproximar a sociedade da tecnologia nuclear, demonstrando suas aplicações e seus benefícios de maneira acessível, educativa e envolvente?"_
- **Pilares da AMazul Abordados:**
1. Submarino convencionalmente armado com propulsão nuclear (SN Álvaro Alberto — PROSUB).
2. Produção de combustível nuclear (PNM).
3. Geração de energia elétrica (PNB).
4. Produção de radiofármacos (Medicina Nuclear e Saúde público-privada).

---

## 3. A Solução Proposta

O **AtomicPulse** atua em um ciclo contínuo de 4 etapas: DETECTAR → CLASSIFICAR → RESPONDER → RECOMPENSAR

1. **Detectar:** O _Radar_ monitora menções, notícias e dados públicos sobre energia nuclear.
2. **Classificar:** Algoritmos de IA categorizam o tema, o sentimento e a urgência do conteúdo.
3. **Responder:** Especialistas da AMazul atuam diretamente na fonte corrigindo fake news ou prestando informações.
4. **Recompensar:** O público acumula pontos e insígnias aprendendo no quiz e ajudando a identificar conteúdos duvidosos.

---

## 4. Funcionalidades Principais

### 4.1. Escopo Base (Piso)

- **Home com Ticker de Notícias:** Barra informativa estilo "televisor" na tela principal que abre matérias completas.
- **Quiz Gamificado:** 3 níveis de dificuldade (Fácil, Médio, Difícil); banco de 40 a 50 perguntas por nível com seleção aleatória; quantidade de perguntas configurável ao criar ou iniciar uma partida; botão de perguntas dinâmicas via IA.
- **Salas Personalizadas para Palestras:** Criação de salas via Dashboard de Admin com geração de QR Code para eventos e apresentações presenciais.
- **Interface Responsiva e Acessível (Mobile):** Construída em Flutter/Dart.

### 4.2. Diferenciais e Visão Futura (Plus)

- **Radar Real de Notícias:** Coleta automatizada via Google News RSS e GDELT.
- **Central de Escuta Social:** Triagem de menções em redes sociais para apoio institucional da AMazul.
- **Caça ao Fake (Sprint 2):** Mecanismo de denúncia pela comunidade de notícias ou posts suspeitos.
- **Contestação e Anulação de Perguntas (Sprint 2/3):** Auditoria colaborativa do conteúdo do quiz.
- **Modo Mito ou Verdade:** Cards rápidos para desmistificação instantânea de conceitos.
- **Explicação por IA pós-erro:** O erro transforma-se em aprendizado imediato contextualizado.

---

## 5. Sistema de Ranking e Gamificação

- **Pontuação (XP):** Ganho de XP por acertos consecutivos (_streaks_).
- **Decisão de Design:** Bônus por velocidade foi **descartado** para evitar divergências pelo relógio local do cliente.
- **Modalidades de Ranking:** Global (geral), Semanal (reiniciado periodicamente), Por Dificuldade (Fácil, Médio, Difícil) e Por Sala (competição em tempo real durante palestras).
- **Privacidade e LGPD:** Apelido/Nickname como padrão público. Nome real opcional para preservar dados pessoais.

---

## 6. Referências de Mercado

| Referência | Ponto Forte Adotado | Diferencial do AtomicPulse |
| :-- | :-- | :-- |
| **Kahoot!** | Dinamismo de salas ao vivo, QR Code e engajamento presencial em palestras. | Foco temático especializado, radar de escuta social e combate ativo à desinformação. |
| **Duolingo** | Trilha de aprendizagem, retenção por _streaks_ (sequências) e progressão por níveis. | Integração direta com a operação de comunicação pública institucional da AMazul. |

---

## 7. Arquitetura da Solução por Disciplina

### 📱 Mobile (Flutter/Dart)

- Protótipo funcional com navegação entre telas via gerenciamento de estado (`setState`).
- Telas: Splash/Login, Home com Ticker, Lista de Notícias, Seleção de Nível, Quiz, Resultado e Criar Sala (com validação de formulário).
- Dados mockados para validação de UX.

### ☕ Java Advanced

- **API RESTful** construída em **Spring Boot (Spring Data JPA)**.
- **CRUD completo** da entidade `Pergunta` (Motor do Quiz).
- Tratamento global de exceções, validação de DTOs e documentação interativa via **Swagger**.

### 💻 .NET

- Aplicação Console/Service focada no tratamento da entidade `Noticia` (Base do Radar de Notícias).
- Validações, regras de negócio e persistência em Oracle DB / EF Core.

### 🗄️ Banco de Dados (Oracle)

- Modelagem Conceitual, Lógico-Física em **3FN** (Notação Barker).
- Script DDL sem erros e DML populado com registros de exemplo.
- Entidades principais: `Usuario`, `Pergunta`, `Partida`, `Noticia`.

### ☁️ DevOps / Cloud

- API Java containerizada através de **Dockerfile**.
- Infraestrutura provisionada na **Microsoft Azure (VM)** via Azure CLI.

### 📑 Compliance, QA & Pitch

- Apresentação executiva em PDF contemplando: pitch, problema, público-alvo, escopo, diferenciais e comparação competitiva.

---

## 8. Camada IoT — Telemetria do Aplicativo

A proposta de IoT do projeto está documentada na pasta da disciplina:
[Disruptive Architectures IoT IOB & Generative IA](./Disruptive%20Architectures%20IoT%20IOB%20%26%20Generative%20IA/README.md)

**Resumo:** o celular do usuário é o dispositivo IoT, o app é o sensor de comportamento e os eventos de uso (partida iniciada, resposta dada, nível concluído, notícia aberta) são enviados à API via HTTPS/REST para gerar métricas de engajamento para a AMazul.

O Radar mede **o que o público fala**; a telemetria mede **o que o público faz**. Juntas, as duas camadas dão à AMazul uma visão completa da comunicação.

---

## 9. Integrantes

- **Alan Christopher** — _RM567033_
- **Guilherme Sena** — _RM568101_
- **Igor Dantas** — _RM568337_

---

_Projeto desenvolvido para o Challenge FIAP 2026._
