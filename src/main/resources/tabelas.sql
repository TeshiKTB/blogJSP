
CREATE TABLE postagem (
	id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(90),
    autor VARCHAR(20),
    conteudo VARCHAR(200)
);

CREATE TABLE comentario (
	id_postagem INT,
    id INT DEFAULT 0,
    autor VARCHAR(20),
    conteudo VARCHAR(100),
    aprovado BOOLEAN,
    CONSTRAINT fk_coment FOREIGN KEY(id_postagem) REFERENCES postagem(id),
    PRIMARY KEY(id_postagem, id)
);

DELIMITER $$
CREATE TRIGGER id_comentario BEFORE INSERT ON comentario
FOR EACH ROW
BEGIN
	SET NEW.id = (SELECT IFNULL(MAX(id), 0) + 1 FROM comentario);
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER exlcui_comentarios BEFORE DELETE ON postagem
FOR EACH ROW
BEGIN
	DELETE FROM comentario WHERE id_postagem = OLD.id;
END $$
DELIMITER ;

INSERT INTO postagem(titulo, autor, conteudo) VALUES
	("The most common items in my kid received on Halloween", "midly", "Aww, cripes. I didn't know I'd have to write a description. How many words is that so far, like a hundred? Soooo, yeah. "),
    ("What movie is a 10/10?", "rocklou", "Look the title"),
    ("What is 25 years too old for?", "TehTJ", "title means everything"),
    ("Ay, caramba!", "instant_regret", "Hello guys!"),
    ("Ryzen 5 5600g ou Xeon e5 2660 v3?", "rtensh", "Sou totalmente novo em montar computador, e finalmente quero aposentar meu escudeiro(um notebook Dell com i3 4005u, Intel graphics e 4gb ram) que tenho desde 2015."),
    ("Quero criar um RPG por mensagens, e tenho algumas ideias.", "OnlyShadow", "Quem quiser participar me manda mensagem na DM que mandarei meu nick do Discord."),
    ("Manter o endereço 'secreto' torna mais difícil para uma pessoa ser alvo de processos?", "Royal_pin", "Porque acho que a pessoa precisa ser intimada e se isso não acontecer, o processo pode se arrastar por vários anos - é assim que funciona ?"),
    ("Preciso de ajuda", "Klutzy", "Oii, tudo bem com vcs? espero que sim, vim pedir o apoio de vcs pra comprar meus desenhos infelizmente minha caneta quebrou"),
    ("Belo Horizonte esta com problemas na VIVO fibra?", "raciocinador", "Mais alguém tendo problemas? ja li que ta tendo uma grande manutenção na região prejudicando todo mundo"),
    ("Recebi uma proposta para a Holanda, podem-me dizer o que pensam?", "Apmaggalhaes", "Boas! Eu acabei agora o curso em Engenharia Mecânica, não tenho qualquer experiência na área.");
    

INSERT INTO comentario(id_postagem, autor, conteudo, aprovado) VALUES
	(2, "Saikyo", "Definitely  Todo Mundo Em Panico", TRUE),
    (2, "Kyosai", "I think Transformers is PERFECT!!", TRUE),
    (4, "A_guy", "Oh hello boy!", TRUE),
    (3, "goodinu", "lol", FALSE),
    (10, "teshugao", "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk", TRUE);

CREATE TABLE usuario(
	login VARCHAR(20) UNIQUE NOT NULL,
    senha VARCHAR(25) NOT NULL,
    moderador BOOLEAN
);

INSERT INTO usuario(login, senha, moderador) VALUES
	("root", "root", TRUE),
    ("admin", "admin", TRUE),
    ("teshi", "teshi", FALSE);
    