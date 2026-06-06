import { Response } from 'express';
import { ApiSuccessResponse, ApiErrorResponse } from '../types/api.types';

export function sendSuccess<T>(
  res: Response,
  message: string,
  data: T,
  statusCode = 200
): void {
  const body: ApiSuccessResponse<T> = { success: true, message, data };
  res.status(statusCode).json(body);
}

export function sendError(
  res: Response,
  message: string,
  statusCode = 400,
  errors?: unknown
): void {
  const body: ApiErrorResponse = { success: false, message, errors };
  res.status(statusCode).json(body);
}
