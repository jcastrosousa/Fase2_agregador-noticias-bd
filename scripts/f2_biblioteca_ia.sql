-- 1. TABELA DE FACT-CHECKING (IA)
CREATE TABLE IF NOT EXISTS auditoria_noticias (
    id_auditoria SERIAL PRIMARY KEY,
    id_noticia INT UNIQUE NOT NULL,
    score_confianca INT CHECK (score_confianca BETWEEN 0 AND 100),
    alerta_clickbait BOOLEAN DEFAULT FALSE,
    justificativa_ia TEXT,
    FOREIGN KEY (id_noticia) REFERENCES noticias(id_noticia)
);

-- 2. TABELA DA BIBLIOTECA PESSOAL (PROGRESSO)
CREATE TABLE IF NOT EXISTS biblioteca_pessoal (
    id_biblioteca SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_noticia INT NOT NULL,
    progresso_leitura INT DEFAULT 0 CHECK (progresso_leitura BETWEEN 0 AND 100),
    status VARCHAR(20) CHECK (status IN ('Na Fila', 'Lendo', 'Concluido')),
    ultima_leitura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_noticia) REFERENCES noticias(id_noticia),
    UNIQUE(id_usuario, id_noticia)
);

-- 3. INSERÇÃO DE DADOS DE TESTE
INSERT INTO auditoria_noticias (id_noticia, score_confianca, alerta_clickbait, justificativa_ia) 
VALUES 
(1, 95, FALSE, 'Conteúdo técnico verificado e condizente com o título.'),
(2, 40, TRUE, 'O título exagera a descoberta. O texto original não confirma vida extraterrestre.')
ON CONFLICT (id_noticia) DO NOTHING;

INSERT INTO biblioteca_pessoal (id_usuario, id_noticia, progresso_leitura, status)
VALUES (1, 1, 60, 'Lendo')
ON CONFLICT (id_usuario, id_noticia) DO NOTHING;