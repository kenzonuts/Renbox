import { Request, Response, NextFunction } from 'express';
import { followService } from '../services/follow.service';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';

export async function follow(req: Request, res: Response, next: NextFunction) {
  try {
    const result = await followService.follow(req.user!.id, param(req.params.userId));
    sendSuccess(res, 'User followed', result, 201);
  } catch (err) {
    next(err);
  }
}

export async function unfollow(req: Request, res: Response, next: NextFunction) {
  try {
    await followService.unfollow(req.user!.id, param(req.params.userId));
    sendSuccess(res, 'User unfollowed', null);
  } catch (err) {
    next(err);
  }
}

export async function getFollowers(req: Request, res: Response, next: NextFunction) {
  try {
    const followers = await followService.getFollowers(param(req.params.userId));
    sendSuccess(res, 'Followers retrieved', followers);
  } catch (err) {
    next(err);
  }
}

export async function getFollowing(req: Request, res: Response, next: NextFunction) {
  try {
    const following = await followService.getFollowing(param(req.params.userId));
    sendSuccess(res, 'Following retrieved', following);
  } catch (err) {
    next(err);
  }
}
