package entidades;

public class Usuario {
    private String login;

    private String senha;

    private boolean moderador;

    public Usuario(String login, String senha) {
        this.login = login;
        this.senha = senha;
        this.moderador = false;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public boolean isModerador() {
        return moderador;
    }

    public void setModerador(boolean moderador) {
        this.moderador = moderador;
    }
}
