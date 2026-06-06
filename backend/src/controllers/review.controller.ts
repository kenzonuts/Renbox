import { Request, Response, NextFunction } from 'express';
import { reviewService } from '../services/review.service';
import { createReviewSchema, updateReviewSchema } from '../validators/review.validator';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';

export async function create(req: Request, res: Response, next: NextFunction) {
  try {
    const input = createReviewSchema.parse(req.body);
    const review = await reviewService.create(param(req.params.locationId), req.user!.id, input);
    sendSuccess(res, 'Review created', review, 201);
  } catch (err) {
    next(err);
  }
}

export async function getByLocation(req: Request, res: Response, next: NextFunction) {
  try {
    const reviews = await reviewService.getByLocation(param(req.params.locationId));
    sendSuccess(res, 'Reviews retrieved', reviews);
  } catch (err) {
    next(err);
  }
}

export async function update(req: Request, res: Response, next: NextFunction) {
  try {
    const input = updateReviewSchema.parse(req.body);
    const review = await reviewService.update(param(req.params.id), req.user!.id, input);
    sendSuccess(res, 'Review updated', review);
  } catch (err) {
    next(err);
  }
}

export async function remove(req: Request, res: Response, next: NextFunction) {
  try {
    await reviewService.delete(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Review deleted', null);
  } catch (err) {
    next(err);
  }
}
