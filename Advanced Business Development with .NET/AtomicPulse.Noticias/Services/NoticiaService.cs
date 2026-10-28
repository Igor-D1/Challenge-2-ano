using AtomicPulse.Noticias.Exceptions;
using AtomicPulse.Noticias.Models;
using AtomicPulse.Noticias.Repositories;

namespace AtomicPulse.Noticias.Services;

public class NoticiaService
{
    private readonly INoticiaRepository _repositorio;

    public NoticiaService(INoticiaRepository repositorio)
    {
        _repositorio = repositorio;
    }

    public Noticia Cadastrar(string titulo, string link, string fonte,
                             DateTime? dataPublicacao, string? resumo,
                             Sentimento? sentimento)
    {
        var noticia = new Noticia(titulo, link, fonte, dataPublicacao, resumo, sentimento);

        if (_repositorio.ExisteLink(noticia.Link))
            throw new NoticiaInvalidaException("Já existe uma notícia cadastrada com este link.");

        _repositorio.Adicionar(noticia);
        return noticia;
    }

    public List<Noticia> ListarTodas()
    {
        return _repositorio.ListarTodas();
    }

    public List<Noticia> BuscarPorTitulo(string termo)
    {
        if (string.IsNullOrWhiteSpace(termo))
            throw new NoticiaInvalidaException("Informe um termo para a busca.");

        return _repositorio.ListarTodas()
            .Where(n => n.Titulo.Contains(termo.Trim(), StringComparison.OrdinalIgnoreCase))
            .ToList();
    }

    public List<Noticia> BuscarPorFonte(string fonte)
    {
        if (string.IsNullOrWhiteSpace(fonte))
            throw new NoticiaInvalidaException("Informe a fonte para a busca.");

        return _repositorio.ListarTodas()
            .Where(n => n.Fonte.Contains(fonte.Trim(), StringComparison.OrdinalIgnoreCase))
            .ToList();
    }

    public List<Noticia> BuscarPorSentimento(Sentimento sentimento)
    {
        return _repositorio.ListarTodas()
            .Where(n => n.Sentimento == sentimento)
            .ToList();
    }
}