import { Request, Response, NextFunction } from 'express';
import { notificationService } from '../services/notification.service';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';

export async function getMine(req: Request, res: Response, next: NextFunction) {
  try {
    const notifications = await notificationService.getMine(req.user!.id);
    sendSuccess(res, 'Notifications retrieved', notifications);
  } catch (err) {
    next(err);
  }
}

export async function markRead(req: Request, res: Response, next: NextFunction) {
  try {
    const notification = await notificationService.markRead(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Notification marked as read', notification);
  } catch (err) {
    next(err);
  }
}

export async function markAllRead(req: Request, res: Response, next: NextFunction) {
  try {
    await notificationService.markAllRead(req.user!.id);
    sendSuccess(res, 'All notifications marked as read', null);
  } catch (err) {
    next(err);
  }
}
