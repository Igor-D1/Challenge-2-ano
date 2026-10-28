namespace AtomicPulse.Noticias.Exceptions;

public class NoticiaInvalidaException : Exception
{
    public NoticiaInvalidaException(string mensagem) : base(mensagem)
    {
    }
}