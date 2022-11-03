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
    <title>Post</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">

    <script>
        
        if ( sessionStorage.getItem('loggedin') == null ) {
            sessionStorage.setItem('loggedin', 'false')
        }

        if ( sessionStorage.getItem('moderador') == null ) {
            sessionStorage.setItem('moderador', 'false')
        }


        function carregaInputComentario() {
            let campoInputComentario = document.getElementById('campoinputcomentario')

            if ( sessionStorage.getItem('loggedin') == 'false' ) {
                campoInputComentario.innerHTML = '<div class="col text-start text-warning"><p><i class="bi bi-info-circle"></i> Para fazer um comentário, <a href="login.jsp" class="text-light">clique aqui</a> para fazer o login.</p</div>'
            } else {
                campoInputComentario.innerHTML = '<div class="col text-start"><input type="text" class="form-control" placeholder="Faça seu comentário." id="campocomentario" name="campocomentario" maxlength="100"></div><div class="col-2 text-center"><button class="btn btn-outline-light" onclick="validaComentario()">Salvar</button></div>'
            }

            document.getElementById('formcomentario').innerHTML += '<input type="text" value="' + sessionStorage.getItem('loggedin') + '" class="d-none" name="autor">'
            document.getElementById('formcomentario').innerHTML += '<input type="hidden" name="hiddenmoderador" value="' + sessionStorage.getItem('moderador') + '">'

            if ( sessionStorage.getItem('moderador') == 'true' ) {
                document.getElementById('btnmoderador').innerHTML = '<button onclick="hiddenModerador()" class="btn btn-outline-light">Moderar comentários</button>'
            }
        }

        function validaComentario() {
            event.preventDefault()

            if ( document.getElementById('campocomentario').value == '' ) {
                alert('Por favor, insira um comentário.')
                return
            }

            document.getElementById('formcomentario').submit()
        }

        function requereComentario() {
            alert('Seu comentário foi enviado para análise.')
            window.location.href = 'index.jsp'
        }

        function hiddenModerador() {
            
            document.getElementById('formcomentario').submit()
        }

        function aceitarComentario(idComentario) {
            document.getElementById('aceitacomentario').value = idComentario
            document.getElementById('formcomentario').submit()
        }

        function rejeitarComentario(idComentario) {
            document.getElementById('rejeitacomentario').value = idComentario
            document.getElementById('formcomentario').submit()
        }
    </script>
</head>

<%
    int id_post = Integer.parseInt(request.getParameter("id"));
    Postagem p = DaoPostagem.consultar(id_post);
    String aceita = request.getParameter("aceitacomentario");
    String rejeita = request.getParameter("rejeitacomentario");
    String mod = request.getParameter("hiddenmoderador");

    if ( aceita != null && !aceita.equals("") ) {
        DaoComentario.aprovaComentario(Integer.parseInt(aceita));
    }

    if ( rejeita != null && !rejeita.equals("") ) {
        DaoComentario.deletaComentario(Integer.parseInt(rejeita));
    }
    
%>

<body onload="carregaInputComentario()">
    <div class="container-fluid bg-primary p-3">
        <div class="row">
            <div class="col text-start">
                <a href="index.jsp"><button class="btn btn-outline-light"><i class="bi bi-arrow-return-left"></i></button></a>
            </div>
            <div class="col text-end" id="btnmoderador"></div>
        </div>

        <div class="row">
            <div class="col text-center"><h2><%out.write("" + p.getTitulo());%></h2></div>
        </div>

        <div class="row mb-3">
            <div class="col-2 text-end text-light"><%out.write("" + p.getAutor());%></div>
            <div class="col text-start"><%out.write("" + p.getConteudo());%></div>
        </div>

        <div class="row"><h4>Comentários</h4></div>

        <%
            int contadorComentarios = 0;
            for ( Comentario c : DaoComentario.consultarAprovadosPorPost(id_post) ) {
                contadorComentarios++;
                out.write("<div class='row mb-2'>");
                    out.write("<div class='col-2'></div>");
                    out.write("<div class='col-2 text-end text-warning'>" + c.getAutor() + "</div>");
                    out.write("<div class='col text-start'>" + c.getConteudo() + "</div>");

                    if ( mod != null && mod.equals("true") ) {
                        out.write("<div class='col-1 text-end'><button class='btn btn-danger' onclick='rejeitarComentario(" + c.getId() + ")'><i class='bi bi-trash3'></i></button></div>");
                    }
                out.write("</div>");
            }

            if ( contadorComentarios == 0 ) {
                out.write("<div class='row mb-2'>Nenhum comentário adicionado.</div>");
            }
        %>


        <form action='postagem.jsp' method="POST" id="formcomentario">
            <input type="text" id="id" name="id" class="d-none" value='<%out.write("" + id_post);%>'>
            <input type="hidden" id="rejeitacomentario" name="rejeitacomentario" value="">
            <input type="hidden" id="aceitacomentario"  name="aceitacomentario"  value="">
            <div class="row mb-3" id="campoinputcomentario"></div>
        </form>

        

        <%
            String coment = request.getParameter("campocomentario");
            String autor = request.getParameter("autor");
            
            

            
            if ( mod != null && mod.equals("true") ) {
                out.write("<div class='row mb-3'>");
                    out.write("<h4>Comentários em análise</h4>");
                out.write("</div>");

                int contaAnalise = 0;
                for ( Comentario c : DaoComentario.consultarReprovadosPorPost(id_post) ) {
                    contaAnalise++;
                    out.write("<div class='row mb-3'>");
                        out.write("<div class='col-2 text-end'><button class='btn btn-success' onclick='aceitarComentario(" + c.getId() + ")'><i class='bi bi-check-lg'></i> Aceitar</button> <button class='btn btn-danger' onclick='rejeitarComentario(" + c.getId() + ")'><i class='bi bi-x-lg'></i> Rejeitar</button></div>");
                        out.write("<div class='col-2 text-end text-warning'>" + c.getAutor() + "</div>");
                        out.write("<div class='col text-start'>" + c.getConteudo() + "</div>");
                    out.write("</div>");
                    out.write("<hr>");
                }

                if ( contaAnalise == 0 ) {
                    out.write("<div class='row mb-3'><p>Nenhum comentário enviado para análise.</p></div>");
                }
            }


            if ( coment != null && !coment.equals("") ) {
                DaoComentario.salvar(new Comentario(p.getId(), autor, coment));
                out.write("<script>requereComentario()</script>");
            }

        %>
    </div>
</body>
</html>