# RENBOK

Social network untuk pecinta alam Indonesia — gunung, camping, air terjun, pantai, hutan, dan danau.

**by Primordial Studio** · *Simpan Jejak, Bagikan Cerita*

## Architecture

```
Flutter App (frontend/)
        ↓ REST API
Node.js Express (backend/)
        ↓
Supabase (PostgreSQL + Auth + Storage)
```

## Project Structure

```
Renbox/
├── supabase/          # SQL schema, seed, storage policies
├── backend/           # Express + TypeScript API
├── frontend/          # Flutter app (jalankan dari sini)
└── README.md
```

## Quick Start

### 1. Supabase

1. Buat project di [supabase.com](https://supabase.com)
2. Jalankan di SQL Editor (berurutan):
   - `supabase/schema.sql`
   - `supabase/seed.sql`
   - `supabase/storage.sql`
3. Aktifkan Email auth di Authentication → Providers
4. Salin URL dan API keys

### 2. Backend

```bash
cd backend
cp .env.example .env
# Isi SUPABASE_URL, SUPABASE_ANON_KEY, SUPABASE_SERVICE_ROLE_KEY
npm install
npm run dev
```

API: `http://localhost:3000`  
Health: `GET /health`

### 3. Flutter (RENBOK App)

> **Penting:** Selalu jalankan Flutter dari folder `frontend/`, bukan dari root repo.

```bash
cd frontend
flutter pub get
flutter run -d web-server --web-port=8080
```

Buka `http://localhost:8080` di browser.

## Documentation

- [Backend API](./backend/README.md)
- [Flutter App](./frontend/README.md)

## MVP Features

### Backend API
- Auth (register, login, logout, me)
- Profiles, locations, posts, comments
- Wishlist, check-ins, reviews
- Follow, notifications
- Image upload ke Supabase Storage
- Pagination, Zod validation, consistent JSON responses

### Flutter UI
- Splash, onboarding (3 slides)
- Login, register, interest setup
- Bottom navigation (Home, Explore, Create, Activity, Profile)
- Home screen (greeting, categories, featured destination, feed)
- Explore, location detail, create/upload post, profile

### Database
- 13 tables + enums, triggers (counts, profile auto-create, ratings)
- Seed: 6 lokasi populer Indonesia
- Storage buckets: avatars, posts, locations

## Brand

| Token | Value |
|-------|-------|
| Forest Green | `#2D6A4F` |
| Deep Forest | `#1B4332` |
| Cream | `#F8F5F0` |
| Font | Plus Jakarta Sans |

## License

MIT
