import { Router } from 'express';
import * as postController from '../controllers/post.controller';
import * as commentController from '../controllers/comment.controller';
import { authMiddleware } from '../middleware/auth.middleware';
import { uploadSingle } from '../middleware/upload.middleware';

const router = Router();

router.get('/feed', postController.getFeed);
router.post('/', authMiddleware, uploadSingle, postController.create);
router.get('/:id', postController.getById);
router.patch('/:id', authMiddleware, postController.update);
router.delete('/:id', authMiddleware, postController.remove);
router.post('/:id/like', authMiddleware, postController.like);
router.delete('/:id/like', authMiddleware, postController.unlike);
router.post('/:id/save', authMiddleware, postController.save);
router.delete('/:id/save', authMiddleware, postController.unsave);
router.post('/:postId/comments', authMiddleware, commentController.create);
router.get('/:postId/comments', commentController.getByPost);

export default router;
