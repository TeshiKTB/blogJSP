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
    <title>Cadastro</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

    <script>
        if ( sessionStorage.getItem('loggedin') == null ) {
            sessionStorage.setItem('loggedin', 'false')
        }

        if ( sessionStorage.getItem('moderador') == null ) {
            sessionStorage.setItem('moderador', 'false')
        }

        function validaCadastro() {

            event.preventDefault()

            let usuario = document.getElementById('usuario')
            let confirmarUsuario = document.getElementById('confirmarusuario')
            let senha = document.getElementById('senha')
            let confirmarSenha = document.getElementById('confirmarsenha')
            let formulario = document.getElementById('formcadastro')

            if ( usuario.value == '' ) {
                alert('Por favor, insira o usuário.')
                usuario.value = ''
                confirmarUsuario.value = ''
                senha.value = ''
                confirmarSenha.value = ''
                return
            }

            if ( senha.value == '' ) {
                alert('Por favor, escolha uma senha.')
                usuario.value = ''
                confirmarUsuario.value = ''
                senha.value = ''
                confirmarSenha.value = ''
                return
            }

            if ( usuario.value != confirmarUsuario.value ) {
                alert('Os campos de usuário precisam ser iguais.')
                usuario.value = ''
                confirmarUsuario.value = ''
                senha.value = ''
                confirmarSenha.value = ''
                return
            }

            if ( senha.value != confirmarSenha.value ) {
                alert('As senhas precisam ser iguais.')
                usuario.value = ''
                confirmarUsuario.value = ''
                senha.value = ''
                confirmarSenha.value = ''
                return
            }

            formulario.submit()
        }

        function usuarioExistente() {
            let campoErro = document.getElementById('erros')

            campoErro.innerHTML = '<div class="col text-danger"><p><i class="bi bi-exclamation-circle"></i> Não foi possível realizar o cadastro. Usuário já cadastrado.</div>'
        }

        function cadastrarUsuario() {
            alert('Usuário cadastrado com sucesso!')
            window.location.href = 'index.jsp'
        }
    </script>
</head>
<body>
    <div class="container-fluid bg-info p-3">
        <div class="row">
            <div class="col text-start">
                <a href="index.jsp"><button class="btn btn-outline-light"><i class="bi bi-arrow-return-left"></i></button></a>
            </div>
        </div>

        <div class="row">
            <div class="col text-center"><h1>Cadastro</h1></div>
        </div>

        <form action="cadastro.jsp" method="POST" id="formcadastro">
            <div class="row mb-3">
                <label for="usuario" class="col-5 col-form-label text-end">Usuário</label>
                <div class="col-4">
                    <input type="text" class="form-control" placeholder="Escolha um nome de usuário" id="usuario" name="usuario" maxlength="20">
                </div>
            </div>

            <div class="row mb-3">
                <label for="confirmarusuario" class="col-5 col-form-label text-end">Confirmar usuário</label>
                <div class="col-4">
                    <input type="text" class="form-control" placeholder="Confirme o usuário" id="confirmarusuario" maxlength="20">
                </div>
            </div>

            <div class="row mb-3">
                <label for="senha" class="col-5 col-form-label text-end">Senha</label>
                <div class="col-4">
                    <input type="password" class="form-control" placeholder="Informe a senha" id="senha" name="senha" maxlength="25">
                </div>
            </div>

            <div class="row mb-3">
                <label for="confirmarsenha" class="col-5 col-form-label text-end">Confirmar senha</label>
                <div class="col-4">
                    <input type="password" class="form-control" placeholder="Confirme a senha" id="confirmarsenha" maxlength="25">
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-5"></div>
                <div class="col-4 text-center"><button class="btn btn-primary" onclick="validaCadastro()">Cadastrar</button></div>
            </div>
        </form>

        <div class="row mb-3" id="erros"></div>

        <%
            String log = request.getParameter("usuario");
            String senha = request.getParameter("senha");

            if ( log != null && senha != null ) {
                if ( DaoUsuario.verificarUsuario(log) ) {
                    out.write("<script>usuarioExistente()</script>");
                } else {
                    DaoUsuario.salvar(new Usuario(log, senha));
                    out.write("<script>cadastrarUsuario()</script>");
                }
            }
        %>
    </div>
</body>
</html>