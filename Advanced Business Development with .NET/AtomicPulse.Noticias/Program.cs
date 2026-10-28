using AtomicPulse.Noticias.Repositories;
using AtomicPulse.Noticias.Services;
using AtomicPulse.Noticias.UI;

Console.OutputEncoding = System.Text.Encoding.UTF8;
Console.InputEncoding = System.Text.Encoding.UTF8;

string caminhoArquivo = Path.Combine(AppContext.BaseDirectory, "Data", "noticias.json");

INoticiaRepository repositorio = new NoticiaJsonRepository(caminhoArquivo);
var servico = new NoticiaService(repositorio);
var menu = new Menu(servico);

menu.Executar();