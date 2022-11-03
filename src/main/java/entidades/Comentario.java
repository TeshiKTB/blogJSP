package entidades;

public class Comentario {
    private int id;

    private int idPostagem;

    private String autor;

    private String conteudo;

    public Comentario(int id, int idPostagem, String autor, String conteudo) {
        this.id = id;
        this.idPostagem = idPostagem;
        this.autor = autor;
        this.conteudo = conteudo;
    }

    public Comentario(int idPostagem, String autor, String conteudo) {
        this.idPostagem = idPostagem;
        this.autor = autor;
        this.conteudo = conteudo;
    }

    public Comentario(String autor, String conteudo) {
        this.autor = autor;
        this.conteudo = conteudo;
    }

    public Comentario() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdPostagem() {
        return idPostagem;
    }

    public void setIdPostagem(int idPostagem) {
        this.idPostagem = idPostagem;
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
}
