import { Request, Response, NextFunction } from 'express';
import { wishlistService } from '../services/wishlist.service';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';

export async function add(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await wishlistService.add(req.user!.id, param(req.params.locationId));
    sendSuccess(res, 'Added to wishlist', result, 201);
  } catch (err) {
    next(err);
  }
}

export async function remove(req: Request, res: Response, next: NextFunction) {
  try {
    await wishlistService.remove(req.user!.id, param(req.params.locationId));
    sendSuccess(res, 'Removed from wishlist', null);
  } catch (err) {
    next(err);
  }
}

export async function getMine(req: Request, res: Response, next: NextFunction) {
  try {
    const items = await wishlistService.getMine(req.user!.id);
    sendSuccess(res, 'Wishlist retrieved', items);
  } catch (err) {
    next(err);
  }
}
