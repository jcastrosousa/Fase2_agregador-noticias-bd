-- Fase 1: inserir dados ficticios para testar o projeto.
-- Comece entendendo os dois primeiros INSERTs (usuarios e noticias).
-- Os INSERTs seguintes sao um pouco mais avancados porque procuram IDs reais.
-- ON CONFLICT evita erros de duplicidade em usuarios, noticias e reacoes.

INSERT INTO usuarios (nome, email) VALUES
    ('Ana Souza', 'ana@email.com'),
    ('Carlos Eduardo', 'carlos@email.com')
ON CONFLICT (email) DO NOTHING;

INSERT INTO noticias (titulo, link, fonte) VALUES
    ('Avanços na Inteligência Artificial em 2026', 'https://exemplo.com/ia', 'TechNews'),
    ('Nova descoberta na astronomia', 'https://exemplo.com/astro', 'Ciência Hoje')
ON CONFLICT (link) DO NOTHING;

-- Nesta parte, SELECT procura os IDs de usuario e noticia pelo email e link.
-- CROSS JOIN faz a combinacao das duas tabelas; WHERE filtra o par correto.
-- NOT EXISTS evita cadastrar de novo o mesmo comentario de exemplo.
-- Esses recursos sao mantidos para o script nao depender de IDs fixos.
INSERT INTO comentarios (id_usuario, id_noticia, texto_comentario)
SELECT u.id_usuario, n.id_noticia,
       'Muito interessante essa evolução das IAs!'
FROM usuarios u
CROSS JOIN noticias n
WHERE u.email = 'ana@email.com'
  AND n.link = 'https://exemplo.com/ia'
  AND NOT EXISTS (
      SELECT 1 FROM comentarios c
      WHERE c.id_usuario = u.id_usuario
        AND c.id_noticia = n.id_noticia
        AND c.texto_comentario = 'Muito interessante essa evolução das IAs!'
  );

INSERT INTO comentarios (id_usuario, id_noticia, texto_comentario)
SELECT u.id_usuario, n.id_noticia,
       'Incrível como o universo é vasto.'
FROM usuarios u
CROSS JOIN noticias n
WHERE u.email = 'carlos@email.com'
  AND n.link = 'https://exemplo.com/astro'
  AND NOT EXISTS (
      SELECT 1 FROM comentarios c
      WHERE c.id_usuario = u.id_usuario
        AND c.id_noticia = n.id_noticia
        AND c.texto_comentario = 'Incrível como o universo é vasto.'
  );

-- Uma reação por usuário/notícia; se já existir, não duplicar.
INSERT INTO reacoes (id_usuario, id_noticia, tipo_reacao)
SELECT u.id_usuario, n.id_noticia, 'relevante'
FROM usuarios u
CROSS JOIN noticias n
WHERE u.email = 'ana@email.com' AND n.link = 'https://exemplo.com/ia'
ON CONFLICT (id_usuario, id_noticia) DO NOTHING;

INSERT INTO reacoes (id_usuario, id_noticia, tipo_reacao)
SELECT u.id_usuario, n.id_noticia, 'sem interesse'
FROM usuarios u
CROSS JOIN noticias n
WHERE u.email = 'carlos@email.com' AND n.link = 'https://exemplo.com/ia'
ON CONFLICT (id_usuario, id_noticia) DO NOTHING;

INSERT INTO reacoes (id_usuario, id_noticia, tipo_reacao)
SELECT u.id_usuario, n.id_noticia, 'relevante'
FROM usuarios u
CROSS JOIN noticias n
WHERE u.email = 'ana@email.com' AND n.link = 'https://exemplo.com/astro'
ON CONFLICT (id_usuario, id_noticia) DO NOTHING;
