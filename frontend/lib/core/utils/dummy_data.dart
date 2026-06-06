import '../../models/location_model.dart';
import '../../models/post_model.dart';
import '../../models/profile_model.dart';

class DummyData {
  DummyData._();

  static ProfileModel get demoProfile => ProfileModel(
        id: 'demo',
        username: 'kenzo_adventure',
        fullName: 'Kenzo',
        avatarUrl: 'https://i.pravatar.cc/150?u=kenzo',
        bio: 'Pecinta gunung & camping 🏔️',
        city: 'Bandung',
        interests: ['Gunung', 'Camping'],
      );

  static LocationModel get featuredLocation => LocationModel(
        id: '1',
        name: 'Gunung Rinjani',
        slug: 'gunung-rinjani',
        category: 'mountain',
        province: 'Nusa Tenggara Barat',
        city: 'Lombok',
        altitude: 3726,
        difficulty: 'extreme',
        duration: '2–3 Hari',
        ratingAverage: 4.8,
        reviewsCount: 1200,
        coverImageUrl:
            'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
        description:
            'Gunung berapi aktif tertinggi kedua di Indonesia.',
      );

  static List<LocationModel> get featuredLocations => [
        featuredLocation,
        LocationModel(
          id: '2',
          name: 'Gunung Prau',
          slug: 'gunung-prau',
          category: 'mountain',
          province: 'Jawa Tengah',
          city: 'Wonosobo',
          altitude: 2565,
          difficulty: 'medium',
          duration: '1 Hari',
          ratingAverage: 4.6,
          reviewsCount: 890,
          coverImageUrl:
              'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
        ),
        LocationModel(
          id: '3',
          name: 'Danau Toba',
          slug: 'danau-toba',
          category: 'lake',
          province: 'Sumatera Utara',
          city: 'Samosir',
          ratingAverage: 4.8,
          reviewsCount: 2100,
          coverImageUrl:
              'https://images.unsplash.com/photo-1544551763-46a013bb70f5?w=800',
        ),
        LocationModel(
          id: '4',
          name: 'Coban Rondo',
          slug: 'coban-rondo',
          category: 'waterfall',
          province: 'Jawa Timur',
          city: 'Malang',
          difficulty: 'easy',
          duration: 'Half Day',
          ratingAverage: 4.7,
          reviewsCount: 650,
          coverImageUrl:
              'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800',
        ),
      ];

  static List<LocationModel> get popularLocations => featuredLocations;

  static List<PostModel> get feedPosts => [
        PostModel(
          id: 'p1',
          userId: 'u1',
          imageUrl:
              'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=600',
          caption:
              'Pagi yang sempurna di Coban Rondo 🌿💧\nAirnya jernih, udaranya segar banget!',
          likesCount: 1200,
          commentsCount: 56,
          sharesCount: 120,
          savesCount: 89,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          profile: ProfileModel(
            id: 'u1',
            username: 'adventure.kay',
            fullName: 'Kay',
            avatarUrl: 'https://i.pravatar.cc/150?u=adventurekay',
          ),
          location: LocationModel(
            id: '4',
            name: 'Coban Rondo',
            slug: 'coban-rondo',
            category: 'waterfall',
            city: 'Malang',
          ),
          isLiked: false,
          isSaved: false,
        ),
        PostModel(
          id: 'p2',
          userId: 'u2',
          imageUrl:
              'https://images.unsplash.com/photo-1504280390367-361c6d9f38f4?w=600',
          caption: 'Camping malam di Ranca Upas. Udara sejuk, bintang jelas ✨',
          likesCount: 156,
          commentsCount: 23,
          sharesCount: 8,
          savesCount: 34,
          createdAt: DateTime.now().subtract(const Duration(hours: 8)),
          profile: ProfileModel(
            id: 'u2',
            username: 'budi_explorer',
            fullName: 'Budi',
            avatarUrl: 'https://i.pravatar.cc/150?u=budi',
          ),
          location: LocationModel(
            id: '4',
            name: 'Ranca Upas',
            slug: 'ranca-upas',
            category: 'camping',
            city: 'Bandung',
          ),
        ),
      ];
}
