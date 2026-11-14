-- N7 Feedback: run once in Supabase → SQL Editor (safe to run again).
-- Players can only ADD feedback. Nobody can read it through the API:
-- you read it in Supabase → Table Editor → feedback (and Storage → feedback for photos).

create table if not exists public.feedback (
  id            uuid primary key default gen_random_uuid(),
  created_at    timestamptz not null default now(),
  name          text check (char_length(name) <= 60),
  team          text check (char_length(team) <= 60),
  rating        smallint not null check (rating between 1 and 5),
  favorite_game text check (favorite_game in ('RoboPath', 'The Locked Phone', 'N7 Quiz', 'Huruf')),
  comment       text check (char_length(comment) <= 1500),
  images        text[] not null default '{}' check (cardinality(images) <= 3)
);

alter table public.feedback enable row level security;
revoke all on public.feedback from anon, authenticated;
grant insert on public.feedback to anon, authenticated;

drop policy if exists "feedback: anyone can add" on public.feedback;
create policy "feedback: anyone can add" on public.feedback
  for insert to anon, authenticated with check (true);

-- Photos: public bucket (links in the table open directly), 3 MB max, images only.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('feedback', 'feedback', true, 3145728, array['image/jpeg', 'image/png', 'image/webp'])
on conflict (id) do update set public = excluded.public,
  file_size_limit = excluded.file_size_limit, allowed_mime_types = excluded.allowed_mime_types;

drop policy if exists "feedback photos: anyone can upload" on storage.objects;
create policy "feedback photos: anyone can upload" on storage.objects
  for insert to anon, authenticated with check (bucket_id = 'feedback');
