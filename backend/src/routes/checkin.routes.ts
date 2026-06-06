import { Router } from 'express';
import * as checkinController from '../controllers/checkin.controller';
import { authMiddleware } from '../middleware/auth.middleware';

const router = Router();

router.use(authMiddleware);
router.post('/', checkinController.create);
router.get('/me', checkinController.getMine);

export default router;
