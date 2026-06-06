import { Router } from 'express';
import * as reviewController from '../controllers/review.controller';
import { authMiddleware } from '../middleware/auth.middleware';

const router = Router();

router.patch('/:id', authMiddleware, reviewController.update);
router.delete('/:id', authMiddleware, reviewController.remove);

export default router;
