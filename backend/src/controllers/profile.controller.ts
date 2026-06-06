import { Request, Response, NextFunction } from 'express';
import { profileService } from '../services/profile.service';
import { updateProfileSchema } from '../validators/profile.validator';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';
import { AppError } from '../middleware/error.middleware';

export async function getByUsername(req: Request, res: Response, next: NextFunction) {
  try {
    const profile = await profileService.getByUsername(param(req.params.username));
    sendSuccess(res, 'Profile retrieved', profile);
  } catch (err) {
    next(err);
  }
}

export async function updateMe(req: Request, res: Response, next: NextFunction) {
  try {
    const input = updateProfileSchema.parse(req.body);
    const profile = await profileService.update(req.user!.id, input);
    sendSuccess(res, 'Profile updated', profile);
  } catch (err) {
    next(err);
  }
}

export async function uploadAvatar(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.file) {
      throw new AppError('Avatar file is required', 400);
    }
    const profile = await profileService.uploadAvatar(req.user!.id, req.file);
    sendSuccess(res, 'Avatar uploaded', profile);
  } catch (err) {
    next(err);
  }
}

export async function getMyStats(req: Request, res: Response, next: NextFunction) {
  try {
    const stats = await profileService.getStats(req.user!.id);
    sendSuccess(res, 'Stats retrieved', stats);
  } catch (err) {
    next(err);
  }
}
