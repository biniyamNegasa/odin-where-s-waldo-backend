# Odin Where's Waldo Backend

Rails API-only backend for the Where's Waldo game. Stores character coordinates per image, tracks game timers server-side (so leaderboard times can't be forged), and serves per-image leaderboards.

The frontend can be found here: https://github.com/biniyamNegasa/odin-where-s-waldo-frontend

## Setup

Requires Ruby 3.4 (see `.ruby-version`) and SQLite.

```bash
bundle install
bin/rails db:prepare db:seed   # creates the SQLite DB and seeds the 5 maps
bin/rails server               # http://localhost:3000
```

Run the tests with:

```bash
bin/rails test
```

## API

| Method | Path | Purpose |
|---|---|---|
| `POST` | `/api/timers` | Start a game. Body: `{"timer": {"name": "...", "image_name": "..."}}` |
| `POST` | `/api/timers/:id/check` | Guess a character location. Body: `{"who": "waldo", "coord": "61.2,38.4"}` (percent coordinates). Records the find server-side. |
| `PATCH` | `/api/timers/:id` | Finish the game. Only allowed once **all** characters have been found on that timer. Returns `{"time_taken": 8.16}`. |
| `GET` | `/api/leaderboard/:image_name` | Top 50 fastest completed games for an image. |
| `GET` | `/up` | Health check. |

Usernames must be 3–20 characters, start with a letter, and contain only letters and numbers. The API is rate limited (rack-attack).

## Configuration

- **`FRONTEND_ORIGINS`** — comma-separated list of origins allowed by CORS in production, e.g. `https://my-app.netlify.app`. Defaults to the local Vite dev/preview servers (`http://localhost:5173`, `http://localhost:4173`).
- **SQLite storage** — the database lives in `storage/`. In production (see `Dockerfile`) mount a persistent volume at `/rails/storage`, otherwise all data is lost on redeploy.

## Maintenance

Abandoned games (started but never finished) can be cleaned up with:

```bash
bin/rails timers:cleanup   # deletes unfinished timers older than 24h
```
