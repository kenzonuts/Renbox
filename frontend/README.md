# RENBOK Flutter App

Aplikasi mobile social network untuk pecinta alam Indonesia.

**Brand:** RENBOK by Primordial Studio  
**Tagline:** Simpan Jejak, Bagikan Cerita

## Stack

- Flutter / Dart
- Riverpod (state)
- GoRouter (navigation)
- Dio (API)
- Flutter Secure Storage (token)
- Cached Network Image
- Image Picker
- Google Fonts (Plus Jakarta Sans)

## Setup

### Prerequisites

- Flutter SDK 3.16+
- Backend API running (see `../backend/README.md`)

### Install

```bash
cd frontend

# Generate platform folders if missing
flutter create . --project-name renbok

flutter pub get
```

### API URL

Edit `lib/core/constants/app_constants.dart`:

- **Android Emulator:** `http://10.0.2.2:3000`
- **iOS Simulator:** `http://localhost:3000`
- **Physical device:** use your machine LAN IP, e.g. `http://192.168.1.10:3000`

### Run

```bash
# Dari folder frontend/ (bukan root repo)
flutter run -d web-server --web-port=8080
```

Web: buka `http://localhost:8080`

## Screens (MVP)

| Screen | Route |
|--------|-------|
| Splash | `/` |
| Onboarding | `/onboarding` |
| Login | `/login` |
| Register | `/register` |
| Interest Setup | `/interests` |
| Main (bottom nav) | `/main` |
| Home | `/main` |
| Explore | `/main/explore` |
| Create | `/main/create` |
| Activity | `/main/activity` |
| Profile | `/main/profile` |
| Location Detail | `/location/:slug` |
| Upload Post | `/upload-post` |

## Architecture

```
lib/
├── core/          # theme, constants, routes, widgets
├── services/      # API, auth storage
├── models/        # JSON models
└── features/      # per-feature screens & providers
```

## Fallback Data

Jika API belum tersedia, Home dan Explore memakai dummy data dari `lib/core/utils/dummy_data.dart`.

## Brand Colors

| Name | Hex |
|------|-----|
| Forest Green | `#2D6A4F` |
| Deep Forest | `#1B4332` |
| Cream | `#F8F5F0` |
| Stone | `#DAD7CD` |
| Earth Brown | `#A98467` |
| Sky Blue | `#89C2D9` |
