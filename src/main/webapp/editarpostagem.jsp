<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.DaoPostagem"%>
<%@ page import="dao.DaoComentario"%>
<%@ page import="entidades.Postagem"%>
<%@ page import="entidades.Comentario"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Postagem</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

    <script>
        if ( sessionStorage.getItem('moderador') != 'true' ) {
            alert('Você não é moderador.')
            window.location.href = 'index.jsp'
        }

        function idInvalido() {
            alert("Postagem não encontrada.")
            window.location.href = 'modpostagens.jsp'
        }

        function validaPostagem() {
            event.preventDefault()

            let formPost = document.getElementById('formpost')
            let autorPost = document.getElementById('autor')
            let tituloPost = document.getElementById('titulo')
            let conteudoPost = document.getElementById('conteudo')

            if ( autorPost.value == '' ) {
                alert('Por favor, insira o nome do autor.')
                autorPost.focus()
                return
            }

            if ( autorPost.value.length > 20 ) {
                alert('O autor não pode ter mais de 20 caracteres.')
                autorPost.focus()
                return
            }

            if ( tituloPost.value == '' ) {
                alert('Por favor, insira o título.')
                tituloPost.focus()
                return
            }

            if ( tituloPost.value.length > 90 ) {
                alert('O título não pode ter mais de 90 caracteres.')
                tituloPost.focus()
                return
            }

            if ( conteudoPost.value == '' ) {
                alert('Por favor, insira o conteúdo da postagem.')
                conteudoPost.focus()
                return
            }

            if ( conteudoPost.value.length > 200 ) {
                alert('O conteudo da postagem não pode ter mais de 200 caracteres.')
                conteudoPost.focus()
                return
            }

            formPost.submit()
        }

        function editouPostagem() {
            alert('Postagem editada com sucesso!')
            window.location.href = 'modpostagens.jsp'
        }
    </script>
</head>
<body>
    <div class="container-fluid bg-info p-3">

        <div class="row">
            <div class="col text-start">
                <a href="modpostagens.jsp"><button class="btn btn-outline-light"><i class="bi bi-arrow-return-left"></i></button></a>
            </div>
        </div>

        <div class="row text-center mb-3"><h1>Editar Postagem</h1></div>


        <%
            String id_post = request.getParameter("id");
            String autor = request.getParameter("autor");
            String titulo = request.getParameter("titulo");
            String conteudo = request.getParameter("conteudo");

            if ( id_post == null || id_post.equals("") ) {
                out.write("<script>idInvalido()</script>");
            }

            Postagem p = DaoPostagem.consultar(Integer.parseInt(id_post));

            if ( p == null ) {
                out.write("<script>idInvalido()</script>");
            }

            if ( autor != null && titulo != null && conteudo != null && !autor.equals("") && !titulo.equals("") && !conteudo.equals("") ) {
                DaoPostagem.editar(Integer.parseInt(id_post), new Postagem(titulo, autor, conteudo));
                out.write("<script>editouPostagem()</script>");
            }
        %>

        <form action="editarpostagem.jsp?id=<%out.write(id_post);%>" method="POST" id="formpost">
            <div class="row mb-3">
                <label for="autor" class="col-1 text-end col-form-label">Autor</label>
                <div class="col"><input type="text" id="autor" name="autor" placeholder="Informe o usuário do autor" class="form-control" maxlength="20" value="<%out.write(p.getAutor());%>"></div>
            </div>

            <div class="row mb-3">
                <label for="titulo" class="col-1 text-end col-form-label">Título</label>
                <div class="col"><input type="text" id="titulo" name="titulo" placeholder="Informe o título da postagem" class="form-control" maxlength="90" value="<%out.write(p.getTitulo());%>"></div>
            </div>

            <div class="row mb-3">
                <label for="conteudo" class="col-1 text-end col-form-label">Conteudo</label>
                <div class="col"><input type="text" id="conteudo" name="conteudo" placeholder="Informe o texto da postagem" class="form-control" maxlength="200" value="<%out.write(p.getConteudo());%>"></div>
            </div>

            <div class="row text-center"><div class="col"><button class="btn btn-primary" onclick="validaPostagem()">Criar</button></div></div>
        </form>
    </div>
</body>
</html>