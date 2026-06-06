import { Request, Response, NextFunction } from 'express';
import { supabaseAdmin } from '../config/supabase';
import { sendError } from '../utils/response';
import { AppError } from './error.middleware';

export async function authMiddleware(
  req: Request,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader?.startsWith('Bearer ')) {
      sendError(res, 'Unauthorized: missing or invalid token', 401);
      return;
    }

    const token = authHeader.slice(7);
    const { data, error } = await supabaseAdmin.auth.getUser(token);

    if (error || !data.user) {
      sendError(res, 'Unauthorized: invalid or expired token', 401);
      return;
    }

    req.user = data.user;
    req.accessToken = token;
    next();
  } catch {
    sendError(res, 'Authentication failed', 401);
  }
}

export function requireAuth(req: Request, _res: Response, next: NextFunction): void {
  if (!req.user) {
    next(new AppError('Unauthorized', 401));
    return;
  }
  next();
}
