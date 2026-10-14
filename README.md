# Projeto: Agregador de Notícias

**Objetivo Geral**
Desenvolver a infraestrutura de um banco de dados relacional voltado para uma plataforma de agregação de notícias. Na Fase 2, o sistema foi expandido para atuar como um gestor de biblioteca de mídia e preparar a estrutura para integrar ferramentas avançadas de Inteligência de Dados, visando combater a desinformação.

**Inovações Implementadas (Fase 2)**
- **Fact-Checking Automatizado (IA):** Estruturação do banco de dados para suportar a integração com a API da Groq para varredura de notícias, gerando *scores* de confiança e alertas de *clickbait* armazenados na tabela `AUDITORIA_NOTICIAS`.

- **Biblioteca Pessoal:** Sistema de retenção de utilizadores que rastreia o progresso de leitura exato de cada artigo na tabela `BIBLIOTECA_PESSOAL`, permitindo retomar a leitura de forma sincronizada.

- **Protótipo de Interface:** Um protótipo visual demonstrando a interface destas inovações na visão do utilizador final está disponível no arquivo `temp_dashboard.html`.

**Estrutura do Banco e Diagrama (Mermaid)**
O diagrama lógico abaixo ilustra o modelo de entidade-relacionamento (MER) atualizado da aplicação:

```mermaid
erDiagram
    USUARIOS ||--o{ COMENTARIOS : "faz"
    USUARIOS ||--o{ REACOES : "registra"
    USUARIOS ||--o{ BIBLIOTECA_PESSOAL : "gerencia"
    NOTICIAS ||--o{ COMENTARIOS : "recebe"
    NOTICIAS ||--o{ REACOES : "recebe"
    NOTICIAS ||--o| AUDITORIA_NOTICIAS : "passa por"
    NOTICIAS ||--o{ BIBLIOTECA_PESSOAL : "esta na"

    USUARIOS {
        int id_usuario PK
        varchar nome
        varchar email
    }
    NOTICIAS {
        int id_noticia PK
        varchar titulo
        text link
    }
    COMENTARIOS {
        int id_comentario PK
        int id_usuario FK
        int id_noticia FK
        text texto_comentario
    }
    REACOES {
        int id_reacao PK
        int id_usuario FK
        int id_noticia FK
        varchar tipo_reacao
    }
    AUDITORIA_NOTICIAS {
        int id_auditoria PK
        int id_noticia FK
        int score_confianca
        boolean alerta_clickbait
        text justificativa_ia
    }
    BIBLIOTECA_PESSOAL {
        int id_biblioteca PK
        int id_usuario FK
        int id_noticia FK
        int progresso_leitura
        varchar status
    }