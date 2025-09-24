# 📚 Sistema de Biblioteca – Desafio Técnico ACTi

Implementação de um sistema simples de biblioteca em **SQL Server**, com gerenciamento de livros, usuários e empréstimos.

---

## ⚙️ Estrutura do Banco
- **usuario**: cadastro de usuários (PK = cpf).  
- **livro**: cadastro de livros (PK = id).  
- **emprestimo**: registra empréstimos (PK = id, FK → usuario, FK → livro).  

---

## 🛠️ Procedures

### Livro (CRUD)
- `sp_livro_insert(@nome)`  
- `sp_livro_update(@id, @nome)`  
- `sp_livro_select(@id = NULL)`  
- `sp_livro_delete(@id)` (não permite excluir se emprestado)  

### Usuário
- `sp_usuario_insert(@nome, @cpf)`  
- `sp_usuario_select(@cpf = NULL)`  

### Empréstimo
- `sp_empresta(@id, @cpf)` → empresta livro, com validações.  
- `sp_devolve(@id)` → devolve livro (delete em empréstimo).  

---
