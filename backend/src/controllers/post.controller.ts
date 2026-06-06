import { Request, Response, NextFunction } from 'express';
import { postService } from '../services/post.service';
import { createPostSchema, updatePostSchema } from '../validators/post.validator';
import { paginationSchema } from '../utils/pagination';
import { sendSuccess } from '../utils/response';
import { AppError } from '../middleware/error.middleware';
import { param } from '../utils/params';

export async function create(req: Request, res: Response, next: NextFunction) {
  try {
    if (!req.file) {
      throw new AppError('Image is required', 400);
    }
    const input = createPostSchema.parse(req.body);
    const post = await postService.create(req.user!.id, input, req.file);
    sendSuccess(res, 'Post created', post, 201);
  } catch (err) {
    next(err);
  }
}

export async function getFeed(req: Request, res: Response, next: NextFunction) {
  try {
    const pagination = paginationSchema.parse(req.query);
    const userId = req.user?.id;
    const result = await postService.getFeed(userId, pagination);
    sendSuccess(res, 'Feed retrieved', result);
  } catch (err) {
    next(err);
  }
}

export async function getById(req: Request, res: Response, next: NextFunction) {
  try {
    const post = await postService.getById(param(req.params.id), req.user?.id);
    sendSuccess(res, 'Post retrieved', post);
  } catch (err) {
    next(err);
  }
}

export async function update(req: Request, res: Response, next: NextFunction) {
  try {
    const input = updatePostSchema.parse(req.body);
    const post = await postService.update(param(req.params.id), req.user!.id, input);
    sendSuccess(res, 'Post updated', post);
  } catch (err) {
    next(err);
  }
}

export async function remove(req: Request, res: Response, next: NextFunction) {
  try {
    await postService.delete(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Post deleted', null);
  } catch (err) {
    next(err);
  }
}

export async function like(req: Request, res: Response, next: NextFunction) {
  try {
    const post = await postService.like(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Post liked', post);
  } catch (err) {
    next(err);
  }
}

export async function unlike(req: Request, res: Response, next: NextFunction) {
  try {
    const post = await postService.unlike(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Post unliked', post);
  } catch (err) {
    next(err);
  }
}

export async function save(req: Request, res: Response, next: NextFunction) {
  try {
    const post = await postService.save(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Post saved', post);
  } catch (err) {
    next(err);
  }
}

export async function unsave(req: Request, res: Response, next: NextFunction) {
  try {
    const post = await postService.unsave(param(req.params.id), req.user!.id);
    sendSuccess(res, 'Post unsaved', post);
  } catch (err) {
    next(err);
  }
}
