# AtomicPulse Quiz API — Java Advanced (Sprint 1)

> **Challenge FIAP 2026** · Parceria Tecnológica com a **AMazul** (Amazônia Azul Tecnologias de Defesa S.A.)  
> **Curso**: Análise e Desenvolvimento de Sistemas (2º Ano — Turma 2TDSPA)  
> **Tecnologias**: Java 21 | Spring Boot 3.2.5 | Oracle Database JDBC (`ojdbc11`) | Spring Data JPA | Springdoc OpenAPI (Swagger UI)

---

## 1. Visão Geral do Projeto

O **AtomicPulse** é uma solução digital educativa e interativa desenvolvida para aproximar a sociedade da tecnologia nuclear brasileira, desmistificando preconceitos e destacando suas aplicações pacíficas, medicinais, industriais e de defesa nacional.

O ecossistema é composto por uma aplicação mobile (em Flutter) integrada a este **backend RESTful em Java Spring Boot**, responsável pelo gerenciamento completo do banco de dados de perguntas, categorias, níveis de dificuldade e validações do quiz.

### Principais Pilares Temáticos (Contexto AMazul / Marinha do Brasil):
1. **Medicina Nuclear**: Produção de radiofármacos pelo Reator Multipropósito Brasileiro (RMB) para diagnóstico e tratamento do câncer.
2. **Geração de Energia**: Matriz energética limpa, segura, contínua e descarbonizada (Usinas Angra 1, 2 e 3).
3. **Propulsão Naval**: Autonomia tecnológica no desenvolvimento do Submarino de Propulsão Nuclear *Álvaro Alberto* (SN-BR) pelo programa PROSUB.
4. **Tecnologia & Inovação**: Soberania científica e desenvolvimento industrial nacional na Amazônia Azul.

---

## 2. Arquitetura & Tecnologias

A aplicação segue a arquitetura em camadas (**Layered Architecture**), promovendo alta coesão, baixo acoplamento e separação clara de responsabilidades:

* **Linguagem & Framework**: Java 21 + Spring Boot 4.1.2
* **Persistência de Dados**: Spring Data JPA (Hibernate)
* **Banco de Dados Relacional**: **Oracle Database** via Driver JDBC Nativo (`com.oracle.database.jdbc:ojdbc11`)
* **Validação de Dados**: Spring Boot Starter Validation (`jakarta.validation`)
* **Produtividade**: Lombok (`@Data`, `@NoArgsConstructor`, `@AllArgsConstructor`, `@Builder`)
* **Documentação Interativa da API**: Springdoc OpenAPI v2.5.0 (Swagger UI)
* **Gerenciador de Dependências & Build**: Apache Maven

> ⚠️ **Nota de Transição**: O banco de dados em memória H2 foi removido e substituído integralmente pela conexão nativa **Oracle JDBC**, alinhada ao ambiente de produção da FIAP.

---

## 3. Configuração de Ambiente (`application.yml`)

O projeto utiliza o arquivo `src/main/resources/application.yml` para centralizar as configurações de conexão ao Oracle Database e prefixos da API:

```yaml
server:
  port: 8080
  servlet:
    context-path: /api/v1

spring:
  application:
    name: quiz

  # Conexão Nativa com Oracle Database
  datasource:
    url: jdbc:oracle:thin:@oracle.fiap.com.br:1521:ORCL
    driver-class-name: oracle.jdbc.OracleDriver
    username: RMXXXXX # Seu RM da FIAP
    password: XXXXXXX # Sua senha da FIAP

  jpa:
    database-platform: org.hibernate.dialect.OracleDialect
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        format_sql: true

springdoc:
  api-docs:
    path: /v3/api-docs
  swagger-ui:
    path: /swagger-ui.html
```

---

## 4. Estrutura de Endpoints REST (`/api/v1`)

A API expõe o recurso `/perguntas` para gerenciamento completo do Quiz:

| Método | Endpoint | Descrição | Status HTTP |
| :--- | :--- | :--- | :--- |
| `GET` | `/api/v1/perguntas` | Lista todas as perguntas cadastradas no Oracle | `200 OK` |
| `GET` | `/api/v1/perguntas/{id}` | Busca pergunta por ID | `200 OK` / `404 Not Found` |
| `GET` | `/api/v1/perguntas/categoria/{cat}` | Filtra perguntas por categoria | `200 OK` |
| `GET` | `/api/v1/perguntas/dificuldade/{dif}` | Filtra perguntas por nível de dificuldade | `200 OK` |
| `POST` | `/api/v1/perguntas` | Cadastra uma nova pergunta com validação | `201 Created` / `400 Bad Request` |
| `PUT` | `/api/v1/perguntas/{id}` | Atualiza uma pergunta existente | `200 OK` / `404 Not Found` |
| `DELETE` | `/api/v1/perguntas/{id}` | Remove uma pergunta por ID | `204 No Content` / `404 Not Found` |

---

## 5. Como Executar a Aplicação

### Pré-requisitos:
* **JDK 21** instalado e configurado na variável de ambiente `JAVA_HOME`.
* Acesso ao banco de dados Oracle FIAP (preencher credenciais no `application.yml`).

### Opção 1: Executando pela IDE (Recomendado)
1. Abra o projeto no **VS Code**, **IntelliJ IDEA** ou **Eclipse**.
2. Navegue até o arquivo da classe principal:
   `src/main/java/Atomicpulse/quiz/QuizApplication.java`
3. Clique no botão **Run / Play (▶)** para iniciar a aplicação.

### Opção 2: Executando via Maven Wrapper
No terminal na raiz do projeto:

* **Windows (PowerShell)**:
  ```powershell
  .\mvnw spring-boot:run
  ```
* **Linux / macOS**:
  ```bash
  ./mvnw spring-boot:run
  ```

---

## 6. Acesso à Documentação Swagger UI

Após a inicialização com sucesso, acesse a documentação interativa da API no navegador:

👉 **Swagger UI**: `http://localhost:8080/api/v1/swagger-ui/index.html`  
👉 **OpenAPI JSON**: `http://localhost:8080/api/v1/v3/api-docs`

No Swagger UI é possível visualizar os esquemas DTO, os enums (`NivelDificuldade`, `CategoriaPergunta`) e testar as requisições HTTP diretamente pela interface web.

---

## 7. Estrutura do Banco de Dados Oracle

A entidade `Pergunta` é mapeada no Oracle Database conforme a estrutura abaixo:

* **Tabela**: `TB_AP_PERGUNTA`
* **Sequence**: `SQ_AP_PERGUNTA`
* **Campos principais**:
  * `ID_PERGUNTA` (NUMBER, Primary Key)
  * `DS_ENUNCIADO` (VARCHAR2(500), Not Null)
  * `DS_RESPOSTA_CORRETA` (VARCHAR2(255), Not Null)
  * `DS_OPCAO_A`, `DS_OPCAO_B`, `DS_OPCAO_C`, `DS_OPCAO_D` (VARCHAR2(255), Not Null)
  * `DS_CATEGORIA` (VARCHAR2(50), Enum)
  * `DS_NIVEL_DIFICULDADE` (VARCHAR2(20), Enum)
  * `DS_EXPLICACAO_EDUCATIVA` (VARCHAR2(1000))

---

## 8. Licença & Créditos

Desenvolvido pelo time **AtomicPulse** para o **Challenge FIAP 2026** em parceria com a **AMazul**.
