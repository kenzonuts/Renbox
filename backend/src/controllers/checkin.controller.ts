import { Request, Response, NextFunction } from 'express';
import { checkinService } from '../services/checkin.service';
import { createCheckinSchema } from '../validators/checkin.validator';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';

export async function create(req: Request, res: Response, next: NextFunction) {
  try {
    const input = createCheckinSchema.parse(req.body);
    const checkin = await checkinService.create(req.user!.id, input);
    sendSuccess(res, 'Check-in created', checkin, 201);
  } catch (err) {
    next(err);
  }
}

export async function getMine(req: Request, res: Response, next: NextFunction) {
  try {
    const checkins = await checkinService.getMine(req.user!.id);
    sendSuccess(res, 'Check-ins retrieved', checkins);
  } catch (err) {
    next(err);
  }
}

export async function getByLocation(req: Request, res: Response, next: NextFunction) {
  try {
    const checkins = await checkinService.getByLocation(param(req.params.locationId));
    sendSuccess(res, 'Location check-ins retrieved', checkins);
  } catch (err) {
    next(err);
  }
}
