<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.DaoPostagem"%>
<%@ page import="dao.DaoComentario"%>
<%@ page import="dao.DaoUsuario"%>
<%@ page import="entidades.Postagem"%>
<%@ page import="entidades.Comentario"%>
<%@ page import="entidades.Usuario"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

    <script>
        if ( sessionStorage.getItem('loggedin') == null ) {
            sessionStorage.setItem('loggedin', 'false')
        }

        if ( sessionStorage.getItem('moderador') == null ) {
            sessionStorage.setItem('moderador', 'false')
        }

        if ( sessionStorage.getItem('loggedin') != 'false' ) {
            alert('Você já está logado.')
            window.location.href = 'index.jsp'
        }

        function validaLogin() {
            event.preventDefault()
            let campoLogin = document.getElementById('inputlogin')
            let campoSenha = document.getElementById('inputsenha')

            if ( campoLogin.value == '' ) {
                alert('Por favor, insira o login.')
                return
            }

            if ( campoSenha.value == '' ) {
                alert('Por favor, insira a senha.')
                return
            }

            document.getElementById('formlogin').submit()
        }

        function logar( usuario, moderador ) {
            sessionStorage.setItem('loggedin', usuario)
            
            if ( moderador ) {
                sessionStorage.setItem('moderador', 'true')
            } else {
                sessionStorage.setItem('moderador', 'false')
            }

            window.location.href = 'index.jsp'
        }
    </script>
</head>
<body>
    <div class="container bg-info p-3">
        <div class="row">
            <div class="col text-start">
                <a href="index.jsp"><button class="btn btn-outline-light"><i class="bi bi-arrow-return-left"></i></button></a>
            </div>
        </div>

        <div class="row mb-3">
            <div class="col-7 text-center"><h1>Login</h1></div>
        </div>

        <form action="login.jsp" method="POST" id="formlogin">
            <div class="row mb-3">
                <label for="inputlogin" class="col-3 col-form-label text-end">Login</label>
                <div class="col-4">
                    <input type="text" name="inputlogin" id="inputlogin" class="form-control" placeholder="Informe o Usuário">
                </div>
            </div>

            <div class="row mb-3">
                <label for="inputsenha" class="col-3 col-form-label text-end">Senha</label>
                <div class="col-4">
                    <input type="password" name="inputsenha" id="inputsenha" class="form-control" placeholder="Informe a senha">
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-7 text-center">
                    <button class="btn btn-primary" onclick="validaLogin()">Entrar</button>
                </div>
            </div>
        </form>

        <%
            String log = request.getParameter("inputlogin");
            String senha = request.getParameter("inputsenha");

            if ( log != null &&  senha != null ) {
                if ( DaoUsuario.verificarLogin(log, senha) ) {
                    if ( DaoUsuario.verificarModerador(log) ) {
                        out.write("<script>");
                            out.write("logar('" + log + "', true)");
                        out.write("</script>");
                        
                    } else {
                        out.write("<script>");
                            out.write("logar('" + log + "', false)");
                        out.write("</script>");
                    }
                } else {
                    out.write("<div class='row mb-3 text-danger'>");
                        out.write("<p><i class='bi bi-exclamation-circle'></i> Não foi possível realizar o login. Verifique suas credenciais.</p>");
                    out.write("</div>");
                }
            }
        %>
    </div>
</body>
</html>