import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrchat/provider/files_provider.dart';

@immutable
class InventoryUploadException implements Exception {
  const InventoryUploadException({required this.error, this.statusCode});

  final Object error;
  final int? statusCode;
}

class InventoryUploadController {
  const InventoryUploadController(this.ref);

  final Ref ref;

  Future<void> uploadImage({required XFile file, required String tag}) async {
    try {
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: file.name,
        contentType: MediaType.parse('image/png'),
      );
      final params = UploadImageParams(file: multipartFile, tag: tag);
      await ref.read(uploadImageProvider(params).future);
    } on DioException catch (error) {
      throw InventoryUploadException(
        error: error,
        statusCode: error.response?.statusCode,
      );
    } catch (error) {
      throw InventoryUploadException(error: error);
    }
  }
}

final inventoryUploadControllerProvider = Provider<InventoryUploadController>((
  ref,
) {
  return InventoryUploadController(ref);
});
