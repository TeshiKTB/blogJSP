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
    <title>Moderação</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

    <script>
        if ( sessionStorage.getItem('moderador') != 'true' ) {
            alert('Você não é moderador.')
            window.location.href = 'index.jsp'
        }

        function excluiPostagem(idPostagem) {
            document.getElementById('excluipostagem').value = idPostagem
            document.getElementById('formexlcuir').submit()
        }
    </script>
</head>
<body>
    <form action="modpostagens.jsp" method="POST" id="formexlcuir">
        <input type="hidden" id="excluipostagem" name="excluipostagem">
    </form>
    <div class="container-fluid bg-info p-3">
        <div class="row">
            <div class="col text-start">
                <a href="index.jsp"><button class="btn btn-outline-light"><i class="bi bi-arrow-return-left"></i></button></a>
            </div>
            <div class="col text-end">
                <a href="cadastropost.jsp"><button class="btn btn-outline-light"><i class="bi bi-plus-circle"></i> Adicionar postagem</button></a>
            </div>
        </div>

        <div class="row text-center mb-3"><h1>Moderação</h1></div>

        <div class="container p-3 bg-light border border-dark rounded">
            <div class="container p-5 bg-warning">
                <%
                    String excluiPost = request.getParameter("excluipostagem");

                    if ( excluiPost != null && !excluiPost.equals("") ) {
                        DaoPostagem.deletar(Integer.parseInt(excluiPost));
                    }
                    for ( Postagem p : DaoPostagem.consultar() ) {
                        

                        out.write("<div class='row mb-3'>");
                            out.write("<div class='col text-center'>");
                                out.write("<h3>" + p.getTitulo() + "</h3>");
                            out.write("</div>");

                            out.write("<div class='col-2 text-end'><button class='btn btn-danger' onclick='excluiPostagem(" + p.getId() + ")'><i class='bi bi-trash'></i> Excluir postagem</button></div>");
                        out.write("</div>");

                        out.write("<div class='row mb-3'>");
                            out.write("<div class='col'></div><div class='col-2 text-end'><a href='editarpostagem.jsp?id=" + p.getId() + "'><button class='btn btn-info'><i class='bi bi-pencil'></i> Editar postagem</button></a></div>");
                        out.write("</div>");

                        out.write("<div class='row mb-5'>");
                            out.write("<div class='col-3 text-end text-primary'>");
                                out.write(p.getAutor());
                            out.write("</div>");
                            out.write("<div class='col text-start'>");
                                String cont = p.getConteudo();
                                if ( cont.length() > 15 ) {
                                    out.write(cont.substring(0, 11) + "... <a href='postagem.jsp?id=" + p.getId() + "'>Ver mais</a>");
                                } else {
                                    out.write(cont + " <a href='postagem.jsp?id=" + p.getId() + "'>Ver mais</a>");
                                }
                            out.write("</div>");
                        out.write("</div>");

                        out.write("<div class='row mb-3 text-start'><h5>Comentários</h5></div>");

                        int contadorComentarios = 0;
                        for ( Comentario c : DaoComentario.consultarAprovadosPorPost(p.getId()) ) {
                            contadorComentarios++;
                            out.write("<div class='row mb-2'>");
                                out.write("<div class='col-2'></div>");
                                out.write("<div class='col-2 text-end text-light'>" + c.getAutor() + "</div>");
                                out.write("<div class='col text-start'>" + c.getConteudo() + "</div>");
                            out.write("</div>");
                        }

                        if ( contadorComentarios == 0 ) {
                            out.write("Nenhum comentário adicionado.");
                        }
                        out.write("<hr />");
                    }
                %>
            </div>
        </div>
    </div>


</body>
</html>