import { Request, Response, NextFunction } from 'express';
import { commentService } from '../services/comment.service';
import { createCommentSchema, updateCommentSchema } from '../validators/comment.validator';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';

export async function create(req: Request, res: Response, next: NextFunction) {
  try {
    const input = createCommentSchema.parse(req.body);
    const comment = await commentService.create(param(req.params.postId), req.user!.id, input);
    sendSuccess(res, 'Comment created', comment, 201);
  } catch (err) {
    next(err);
  }
}

export async function getByPost(req: Request, res: Response, next: NextFunction) {
  try {
    const comments = await commentService.getByPost(param(req.params.postId));
    sendSuccess(res, 'Comments retrieved', comments);
  } catch (err) {
    next(err);
  }
}

export async function update(req: Request, res: Response, next: NextFunction) {
  try {
    const input = updateCommentSchema.parse(req.body);
    const comment = await commentService.update(param(req.params.id), req.user!.id, input);
    sendSuccess(res, 'Comment updated', comment);
  } catch (err) {
    next(err);
  }
}

export async function remove(req: Request, res: Response, next: NextFunction) {
  try {
    await commentService.delete(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Comment deleted', null);
  } catch (err) {
    next(err);
  }
}
