using AtomicPulse.Noticias.Exceptions;

namespace AtomicPulse.Noticias.Models;

public class Noticia
{
    private string _titulo = string.Empty;
    private string _link = string.Empty;
    private string _fonte = string.Empty;
    private DateTime? _dataPublicacao;
    private string? _resumo;

    public int Id { get; set; }

    public string Titulo
    {
        get => _titulo;
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new NoticiaInvalidaException("O título é obrigatório.");
            if (value.Trim().Length > 200)
                throw new NoticiaInvalidaException("O título deve ter no máximo 200 caracteres.");
            _titulo = value.Trim();
        }
    }

    public string Link
    {
        get => _link;
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new NoticiaInvalidaException("O link é obrigatório.");
            if (value.Trim().Length > 500)
                throw new NoticiaInvalidaException("O link deve ter no máximo 500 caracteres.");

            bool urlValida = Uri.TryCreate(value.Trim(), UriKind.Absolute, out Uri? uri)
                             && (uri.Scheme == Uri.UriSchemeHttp || uri.Scheme == Uri.UriSchemeHttps);
            if (!urlValida)
                throw new NoticiaInvalidaException("O link deve ser uma URL válida (começando com http:// ou https://).");

            _link = value.Trim();
        }
    }

    public string Fonte
    {
        get => _fonte;
        set
        {
            if (string.IsNullOrWhiteSpace(value))
                throw new NoticiaInvalidaException("A fonte é obrigatória.");
            if (value.Trim().Length > 100)
                throw new NoticiaInvalidaException("A fonte deve ter no máximo 100 caracteres.");
            _fonte = value.Trim();
        }
    }

    public DateTime? DataPublicacao
    {
        get => _dataPublicacao;
        set
        {
            if (value.HasValue && value.Value.Date > DateTime.Today)
                throw new NoticiaInvalidaException("A data de publicação não pode ser futura.");
            _dataPublicacao = value;
        }
    }

    public string? Resumo
    {
        get => _resumo;
        set
        {
            if (string.IsNullOrWhiteSpace(value))
            {
                _resumo = null;
                return;
            }
            if (value.Trim().Length > 500)
                throw new NoticiaInvalidaException("O resumo deve ter no máximo 500 caracteres.");
            _resumo = value.Trim();
        }
    }

    public Sentimento? Sentimento { get; set; }

    public Noticia()
    {
    }

    public Noticia(string titulo, string link, string fonte,
                   DateTime? dataPublicacao = null, string? resumo = null,
                   Sentimento? sentimento = null)
    {
        Titulo = titulo;
        Link = link;
        Fonte = fonte;
        DataPublicacao = dataPublicacao;
        Resumo = resumo;
        Sentimento = sentimento;
    }
}