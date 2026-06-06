import { Router } from 'express';
import * as profileController from '../controllers/profile.controller';
import * as followController from '../controllers/follow.controller';
import { authMiddleware } from '../middleware/auth.middleware';
import { uploadAvatar } from '../middleware/upload.middleware';

const router = Router();

router.patch('/me', authMiddleware, profileController.updateMe);
router.post('/me/avatar', authMiddleware, uploadAvatar, profileController.uploadAvatar);
router.get('/me/stats', authMiddleware, profileController.getMyStats);
router.get('/:username', profileController.getByUsername);
router.get('/:userId/followers', followController.getFollowers);
router.get('/:userId/following', followController.getFollowing);

export default router;
