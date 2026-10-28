using System.Text.Json;
using System.Text.Json.Serialization;
using AtomicPulse.Noticias.Models;

namespace AtomicPulse.Noticias.Repositories;

public class NoticiaJsonRepository : INoticiaRepository
{
    private readonly string _caminhoArquivo;

    private readonly JsonSerializerOptions _opcoes = new()
    {
        WriteIndented = true,
        Converters = { new JsonStringEnumConverter() }
    };

    public NoticiaJsonRepository(string caminhoArquivo)
    {
        _caminhoArquivo = caminhoArquivo;
    }

    public void Adicionar(Noticia noticia)
    {
        List<Noticia> noticias = Carregar();
        noticia.Id = noticias.Count == 0 ? 1 : noticias.Max(n => n.Id) + 1;
        noticias.Add(noticia);
        Salvar(noticias);
    }

    public List<Noticia> ListarTodas()
    {
        return Carregar();
    }

    public bool ExisteLink(string link)
    {
        return Carregar().Any(n =>
            string.Equals(n.Link, link, StringComparison.OrdinalIgnoreCase));
    }

    private List<Noticia> Carregar()
    {
        if (!File.Exists(_caminhoArquivo))
            return new List<Noticia>();

        string json = File.ReadAllText(_caminhoArquivo);
        if (string.IsNullOrWhiteSpace(json))
            return new List<Noticia>();

        return JsonSerializer.Deserialize<List<Noticia>>(json, _opcoes)
               ?? new List<Noticia>();
    }

    private void Salvar(List<Noticia> noticias)
    {
        string? pasta = Path.GetDirectoryName(_caminhoArquivo);
        if (!string.IsNullOrEmpty(pasta))
            Directory.CreateDirectory(pasta);

        string json = JsonSerializer.Serialize(noticias, _opcoes);
        File.WriteAllText(_caminhoArquivo, json);
    }
}