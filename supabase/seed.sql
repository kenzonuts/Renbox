-- RENBOK Seed Data

INSERT INTO locations (
  name, slug, category, province, city, address,
  latitude, longitude, altitude, difficulty, description,
  cover_image_url, duration, rating_average, reviews_count
) VALUES
(
  'Gunung Rinjani',
  'gunung-rinjani',
  'mountain',
  'Nusa Tenggara Barat',
  'Lombok',
  'Taman Nasional Gunung Rinjani, Lombok',
  -8.4117, 116.4575, 3726, 'extreme',
  'Gunung berapi aktif tertinggi kedua di Indonesia. Pendakian ke Danau Segara Anak dan puncak Rinjani menjadi pengalaman epik bagi pendaki.',
  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
  '2-3 Hari',
  4.8, 124
),
(
  'Gunung Prau',
  'gunung-prau',
  'mountain',
  'Jawa Tengah',
  'Wonosobo',
  'Dieng, Wonosobo',
  -7.1833, 109.9167, 2565, 'medium',
  'Gunung dengan savana luas dan pemandangan sunrise spektakuler. Cocok untuk pendaki pemula hingga menengah.',
  'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
  '1 Hari',
  4.6, 89
),
(
  'Coban Rondo',
  'coban-rondo',
  'waterfall',
  'Jawa Timur',
  'Malang',
  'Poncokusumo, Malang',
  -8.1500, 112.5167, 1145, 'easy',
  'Air terjun indah di kawasan Malang dengan udara sejuk dan fasilitas wisata lengkap.',
  'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800',
  '2-3 Jam',
  4.5, 67
),
(
  'Ranca Upas',
  'ranca-upas',
  'camping',
  'Jawa Barat',
  'Bandung',
  'Patengan, Ciwidey, Bandung',
  -7.1667, 107.4167, 1700, 'easy',
  'Kawasan camping dengan pemandangan danau dan hutan pinus. Populer untuk glamping dan family trip.',
  'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=800',
  '1-2 Hari',
  4.7, 95
),
(
  'Pantai Kuta Lombok',
  'pantai-kuta-lombok',
  'beach',
  'Nusa Tenggara Barat',
  'Lombok',
  'Kuta, Pujut, Lombok Tengah',
  -8.8833, 116.2833, 0, 'easy',
  'Pantai pasir putih dengan ombak tenang, cocok untuk surfing, snorkeling, dan sunset.',
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
  'Setengah Hari',
  4.9, 156
),
(
  'Danau Toba',
  'danau-toba',
  'lake',
  'Sumatera Utara',
  'Samosir',
  'Pulau Samosir, Sumatera Utara',
  2.6833, 98.8667, 905, 'easy',
  'Danau vulkanik terbesar di Indonesia. Destinasi wisata budaya Batak dengan pemandangan spektakuler.',
  'https://images.unsplash.com/photo-1544551763-46a013bb70f5?w=800',
  '2-4 Hari',
  4.8, 203
);

INSERT INTO badges (name, description, icon, condition_type, condition_value) VALUES
('Pendaki Pertama', 'Selesaikan check-in pertama di gunung', 'mountain', 'checkins', 1),
('Penjelajah Alam', 'Kunjungi 5 lokasi berbeda', 'compass', 'checkins', 5),
('Storyteller', 'Bagikan 10 petualangan', 'camera', 'posts', 10),
('Nature Lover', 'Simpan 10 lokasi di wishlist', 'heart', 'wishlist', 10),
('Community Star', 'Dapatkan 50 likes di postingan', 'star', 'likes_received', 50);
