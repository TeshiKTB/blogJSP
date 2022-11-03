# Projeto JSP

## Objetivos
Desenvolver um sistema de blog que satisfaz as seguintes características:
- Na página inicial haverá botões de navegação para fazer o cadastro ou login (caso não esteja logado) e haverá um botão para fazer o logout (caso esteja logado). Caso esteja logado, também haverá uma mensagem de saudação no canto superior esquerdo.
- Caso esteja logado como moderador, haverá um botão para mostrar e gerenciar todas as postagens feitas, onde será possível editar, criar ou excluir postagens.
- Na página inicial são listadas as últimas dez postagens registradas, exibindo seu titulo, os primeiros quinze caracteres do texto principal e um link para exibir a postagem completa;
- Quando exibida a postagem completa, serão mostrados o título, o texto principal completo, os comentários e um espaço para fazer um comentário (caso esteja logado). Caso esteja logado como moderador, haverá um botão para mostrar os botões de edição dos comentários e análise dos comentários em espera.


## Observações
- Certique-se de modificar na classe _**Conexao.java**_ as variáveis url, user e pswd de acordo com os seus corretos valores para acessar o banco de dados.
- A pasta src/main/resources contém o script necessário para criar as tabelas e as triggers e inserir alguns dados nas tabelas. Dentre esses dados, já estarão inseridas algumas postagens e alguns comentários, além de que já estarão inseridos os seguintes usuários para login:

| Usuario | Senha | Moderador |
| ------- | ----- | --------- |
| teshi   | teshi | **Não**   |
| root    | root  | **Sim**   |
| admin   | admin | **Sim**   |

- Veja que, caso queira, também será possível fazer o cadastro de mais usuários. Não pode haver usuários com login em comum.
