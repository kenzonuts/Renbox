# RENBOK API

Backend Express + TypeScript untuk aplikasi RENBOK — social network pecinta alam Indonesia.

## Stack

- Node.js + Express
- TypeScript (strict)
- Supabase (Auth, PostgreSQL, Storage)
- Zod validation
- Multer (upload)

## Setup

### 1. Supabase

1. Buat project di [supabase.com](https://supabase.com)
2. Jalankan SQL di SQL Editor (urutan):
   - `../supabase/schema.sql`
   - `../supabase/seed.sql`
   - `../supabase/storage.sql`
3. Salin **Project URL**, **anon key**, dan **service role key**

### 2. Environment

```bash
cd backend
cp .env.example .env
# Edit .env dengan kredensial Supabase
```

### 3. Install & Run

```bash
npm install
npm run dev
```

API berjalan di `http://localhost:3000`

## API Endpoints

### Auth
| Method | Endpoint | Auth |
|--------|----------|------|
| POST | `/api/auth/register` | - |
| POST | `/api/auth/login` | - |
| POST | `/api/auth/logout` | Bearer |
| GET | `/api/auth/me` | Bearer |

### Profiles
| Method | Endpoint | Auth |
|--------|----------|------|
| GET | `/api/profiles/:username` | - |
| PATCH | `/api/profiles/me` | Bearer |
| POST | `/api/profiles/me/avatar` | Bearer |
| GET | `/api/profiles/me/stats` | Bearer |

### Locations
| Method | Endpoint | Auth |
|--------|----------|------|
| GET | `/api/locations` | - |
| GET | `/api/locations/featured` | - |
| GET | `/api/locations/search?q=` | - |
| GET | `/api/locations/category/:category` | - |
| GET | `/api/locations/:slug` | - |
| POST | `/api/locations` | Bearer |

### Posts
| Method | Endpoint | Auth |
|--------|----------|------|
| GET | `/api/posts/feed` | Optional |
| POST | `/api/posts` | Bearer (multipart) |
| GET | `/api/posts/:id` | Optional |
| PATCH/DELETE | `/api/posts/:id` | Bearer |
| POST/DELETE | `/api/posts/:id/like` | Bearer |
| POST/DELETE | `/api/posts/:id/save` | Bearer |

### Comments, Wishlist, Check-ins, Reviews, Follow, Notifications

Lihat struktur routes di `src/routes/`.

## Response Format

```json
{
  "success": true,
  "message": "...",
  "data": {}
}
```

## Scripts

- `npm run dev` — development dengan hot reload
- `npm run build` — compile TypeScript
- `npm start` — production
- `npm run typecheck` — type check only
