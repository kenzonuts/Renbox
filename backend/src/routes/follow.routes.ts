import { Router } from 'express';
import * as followController from '../controllers/follow.controller';
import { authMiddleware } from '../middleware/auth.middleware';

const router = Router();

router.use(authMiddleware);
router.post('/:userId', followController.follow);
router.delete('/:userId', followController.unfollow);

export default router;
