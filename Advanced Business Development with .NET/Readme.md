# Atomic Pulse: Radar de Notícias (.NET)
 
Advanced Business Development with .NET | Challenge FIAP 2026 (CTMSP/Marinha) | Sprint 1

## Grupo
 
| Nome | RM |
|---|---|
| Alan Christopher Gonzaga Miranda | 567033 |
| Guilherme Santos Sena | 568101 |
| Igor Dantas da Silva | 568337 |
 
## Descrição da solução
 
O Atomic Pulse é uma solução educativa que aproxima a sociedade da tecnologia nuclear e de seus benefícios. Reúne um quiz gamificado e um radar de notícias sobre energia nuclear. Este repositório contém a parte em .NET, responsável pelo radar de notícias.
 
## O que foi desenvolvido nesta primeira Sprint
 
Aplicação de console em .NET com a entidade `Noticia` (equivalente à tabela `AP_NOTICIA` do banco do grupo):
 
- Cadastro de notícias, com validação dos campos (título, link, fonte, data, resumo e sentimento).
- Regra de negócio: não é permitido cadastrar duas notícias com o mesmo link.
- Consulta: listagem de todas as notícias e busca por título, fonte e sentimento.
- Persistência em arquivo JSON, mantida entre execuções.
- Tratamento de erros com try/catch: o programa mostra o erro e continua funcionando.
 
## Arquitetura
 
```
Models/        Noticia e Sentimento
Exceptions/    NoticiaInvalidaException
Repositories/  INoticiaRepository e NoticiaJsonRepository
Services/      NoticiaService (regra de negócio)
UI/            Menu do console
Data/          noticias.json
```
 
O menu usa o serviço, e o serviço usa a interface `INoticiaRepository`. Assim, a troca do JSON pelo Oracle muda apenas o repositório e a linha que o instancia no Program.cs.
 
## Como executar
 
1. Instale o .NET 10 SDK.
2. Clone o repositório: `git clone https://github.com/Igor-D1/Challenge-2-ano.git`
3. Entre na pasta do projeto .NET: `cd "Challenge-2-ano/Advanced Business Development with .NET/AtomicPulse.Noticias"`
4. Abra `AtomicPulse.Noticias.slnx` no Visual Studio e execute com `Ctrl+F5`, ou, no terminal, dentro dessa pasta: `dotnet run`
 
## Como o .NET se aplica à solução do grupo
 
O .NET implementa o núcleo do radar de notícias do Atomic Pulse: o cadastro, a validação e a consulta das notícias sobre energia nuclear. A entidade segue o modelo de banco do grupo (`AP_NOTICIA`), e a persistência é isolada por uma interface, o que permite, nas próximas Sprints, trocar o JSON pelo Oracle com Entity Framework Core e adicionar a coleta automática de notícias sem alterar as regras de negócio.
