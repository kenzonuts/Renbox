import { supabaseAdmin } from '../config/supabase';

export async function uploadToStorage(
  bucket: 'avatars' | 'posts' | 'locations',
  filePath: string,
  buffer: Buffer,
  contentType: string
): Promise<string> {
  const { error } = await supabaseAdmin.storage.from(bucket).upload(filePath, buffer, {
    contentType,
    upsert: true,
  });

  if (error) {
    throw new Error(`Upload failed: ${error.message}`);
  }

  const { data } = supabaseAdmin.storage.from(bucket).getPublicUrl(filePath);
  return data.publicUrl;
}
