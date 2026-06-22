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
        id: '2',
        name: 'Gunung Prau',
        slug: 'gunung-prau',
        category: 'mountain',
        province: 'Jawa Tengah',
        city: 'Dieng',
        altitude: 2565,
        difficulty: 'medium',
        duration: '1 Hari',
        ratingAverage: 4.9,
        reviewsCount: 890,
        coverImageUrl:
            'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
        description: 'Savana ikonik dengan pemandangan lautan awan.',
      );

  static List<LocationModel> get featuredLocations => [
        featuredLocation,
        LocationModel(
          id: '11',
          name: 'Gunung Andong',
          slug: 'gunung-andong',
          category: 'mountain',
          province: 'Jawa Tengah',
          city: 'Magelang',
          altitude: 1726,
          difficulty: 'easy',
          duration: '2–3 Jam',
          ratingAverage: 4.8,
          reviewsCount: 640,
          coverImageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800',
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

  static List<LocationModel> get weeklyPopular => featuredLocations;

  static List<LocationModel> get otherDestinations => [
        LocationModel(
          id: '2',
          name: 'Gunung Prau',
          slug: 'gunung-prau',
          category: 'mountain',
          province: 'Jawa Tengah',
          city: 'Wonosobo',
          altitude: 2565,
          difficulty: 'easy',
          duration: '1 Hari',
          ratingAverage: 4.8,
          coverImageUrl:
              'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600',
        ),
        LocationModel(
          id: '5',
          name: 'Pantai Parangtritis',
          slug: 'pantai-parangtritis',
          category: 'beach',
          province: 'DI Yogyakarta',
          city: 'Bantul',
          difficulty: 'medium',
          ratingAverage: 4.6,
          coverImageUrl:
              'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
        ),
        LocationModel(
          id: '4',
          name: 'Coban Rondo',
          slug: 'coban-rondo',
          category: 'waterfall',
          province: 'Jawa Timur',
          city: 'Malang',
          difficulty: 'easy',
          ratingAverage: 4.7,
          coverImageUrl:
              'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=600',
        ),
        LocationModel(
          id: '6',
          name: 'Danau Warna',
          slug: 'danau-warna',
          category: 'lake',
          province: 'Jawa Timur',
          city: 'Bondowoso',
          difficulty: 'easy',
          ratingAverage: 4.5,
          coverImageUrl:
              'https://images.unsplash.com/photo-1439066615861-d1af74d74000?w=600',
        ),
        LocationModel(
          id: '7',
          name: 'Ranu Kumbolo',
          slug: 'ranu-kumbolo',
          category: 'lake',
          province: 'Jawa Timur',
          city: 'Lumajang',
          difficulty: 'medium',
          ratingAverage: 4.9,
          coverImageUrl:
              'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600',
        ),
        LocationModel(
          id: '8',
          name: 'Curug Cimahi',
          slug: 'curug-cimahi',
          category: 'waterfall',
          province: 'Jawa Barat',
          city: 'Bandung',
          difficulty: 'easy',
          ratingAverage: 4.4,
          coverImageUrl:
              'https://images.unsplash.com/photo-1519904981063-b0cf448d479e?w=600',
        ),
        LocationModel(
          id: '9',
          name: 'Pantai Kuta',
          slug: 'pantai-kuta',
          category: 'beach',
          province: 'Bali',
          city: 'Badung',
          difficulty: 'easy',
          ratingAverage: 4.6,
          coverImageUrl:
              'https://images.unsplash.com/photo-1559827260-dc66d52bef19?w=600',
        ),
        LocationModel(
          id: '10',
          name: 'Hutan Pinus',
          slug: 'hutan-pinus',
          category: 'forest',
          province: 'Jawa Barat',
          city: 'Lembang',
          difficulty: 'easy',
          ratingAverage: 4.3,
          coverImageUrl:
              'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=600',
        ),
      ];

  static List<PostModel> get feedPosts => [
        PostModel(
          id: 'p1',
          userId: 'u1',
          imageUrl:
              'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=600',
          caption:
              'Sunrise di babon 2 Merbabu tidak pernah gagal! ✨',
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
