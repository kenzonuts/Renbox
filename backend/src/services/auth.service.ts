import { supabaseAdmin } from '../config/supabase';
import { RegisterInput, LoginInput } from '../validators/auth.validator';
import { AppError } from '../middleware/error.middleware';

export class AuthService {
  async register(input: RegisterInput) {
    const { data: existing } = await supabaseAdmin
      .from('profiles')
      .select('id')
      .eq('username', input.username)
      .maybeSingle();

    if (existing) {
      throw new AppError('Username already taken', 409);
    }

    const { data, error } = await supabaseAdmin.auth.signUp({
      email: input.email,
      password: input.password,
      options: {
        data: {
          username: input.username,
          full_name: input.full_name,
        },
      },
    });

    if (error) {
      throw new AppError(error.message, 400);
    }

    if (data.user) {
      await supabaseAdmin
        .from('profiles')
        .update({
          username: input.username,
          full_name: input.full_name,
        })
        .eq('id', data.user.id);
    }

    return {
      user: data.user,
      session: data.session,
    };
  }

  async login(input: LoginInput) {
    const { data, error } = await supabaseAdmin.auth.signInWithPassword({
      email: input.email,
      password: input.password,
    });

    if (error) {
      throw new AppError('Invalid email or password', 401);
    }

    return {
      user: data.user,
      session: data.session,
    };
  }

  async logout(accessToken: string) {
    const { error } = await supabaseAdmin.auth.admin.signOut(accessToken);
    if (error) {
      throw new AppError(error.message, 400);
    }
  }

  async getMe(userId: string) {
    const { data: profile, error: profileError } = await supabaseAdmin
      .from('profiles')
      .select('*')
      .eq('id', userId)
      .single();

    if (profileError) {
      throw new AppError('Profile not found', 404);
    }

    const { data: user, error } = await supabaseAdmin.auth.admin.getUserById(userId);
    if (error || !user.user) {
      throw new AppError('User not found', 404);
    }

    return {
      ...profile,
      email: user.user.email,
    };
  }
}

export const authService = new AuthService();
