-- RENBOK Storage Buckets
-- Run in Supabase Dashboard > Storage or via SQL

INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
  ('avatars', 'avatars', true, 5242880, ARRAY['image/jpeg', 'image/png', 'image/webp']),
  ('posts', 'posts', true, 10485760, ARRAY['image/jpeg', 'image/png', 'image/webp']),
  ('locations', 'locations', true, 10485760, ARRAY['image/jpeg', 'image/png', 'image/webp'])
ON CONFLICT (id) DO NOTHING;

-- Public read policies
CREATE POLICY "Avatar images are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'avatars');

CREATE POLICY "Post images are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'posts');

CREATE POLICY "Location images are publicly accessible"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'locations');

CREATE POLICY "Users can upload avatars"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'avatars' AND auth.role() = 'authenticated');

CREATE POLICY "Users can upload posts"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'posts' AND auth.role() = 'authenticated');

CREATE POLICY "Users can upload location images"
  ON storage.objects FOR INSERT
  WITH CHECK (bucket_id = 'locations' AND auth.role() = 'authenticated');
