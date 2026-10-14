CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS noticias (
    id_noticia SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    link TEXT NOT NULL,
    fonte VARCHAR(100) NOT NULL,
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS comentarios (
    id_comentario SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_noticia INT NOT NULL,
    texto_comentario TEXT NOT NULL,
    data_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_noticia) REFERENCES noticias(id_noticia)
);

CREATE TABLE IF NOT EXISTS reacoes (
    id_reacao SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_noticia INT NOT NULL,
    tipo_reacao VARCHAR(20) CHECK (tipo_reacao IN ('relevante', 'sem interesse')),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_noticia) REFERENCES noticias(id_noticia)
);