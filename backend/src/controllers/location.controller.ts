import { Request, Response, NextFunction } from 'express';
import { locationService } from '../services/location.service';
import { createLocationSchema, searchLocationSchema } from '../validators/location.validator';
import { paginationSchema } from '../utils/pagination';
import { sendSuccess } from '../utils/response';
import { param } from '../utils/params';

export async function getAll(req: Request, res: Response, next: NextFunction) {
  try {
    const pagination = paginationSchema.parse(req.query);
    const result = await locationService.getAll(pagination);
    sendSuccess(res, 'Locations retrieved', result);
  } catch (err) {
    next(err);
  }
}

export async function search(req: Request, res: Response, next: NextFunction) {
  try {
    const { q, ...rest } = searchLocationSchema.parse(req.query);
    const pagination = paginationSchema.parse(rest);
    const result = await locationService.search(q ?? '', pagination);
    sendSuccess(res, 'Search results', result);
  } catch (err) {
    next(err);
  }
}

export async function getByCategory(req: Request, res: Response, next: NextFunction) {
  try {
    const pagination = paginationSchema.parse(req.query);
    const result = await locationService.getByCategory(param(req.params.category), pagination);
    sendSuccess(res, 'Locations by category', result);
  } catch (err) {
    next(err);
  }
}

export async function getBySlug(req: Request, res: Response, next: NextFunction) {
  try {
    const location = await locationService.getBySlug(param(req.params.slug));
    sendSuccess(res, 'Location retrieved', location);
  } catch (err) {
    next(err);
  }
}

export async function create(req: Request, res: Response, next: NextFunction) {
  try {
    const input = createLocationSchema.parse(req.body);
    const location = await locationService.create(input);
    sendSuccess(res, 'Location created', location, 201);
  } catch (err) {
    next(err);
  }
}

export async function getFeatured(_req: Request, res: Response, next: NextFunction) {
  try {
    const location = await locationService.getFeatured();
    sendSuccess(res, 'Featured location', location);
  } catch (err) {
    next(err);
  }
}
