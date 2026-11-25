-- Fase 2: consultas para verificar os registros demonstrativos.
-- Este arquivo SOMENTE CONSULTA o banco; não altera dados.

-- 1. Quais são as avaliações guardadas para cada notícia?
SELECT n.id_noticia, n.titulo, a.score_confianca,
       a.alerta_clickbait, a.justificativa_ia
FROM noticias AS n
JOIN auditoria_noticias AS a ON a.id_noticia = n.id_noticia
ORDER BY n.id_noticia;

-- 2. Quais notícias foram salvas na biblioteca e por quem?
SELECT u.nome AS usuario, n.titulo AS noticia,
       b.progresso_leitura, b.status, b.ultima_leitura
FROM biblioteca_pessoal AS b
JOIN usuarios AS u ON u.id_usuario = b.id_usuario
JOIN noticias AS n ON n.id_noticia = b.id_noticia
ORDER BY u.nome, n.titulo;

-- 3. Quantos registros há em cada tabela nova?
SELECT 'auditoria_noticias' AS tabela, COUNT(*) AS total
FROM auditoria_noticias
UNION ALL
SELECT 'biblioteca_pessoal' AS tabela, COUNT(*) AS total
FROM biblioteca_pessoal;
