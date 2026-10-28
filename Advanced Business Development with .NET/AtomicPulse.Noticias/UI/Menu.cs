using System.Globalization;
using AtomicPulse.Noticias.Exceptions;
using AtomicPulse.Noticias.Models;
using AtomicPulse.Noticias.Services;

namespace AtomicPulse.Noticias.UI;

public class Menu
{
    private readonly NoticiaService _servico;

    public Menu(NoticiaService servico)
    {
        _servico = servico;
    }

    public void Executar()
    {
        bool sair = false;

        while (!sair)
        {
            MostrarOpcoes();
            string? opcao = Console.ReadLine();

            try
            {
                switch (opcao?.Trim())
                {
                    case "1":
                        Cadastrar();
                        break;
                    case "2":
                        Listar();
                        break;
                    case "3":
                        BuscarPorTitulo();
                        break;
                    case "4":
                        BuscarPorFonte();
                        break;
                    case "5":
                        BuscarPorSentimento();
                        break;
                    case "0":
                        sair = true;
                        Console.WriteLine("Até logo!");
                        break;
                    default:
                        Console.WriteLine("Opção inválida. Tente novamente.");
                        break;
                }
            }
            catch (NoticiaInvalidaException ex)
            {
                Console.WriteLine($"Dados inválidos: {ex.Message}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Erro inesperado: {ex.Message}");
            }
        }
    }

    private static void MostrarOpcoes()
    {
        Console.WriteLine();
        Console.WriteLine("===== ATOMIC PULSE - RADAR DE NOTÍCIAS =====");
        Console.WriteLine("1 - Cadastrar notícia");
        Console.WriteLine("2 - Listar todas as notícias");
        Console.WriteLine("3 - Buscar por título");
        Console.WriteLine("4 - Buscar por fonte");
        Console.WriteLine("5 - Buscar por sentimento");
        Console.WriteLine("0 - Sair");
        Console.Write("Escolha uma opção: ");
    }

    private void Cadastrar()
    {
        Console.WriteLine();
        Console.WriteLine("--- Cadastrar notícia ---");

        string titulo = LerTexto("Título: ");
        string link = LerTexto("Link: ");
        string fonte = LerTexto("Fonte: ");
        DateTime? data = LerData("Data de publicação (dd/mm/aaaa, Enter para pular): ");
        string resumo = LerTexto("Resumo (Enter para pular): ");
        Sentimento? sentimento = LerSentimento("Sentimento (1-Positivo, 2-Negativo, 3-Neutro, Enter para pular): ");

        Noticia noticia = _servico.Cadastrar(titulo, link, fonte, data, resumo, sentimento);
        Console.WriteLine($"Notícia cadastrada com sucesso! Id: {noticia.Id}");
    }

    private void Listar()
    {
        MostrarLista(_servico.ListarTodas());
    }

    private void BuscarPorTitulo()
    {
        string termo = LerTexto("Digite parte do título: ");
        MostrarLista(_servico.BuscarPorTitulo(termo));
    }

    private void BuscarPorFonte()
    {
        string fonte = LerTexto("Digite a fonte: ");
        MostrarLista(_servico.BuscarPorFonte(fonte));
    }

    private void BuscarPorSentimento()
    {
        Sentimento? sentimento = LerSentimento("Sentimento (1-Positivo, 2-Negativo, 3-Neutro): ");
        if (sentimento is null)
            throw new NoticiaInvalidaException("Informe 1, 2 ou 3 para buscar por sentimento.");

        MostrarLista(_servico.BuscarPorSentimento(sentimento.Value));
    }

    private static void MostrarLista(List<Noticia> noticias)
    {
        if (noticias.Count == 0)
        {
            Console.WriteLine("Nenhuma notícia encontrada.");
            return;
        }

        Console.WriteLine();
        Console.WriteLine($"{noticias.Count} notícia(s) encontrada(s):");
        foreach (Noticia noticia in noticias)
        {
            MostrarNoticia(noticia);
        }
    }

    private static void MostrarNoticia(Noticia noticia)
    {
        string data = noticia.DataPublicacao.HasValue
            ? noticia.DataPublicacao.Value.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture)
            : "não informada";

        string sentimento = noticia.Sentimento.HasValue
            ? noticia.Sentimento.Value.ToString()
            : "não informado";

        Console.WriteLine("--------------------------------");
        Console.WriteLine($"Id: {noticia.Id}");
        Console.WriteLine($"Título: {noticia.Titulo}");
        Console.WriteLine($"Fonte: {noticia.Fonte}");
        Console.WriteLine($"Link: {noticia.Link}");
        Console.WriteLine($"Data: {data}");
        Console.WriteLine($"Sentimento: {sentimento}");
        if (!string.IsNullOrEmpty(noticia.Resumo))
            Console.WriteLine($"Resumo: {noticia.Resumo}");
    }

    private static string LerTexto(string mensagem)
    {
        Console.Write(mensagem);
        return Console.ReadLine() ?? string.Empty;
    }

    private static DateTime? LerData(string mensagem)
    {
        Console.Write(mensagem);
        string? entrada = Console.ReadLine();

        if (string.IsNullOrWhiteSpace(entrada))
            return null;

        bool valida = DateTime.TryParseExact(entrada.Trim(), "dd/MM/yyyy",
            CultureInfo.InvariantCulture, DateTimeStyles.None, out DateTime data);

        if (!valida)
            throw new NoticiaInvalidaException("Data inválida. Use o formato dd/mm/aaaa.");

        return data;
    }

    private static Sentimento? LerSentimento(string mensagem)
    {
        Console.Write(mensagem);
        string? entrada = Console.ReadLine()?.Trim();

        if (string.IsNullOrEmpty(entrada))
            return null;
        if (entrada == "1")
            return Sentimento.Positivo;
        if (entrada == "2")
            return Sentimento.Negativo;
        if (entrada == "3")
            return Sentimento.Neutro;

        throw new NoticiaInvalidaException("Sentimento inválido. Escolha 1, 2, 3 ou Enter.");
    }
}