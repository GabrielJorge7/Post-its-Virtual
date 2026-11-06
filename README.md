# Parede de Post-its Virtual

Escritório virtual 2D onde cada pessoa cria seu personagem, escolhe a cor do post-it na mesa, anda até a parede e cola a mensagem. Todos veem os personagens e os post-its em tempo real.

**Arquivos do projeto**
- `index.html`: o site inteiro (um único arquivo)
- `config.js`: onde você coloca os dados do Supabase
- `supabase.sql`: script que cria a tabela no banco

**Como funciona:** o site fica no Render (site estático, não precisa de servidor) e os post-its ficam salvos no Supabase. Os personagens andando usam o tempo real do próprio Supabase e não gravam nada no banco.

---

## Passo 1: criar o banco no Supabase

1. Acesse https://supabase.com e crie uma conta (pode entrar com o GitHub).
2. Clique em **New project**. Escolha um nome (ex.: `parede-postit`), crie uma senha para o banco (guarde-a) e escolha a região mais próxima (ex.: South America, São Paulo). Aguarde alguns minutos até o projeto ficar pronto.
3. No menu da esquerda, abra **SQL Editor**, clique em **New query**, cole todo o conteúdo do arquivo `supabase.sql` e clique em **Run**. Deve aparecer "Success".
4. Confira em **Table Editor** se a tabela `postits` apareceu.
5. Pegue as chaves: vá em **Project Settings** (engrenagem) e depois **API** (ou **API Keys**). Copie:
   - **Project URL** (algo como `https://abcdxyz.supabase.co`)
   - **anon public key** (um texto longo começando com `eyJ...`). Se aparecer como "publishable key", use essa.

## Passo 2: configurar o projeto

Abra o arquivo `config.js` e preencha:

```js
window.APP_CONFIG = {
  SUPABASE_URL: "https://abcdxyz.supabase.co",
  SUPABASE_KEY: "eyJ...sua chave anon...",
  ADMIN_PASS: "uma-senha-sua"   // opcional
};
```

Nunca coloque a chave `service_role` aqui. Use somente a `anon`/`publishable`.

**Teste local (opcional):** dê dois cliques no `index.html`. Se o topo da página mostrar "multiusuário ativo", a conexão está funcionando. Abra em duas abas para ver os personagens um no outro.

## Passo 3: colocar o código no GitHub

O Render publica a partir de um repositório Git.

1. Crie uma conta em https://github.com e clique em **New repository** (ex.: `parede-postit`, pode ser privado).
2. Na página do repositório, clique em **uploading an existing file** e envie os três arquivos: `index.html`, `config.js` e `supabase.sql` (o README é opcional). Clique em **Commit changes**.

## Passo 4: publicar no Render

1. Acesse https://render.com e entre com o GitHub.
2. Clique em **New +** e depois **Static Site**.
3. Selecione o repositório `parede-postit` (autorize o acesso se for pedido).
4. Preencha:
   - **Name:** parede-postit
   - **Branch:** main
   - **Build Command:** deixe vazio
   - **Publish Directory:** `.` (um ponto)
5. Clique em **Create Static Site**. Em um ou dois minutos você recebe um endereço como `https://parede-postit.onrender.com`. Esse é o link para compartilhar com a equipe.

Para atualizar o site depois, basta editar os arquivos no GitHub. O Render publica de novo sozinho.

---

## Cuidados

- **Quem tem o link pode escrever e apagar.** As regras do banco (em `supabase.sql`) estão abertas de propósito para facilitar. O site só mostra "Apagar" e "Salvar autor" para quem criou o post-it (neste navegador), mas isso não é uma barreira de segurança real. Para uso interno em equipe costuma bastar; se for divulgar o link publicamente, peça uma versão com login.
- **ADMIN_PASS:** abrindo o site como `https://seu-site.onrender.com/?admin=uma-senha-sua` você consegue apagar e editar o autor de qualquer post-it, para moderar. É uma comodidade, não proteção forte (a senha fica visível no `config.js`).
- **Plano gratuito do Supabase:** projetos sem uso por cerca de uma semana são pausados. Se acontecer, entre no painel e clique em **Restore project**. Os dados são mantidos.
- **Limpar tudo:** no Supabase, em **Table Editor**, abra `postits` e apague as linhas (ou rode `delete from public.postits;` no SQL Editor).
- **Se aparecer "modo local":** o `config.js` está vazio ou com a URL/chave erradas. Nesse modo os post-its não são salvos nem compartilhados.
- **Se os post-its não aparecem para os outros em tempo real:** confirme que a última linha do `supabase.sql` (`alter publication supabase_realtime add table ...`) foi executada. Em **Database > Replication**, a tabela `postits` deve estar ativada.
