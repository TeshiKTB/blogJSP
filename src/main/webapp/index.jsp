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
    <title>Página Inicial</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

    <script>
        if ( sessionStorage.getItem('loggedin') == null ) {
            sessionStorage.setItem('loggedin', 'false')
        }

        if ( sessionStorage.getItem('moderador') == null ) {
            sessionStorage.setItem('moderador', 'false')
        }

        function carregaNav() {
            let navbar = document.getElementById('navbar');
            if ( sessionStorage.getItem('loggedin') == 'false' ) {
                navbar.innerHTML = '<div class="col text-end"><a href="cadastro.jsp"><button class="btn btn-outline-dark">Cadastrar</button></a> <a id="loginbtn" href="login.jsp"><button class="btn btn-outline-dark">Login</button></a></div>'
            } else {
                if ( sessionStorage.getItem('moderador') == 'false' ) {
                    navbar.innerHTML = '<div class="col text-start text-light"><p>Olá, ' + sessionStorage.getItem('loggedin') + '!</p></div> <div class="col text-end"><button class="btn btn-outline-light" onclick="logout()"><i class="bi bi-box-arrow-left"></i> Sair</button></div>'
                } else {
                    navbar.innerHTML = '<div class="col text-start text-light"><p>Olá, ' + sessionStorage.getItem('loggedin') + '!</p></div> <div class="col text-end"><button class="btn btn-outline-light" onclick="logout()"><i class="bi bi-box-arrow-left"></i> Sair</button> <a href="modpostagens.jsp"><button class="btn btn-outline-light"><i class="bi bi-archive"></i> Gerenciar postagens</button></a></div>'
                }
            }
        }

        function logout() {
            sessionStorage.setItem('loggedin', 'false')
            sessionStorage.setItem('moderador', 'false')
            window.location.href = 'index.jsp'
        }
    </script>

</head>
<body onload="carregaNav()">
    <div class="container-fluid p-3 bg-info">
        <div class="row" id="navbar">
            
        </div>

        <div class="row text-center mb-3"><h1>Página Inicial</h1></div>

        <div class="container p-3 bg-light border border-dark rounded">
            <div class="container p-5 bg-warning">
                <%
                    int contador = 0;
                    for ( Postagem p : DaoPostagem.consultar() ) {
                        contador++;

                        if ( contador > 10 ) {
                            break;
                        }

                        out.write("<div class='row mb-3'>");
                            out.write("<div class='col text-center'>");
                                out.write("<h3>" + p.getTitulo() + "</h3>");
                            out.write("</div>");
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
