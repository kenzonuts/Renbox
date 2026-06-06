import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import morgan from 'morgan';
import { env } from './config/env';
import { errorHandler, notFoundHandler } from './middleware/error.middleware';

import authRoutes from './routes/auth.routes';
import profileRoutes from './routes/profile.routes';
import locationRoutes from './routes/location.routes';
import postRoutes from './routes/post.routes';
import commentRoutes from './routes/comment.routes';
import wishlistRoutes from './routes/wishlist.routes';
import checkinRoutes from './routes/checkin.routes';
import reviewRoutes from './routes/review.routes';
import followRoutes from './routes/follow.routes';
import notificationRoutes from './routes/notification.routes';

const app = express();

app.use(helmet());
app.use(
  cors({
    origin: env.CORS_ORIGIN === '*' ? true : env.CORS_ORIGIN.split(','),
    credentials: true,
  })
);
app.use(morgan(env.NODE_ENV === 'development' ? 'dev' : 'combined'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/health', (_req, res) => {
  res.json({ success: true, message: 'RENBOK API is running', data: { version: '1.0.0' } });
});

app.use('/api/auth', authRoutes);
app.use('/api/profiles', profileRoutes);
app.use('/api/locations', locationRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/comments', commentRoutes);
app.use('/api/wishlist', wishlistRoutes);
app.use('/api/checkins', checkinRoutes);
app.use('/api/reviews', reviewRoutes);
app.use('/api/follow', followRoutes);
app.use('/api/notifications', notificationRoutes);

app.use(notFoundHandler);
app.use(errorHandler);

export default app;
