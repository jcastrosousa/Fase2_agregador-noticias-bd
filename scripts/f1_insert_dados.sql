INSERT INTO usuarios (nome, email) VALUES
('Ana Souza', 'ana@email.com'),
('Carlos Eduardo', 'carlos@email.com')
ON CONFLICT (email) DO NOTHING;

INSERT INTO noticias (titulo, link, fonte) VALUES
('Avanços na Inteligência Artificial em 2026', 'http://exemplo.com/ia', 'TechNews'),
('Nova descoberta na astronomia', 'http://exemplo.com/astro', 'Ciência Hoje');

INSERT INTO comentarios (id_usuario, id_noticia, texto_comentario) VALUES
(1, 1, 'Muito interessante essa evolução das IAs!'),
(2, 2, 'Incrível como o universo é vasto.');

INSERT INTO reacoes (id_usuario, id_noticia, tipo_reacao) VALUES
(1, 1, 'relevante'),
(2, 1, 'sem interesse'),
(1, 2, 'relevante');