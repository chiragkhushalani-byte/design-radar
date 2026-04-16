-- Design Radar — Real tasks seed
-- Run this in Supabase SQL Editor

-- Step 1: Clear old sample data
delete from time_logs;
delete from tasks;
delete from designers;

-- Step 2: Insert real designers
insert into designers (name, initials, avatar_index) values
  ('Manaar Jafri',        'MJ', 0),
  ('Ojus Thool',          'OT', 1),
  ('Varun Kewalramani',   'VK', 2),
  ('tanushree hanmattekar','TH', 3),
  ('Chirag Khushalani',   'CK', 4);

-- Step 3: Insert real tasks from sprint 10
insert into tasks (name, pm, designer_name, priority, status, effort, jira_ref, risk, risk_note, logged_mins, notes) values
  (
    'FAQ for SIP url in order widget',
    '—',
    'Manaar Jafri',
    'medium',
    'inprogress',
    2,
    'sprint-10',
    false, '', 0, ''
  ),
  (
    'Positions – Remove sorting widget, add P&L toggle, and sort positions alphabetically',
    '—',
    'Manaar Jafri',
    'medium',
    'review',
    3,
    'sprint-10',
    false, '', 0, 'Dev-ready'
  ),
  (
    'Position on option chain showing open positions & P&L on option chain UI',
    '—',
    'Ojus Thool',
    'medium',
    'inprogress',
    3,
    'sprint-10',
    false, '', 0, ''
  ),
  (
    'Dark Mode Colours finalisation',
    '—',
    'Varun Kewalramani',
    'medium',
    'review',
    2,
    'sprint-10',
    false, '', 0, 'Dev-ready'
  ),
  (
    'Learning Centre redirect for all bazaar basics videos and blog post (Just discovery)',
    '—',
    'tanushree hanmattekar',
    'medium',
    'review',
    2,
    'sprint-10',
    false, '', 0, 'Dev-ready'
  ),
  (
    'P&L Report – Tax',
    '—',
    'Varun Kewalramani',
    'medium',
    'todo',
    3,
    'sprint-10',
    false, '', 0, 'Also involves Chirag Khushalani'
  ),
  (
    'Positions Day''s P&L view',
    '—',
    'Manaar Jafri',
    'medium',
    'review',
    2,
    'sprint-10',
    false, '', 0, 'Dev-ready'
  ),
  (
    'Holdings trades in holdings details',
    '—',
    'Manaar Jafri',
    'medium',
    'todo',
    2,
    'sprint-10',
    false, '', 0, ''
  ),
  (
    'Open website UI refresh',
    '—',
    'Varun Kewalramani',
    'medium',
    'inprogress',
    4,
    '—',
    false, '', 0, ''
  ),
  (
    'Bonds',
    '—',
    'tanushree hanmattekar',
    'medium',
    'inprogress',
    3,
    'sprint-10',
    false, '', 0, ''
  );
