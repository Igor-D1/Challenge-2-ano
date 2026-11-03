# ☁️ DevOps Tools & Cloud Computing — AtomicPulse

##  Integrantes do Grupo
* **Alan Christopher Miranda** — RM: 567033
* **Guilherme Santos Sena** — RM: 568101
* **Igor Dantas da Silva** — RM: 568337
* **Turma:** 2TDSPA
* **Empresa Parceira:** AMazul / CTMSP (Challenge 2026)

---

##  Descrição Resumida da Solução
O **AtomicPulse** é uma solução digital interativa desenvolvida em parceria com a AMazul para aproximar a sociedade da tecnologia nuclear brasileira de forma simples, acessível e envolvente. A plataforma combina gamificação e monitoramento de informações para desmistificar conceitos sobre energia nuclear, medicina e aplicação civil e militar.

Nesta **Sprint 1** de DevOps Tools & Cloud Computing, disponibilizamos uma Prova de Conceito (PoC) conteinerizada e implantada em nuvem para demonstrar a alta disponibilidade, escalabilidade e padronização da infraestrutura da API da solução.

---

##  Arquitetura da Solução
A arquitetura simplificada em nuvem ilustra a publicação do serviço utilizando container Docker hospedado em uma Virtual Machine Ubuntu no Microsoft Azure com porta de acesso 8080 liberada via Network Security Group (NSG):

![Arquitetura da Solução](docs/arquitetura.drawio.png)

### Fluxo da Arquitetura:
1. **Usuário / App Mobile (Flutter):** Envia requisições HTTP REST para a aplicação.
2. **IP Público (Public IP Address):** Ponto de entrada de rede gerado dinamicamente na Azure.
3. **NSG (Network Security Group):** Regra de firewall que libera o tráfego de entrada na porta `8080`.
4. **Azure Virtual Machine (Ubuntu Linux):** Instância de computação criada via Azure CLI no grupo de recursos `rg-atomicpulse-sprint1`.
5. **Docker Engine:** Ambientes isolados de container dentro da VM.
6. **Container (`atomicpulse-api`):** API REST PoC rodando em Python Flask/Gunicorn na porta `8080`.
7. **Banco de Dados (Persistência Target):** Conexão lógica com o banco relacional para futura integração dos dados do aplicativo.

---

##  Pergunta Obrigatória

> **Como Docker e Cloud Computing podem ser utilizados na solução proposta pelo grupo?**
>
> **Resposta:** A adoção da **Cloud Computing (Microsoft Azure)** permite que a plataforma **AtomicPulse** permaneça acessível publicamente com alta disponibilidade, segurança gerenciada e escalabilidade sob demanda, eliminando a dependência de infraestruturas locais físicas. O **Docker** isola e empacota os microsserviços da aplicação em containers leves e padronizados, garantindo que o ambiente de execução na nuvem seja perfeitamente idêntico ao ambiente de desenvolvimento. Essa combinação assegura um ciclo de implantação rápido, seguro e reproduzível para o ecossistema do projeto em eventos de divulgação da AMazul.

---

##  Instruções de Execução

### Pré-requisitos
* Azure CLI instalado e autenticado (`az login`)
* Git
* Acesso SSH

### 1. Provisionar Infraestrutura na Azure
No seu terminal local ou no Azure Cloud Shell, execute o script de provisionamento:
```bash
az login
bash script.sh