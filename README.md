# N7 Feedback

A static site (no server) where players rate the event (1–5 stars), pick their favourite
game, leave a comment and up to 3 photos. It saves straight into your Supabase project.

| File | What it is |
|---|---|
| `index.html` | the feedback form |
| `qr.html` | a full-screen / printable poster with the QR code to the form |
| `feedback.sql` | run once in Supabase (table + photo storage + permissions) |

## 1. Supabase (once)
Supabase → **SQL Editor** → New query → paste `feedback.sql` → **Run**.

## 2. Put it online (free)
**Render**: push this folder to its own GitHub repo → Render → **New → Static Site** →
pick the repo → Build command: *(empty)* → Publish directory: `.` → Create.
Static sites on Render are free and never sleep.

(Faster, without GitHub: <https://app.netlify.com/drop> → drag this folder.)

## 3. Use it
- Form: `https://YOUR-SITE/`
- QR poster: `https://YOUR-SITE/qr.html` (show it on the big screen, or print it with Ctrl+P)
- Read the answers: Supabase → **Table Editor → feedback**. Photo links open directly.
  Export: Table Editor → **Export → CSV**.

Players can only *add* feedback; nobody can read it through the site.
