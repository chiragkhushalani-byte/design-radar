-- Design Radar — Run this in Supabase SQL Editor (copy all, paste, run)

create table if not exists designers (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  initials text not null,
  avatar_index int default 0,
  created_at timestamptz default now()
);

create table if not exists tasks (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  pm text default '—',
  designer_name text default '—',
  priority text default 'medium',
  status text default 'todo',
  effort int default 2,
  jira_ref text default '—',
  risk boolean default false,
  risk_note text default '',
  logged_mins int default 0,
  notes text default '',
  sort_order int default 0,
  created_at timestamptz default now()
);

create table if not exists time_logs (
  id uuid default gen_random_uuid() primary key,
  task_id uuid references tasks(id) on delete cascade,
  task_name text,
  designer_name text,
  mins int not null,
  note text default '',
  logged_date text,
  created_at timestamptz default now()
);

create table if not exists requests (
  id uuid default gen_random_uuid() primary key,
  pm_name text not null,
  product text not null,
  title text not null,
  description text,
  urgency text default 'medium',
  deadline text,
  jira_ref text,
  assigned boolean default false,
  read boolean default false,
  created_at timestamptz default now()
);

-- Seed designers
insert into designers (name, initials, avatar_index) values
  ('Anika', 'AN', 0),
  ('Rohan', 'RO', 1),
  ('Priya', 'PR', 2),
  ('Dev',   'DV', 3),
  ('Meera', 'ME', 4);

-- RLS
alter table designers enable row level security;
alter table tasks enable row level security;
alter table time_logs enable row level security;
alter table requests enable row level security;

create policy "allow all designers" on designers for all using (true) with check (true);
create policy "allow all tasks"     on tasks     for all using (true) with check (true);
create policy "allow all time_logs" on time_logs for all using (true) with check (true);
create policy "allow all requests"  on requests  for all using (true) with check (true);
