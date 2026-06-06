import { supabaseAdmin } from '../config/supabase';
import { CreateLocationInput } from '../validators/location.validator';
import { AppError } from '../middleware/error.middleware';
import { createSlug } from '../utils/slug';
import { getPaginationRange, buildPaginationMeta, PaginationQuery } from '../utils/pagination';

export class LocationService {
  async getAll(pagination: PaginationQuery) {
    const { from, to } = getPaginationRange(pagination.page, pagination.limit);

    const { data, error, count } = await supabaseAdmin
      .from('locations')
      .select('*', { count: 'exact' })
      .order('created_at', { ascending: false })
      .range(from, to);

    if (error) {
      throw new AppError(error.message, 500);
    }

    return {
      items: data ?? [],
      meta: buildPaginationMeta(pagination.page, pagination.limit, count ?? 0),
    };
  }

  async search(query: string, pagination: PaginationQuery) {
    const { from, to } = getPaginationRange(pagination.page, pagination.limit);

    const { data, error, count } = await supabaseAdmin
      .from('locations')
      .select('*', { count: 'exact' })
      .or(`name.ilike.%${query}%,city.ilike.%${query}%,province.ilike.%${query}%`)
      .order('rating_average', { ascending: false })
      .range(from, to);

    if (error) {
      throw new AppError(error.message, 500);
    }

    return {
      items: data ?? [],
      meta: buildPaginationMeta(pagination.page, pagination.limit, count ?? 0),
    };
  }

  async getByCategory(category: string, pagination: PaginationQuery) {
    const { from, to } = getPaginationRange(pagination.page, pagination.limit);

    const { data, error, count } = await supabaseAdmin
      .from('locations')
      .select('*', { count: 'exact' })
      .eq('category', category)
      .order('rating_average', { ascending: false })
      .range(from, to);

    if (error) {
      throw new AppError(error.message, 500);
    }

    return {
      items: data ?? [],
      meta: buildPaginationMeta(pagination.page, pagination.limit, count ?? 0),
    };
  }

  async getBySlug(slug: string) {
    const { data, error } = await supabaseAdmin
      .from('locations')
      .select('*')
      .eq('slug', slug)
      .single();

    if (error || !data) {
      throw new AppError('Location not found', 404);
    }

    return data;
  }

  async getById(id: string) {
    const { data, error } = await supabaseAdmin
      .from('locations')
      .select('*')
      .eq('id', id)
      .single();

    if (error || !data) {
      throw new AppError('Location not found', 404);
    }

    return data;
  }

  async create(input: CreateLocationInput, coverUrl?: string) {
    const slug = createSlug(input.name);

    const { data: existing } = await supabaseAdmin
      .from('locations')
      .select('id')
      .eq('slug', slug)
      .maybeSingle();

    const finalSlug = existing ? `${slug}-${Date.now()}` : slug;

    const { data, error } = await supabaseAdmin
      .from('locations')
      .insert({
        ...input,
        slug: finalSlug,
        cover_image_url: coverUrl,
      })
      .select()
      .single();

    if (error) {
      throw new AppError(error.message, 400);
    }

    return data;
  }

  async getFeatured() {
    const { data, error } = await supabaseAdmin
      .from('locations')
      .select('*')
      .order('rating_average', { ascending: false })
      .limit(1)
      .maybeSingle();

    if (error) {
      throw new AppError(error.message, 500);
    }

    return data;
  }
}

export const locationService = new LocationService();
