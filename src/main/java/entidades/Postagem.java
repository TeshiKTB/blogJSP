package entidades;

public class Postagem {
    private String titulo;

    private String autor;

    private String conteudo;

    private boolean aprovado;

    private int id;

    public Postagem(String titulo, String autor, String conteudo) {
        this.titulo = titulo;
        this.autor = autor;
        this.conteudo = conteudo;
    }

    public Postagem(String titulo, String autor, String conteudo, int id) {
        this.titulo = titulo;
        this.autor = autor;
        this.conteudo = conteudo;
        this.id = id;
    }

    public Postagem() {
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getAutor() {
        return autor;
    }

    public void setAutor(String autor) {
        this.autor = autor;
    }

    public String getConteudo() {
        return conteudo;
    }

    public void setConteudo(String conteudo) {
        this.conteudo = conteudo;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isAprovado() {
        return aprovado;
    }

    public void setAprovado(boolean aprovado) {
        this.aprovado = aprovado;
    }
}
