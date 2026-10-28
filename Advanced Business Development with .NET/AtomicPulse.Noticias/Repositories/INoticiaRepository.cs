using AtomicPulse.Noticias.Models;

namespace AtomicPulse.Noticias.Repositories;

public interface INoticiaRepository
{
    void Adicionar(Noticia noticia);
    List<Noticia> ListarTodas();
    bool ExisteLink(string link);
}