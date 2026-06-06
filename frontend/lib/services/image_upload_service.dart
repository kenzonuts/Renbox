import 'package:image_picker/image_picker.dart';
import 'api_service.dart';

/// Handles image selection and upload via API.
class ImageUploadService {
  ImageUploadService(this._api);

  final ApiService _api;
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickFromGallery() => _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        imageQuality: 85,
      );

  Future<XFile?> pickFromCamera() => _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        imageQuality: 85,
      );
}
