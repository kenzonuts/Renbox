import { Request, Response, NextFunction } from 'express';
import { authService } from '../services/auth.service';
import { registerSchema, loginSchema } from '../validators/auth.validator';
import { sendSuccess } from '../utils/response';

export async function register(req: Request, res: Response, next: NextFunction) {
  try {
    const input = registerSchema.parse(req.body);
    const result = await authService.register(input);
    sendSuccess(res, 'Registration successful', {
      user: result.user,
      access_token: result.session?.access_token,
      refresh_token: result.session?.refresh_token,
    }, 201);
  } catch (err) {
    next(err);
  }
}

export async function login(req: Request, res: Response, next: NextFunction) {
  try {
    const input = loginSchema.parse(req.body);
    const result = await authService.login(input);
    sendSuccess(res, 'Login successful', {
      user: result.user,
      access_token: result.session?.access_token,
      refresh_token: result.session?.refresh_token,
    });
  } catch (err) {
    next(err);
  }
}

export async function logout(req: Request, res: Response, next: NextFunction) {
  try {
    if (req.accessToken) {
      await authService.logout(req.accessToken);
    }
    sendSuccess(res, 'Logout successful', null);
  } catch (err) {
    next(err);
  }
}

export async function getMe(req: Request, res: Response, next: NextFunction) {
  try {
    const profile = await authService.getMe(req.user!.id);
    sendSuccess(res, 'User retrieved', profile);
  } catch (err) {
    next(err);
  }
}
