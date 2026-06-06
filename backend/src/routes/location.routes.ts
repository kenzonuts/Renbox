import { Router } from 'express';
import * as locationController from '../controllers/location.controller';
import * as checkinController from '../controllers/checkin.controller';
import * as reviewController from '../controllers/review.controller';
import { authMiddleware } from '../middleware/auth.middleware';

const router = Router();

router.get('/featured', locationController.getFeatured);
router.get('/search', locationController.search);
router.get('/category/:category', locationController.getByCategory);
router.get('/', locationController.getAll);
router.post('/', authMiddleware, locationController.create);
router.get('/:locationId/checkins', checkinController.getByLocation);
router.get('/:locationId/reviews', reviewController.getByLocation);
router.post('/:locationId/reviews', authMiddleware, reviewController.create);
router.get('/:slug', locationController.getBySlug);

export default router;
