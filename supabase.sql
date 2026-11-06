-- Cole este script inteiro no Supabase: SQL Editor > New query > Run

create table if not exists public.postits (
  id        text primary key,
  text      text not null check (char_length(text) <= 140),
  color     text not null,
  author    text,
  author_id text,
  at        bigint not null
);

alter table public.postits enable row level security;

-- Acesso aberto para quem tem o link do site (a chave anon).
create policy "ler"    on public.postits for select using (true);
create policy "criar"  on public.postits for insert with check (true);
create policy "editar" on public.postits for update using (true) with check (true);
create policy "apagar" on public.postits for delete using (true);

-- Liga o tempo real para a tabela (os post-its aparecem para todos na hora).
alter publication supabase_realtime add table public.postits;
