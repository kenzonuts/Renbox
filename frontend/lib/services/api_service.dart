import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants/app_constants.dart';
import '../models/location_model.dart';
import '../models/post_model.dart';
import '../models/profile_model.dart';
import 'auth_storage.dart';

final authStorageProvider = Provider<AuthStorage>((ref) => AuthStorage());

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.watch(authStorageProvider));
});

class ApiService {
  ApiService(this._authStorage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.apiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _authStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  final AuthStorage _authStorage;
  late final Dio _dio;

  Future<Map<String, dynamic>> _unwrap(Response<dynamic> res) async {
    final data = res.data as Map<String, dynamic>;
    if (data['success'] != true) {
      throw DioException(
        requestOptions: res.requestOptions,
        message: data['message'] as String? ?? 'Request failed',
      );
    }
    return data;
  }

  // Auth
  Future<Map<String, dynamic>> register(Map<String, dynamic> body) async {
    final res = await _dio.post('/api/auth/register', data: body);
    return _unwrap(res);
  }

  Future<Map<String, dynamic>> login(Map<String, dynamic> body) async {
    final res = await _dio.post('/api/auth/login', data: body);
    return _unwrap(res);
  }

  Future<ProfileModel> getMe() async {
    final res = await _dio.get('/api/auth/me');
    final data = await _unwrap(res);
    return ProfileModel.fromJson(data['data'] as Map<String, dynamic>);
  }

  // Locations
  Future<LocationModel?> getFeaturedLocation() async {
    try {
      final res = await _dio.get('/api/locations/featured');
      final data = await _unwrap(res);
      final loc = data['data'];
      if (loc == null) return null;
      return LocationModel.fromJson(loc as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<List<LocationModel>> getLocations({int page = 1, int limit = 20}) async {
    try {
      final res = await _dio.get(
        '/api/locations',
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = await _unwrap(res);
      final items = (data['data'] as Map<String, dynamic>)['items'] as List;
      return items
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<LocationModel?> getLocationBySlug(String slug) async {
    try {
      final res = await _dio.get('/api/locations/$slug');
      final data = await _unwrap(res);
      return LocationModel.fromJson(data['data'] as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<List<LocationModel>> searchLocations(String query) async {
    try {
      final res = await _dio.get(
        '/api/locations/search',
        queryParameters: {'q': query, 'limit': 20},
      );
      final data = await _unwrap(res);
      final items = (data['data'] as Map<String, dynamic>)['items'] as List;
      return items
          .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // Posts
  Future<List<PostModel>> getFeed({int page = 1, int limit = 20}) async {
    try {
      final res = await _dio.get(
        '/api/posts/feed',
        queryParameters: {'page': page, 'limit': limit},
      );
      final data = await _unwrap(res);
      final items = (data['data'] as Map<String, dynamic>)['items'] as List;
      return items
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<PostModel?> createPost({
    required String imagePath,
    String? caption,
    String? locationId,
  }) async {
    final formData = FormData.fromMap({
      if (caption != null) 'caption': caption,
      if (locationId != null) 'location_id': locationId,
      'image': await MultipartFile.fromFile(imagePath),
    });
    final res = await _dio.post('/api/posts', data: formData);
    final data = await _unwrap(res);
    return PostModel.fromJson(data['data'] as Map<String, dynamic>);
  }

  Future<ProfileModel> updateProfile(Map<String, dynamic> body) async {
    final res = await _dio.patch('/api/profiles/me', data: body);
    final data = await _unwrap(res);
    return ProfileModel.fromJson(data['data'] as Map<String, dynamic>);
  }
}
