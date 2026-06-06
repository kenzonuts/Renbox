import { Router } from 'express';
import * as commentController from '../controllers/comment.controller';
import { authMiddleware } from '../middleware/auth.middleware';

const router = Router();

router.patch('/:id', authMiddleware, commentController.update);
router.delete('/:id', authMiddleware, commentController.remove);

export default router;
