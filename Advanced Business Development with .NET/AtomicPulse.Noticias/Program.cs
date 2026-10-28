using AtomicPulse.Noticias.Exceptions;
using AtomicPulse.Noticias.Models;

try
{
    var boa = new Noticia(
        "Brasil avança no submarino nuclear",
        "https://exemplo.com/a",
        "Agência Brasil",
        new DateTime(2026, 10, 1),
        null,
        Sentimento.Positivo);
    Console.WriteLine($"OK: {boa.Titulo}");

    var ruim = new Noticia("", "link-invalido", "G1");
    Console.WriteLine("Não deveria chegar aqui");
}
catch (NoticiaInvalidaException ex)
{
    Console.WriteLine($"Erro: {ex.Message}");
}