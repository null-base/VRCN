import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat/provider/files_provider.dart';

@immutable
class InventoryUploadTarget {
  const InventoryUploadTarget({required this.title, required this.tag});

  final String title;
  final String tag;
}

@immutable
class InventoryUploadException implements Exception {
  const InventoryUploadException({required this.error, this.statusCode});

  final Object error;
  final int? statusCode;
}

class InventoryUploadController {
  const InventoryUploadController(this.ref);

  final Ref ref;

  InventoryUploadTarget? targetForTab(int tabIndex, Translations translations) {
    return switch (tabIndex) {
      0 => InventoryUploadTarget(
        title: translations.inventory.uploadGallery,
        tag: 'gallery',
      ),
      1 => InventoryUploadTarget(
        title: translations.inventory.uploadIcon,
        tag: 'icon',
      ),
      2 => InventoryUploadTarget(
        title: translations.inventory.uploadEmoji,
        tag: 'emoji',
      ),
      3 => InventoryUploadTarget(
        title: translations.inventory.uploadSticker,
        tag: 'sticker',
      ),
      4 => InventoryUploadTarget(
        title: translations.inventory.uploadPrint,
        tag: 'print',
      ),
      _ => null,
    };
  }

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

  Future<XFile?> pickImage(ImageSource source) {
    return ImagePicker().pickImage(source: source);
  }

  Future<void> refreshFiles(String tag) async {
    ref.invalidate(getFilesByTagProvider(tag));
    await ref.read(getFilesByTagProvider(tag).future);
  }

  String uploadErrorMessage(Object error, Translations translations) {
    if (error is! InventoryUploadException) {
      return translations.inventory.uploadFailed;
    }

    return switch (error.statusCode) {
      400 => translations.inventory.uploadFailedFormat,
      401 => translations.inventory.uploadFailedAuth,
      413 => translations.inventory.uploadFailedSize,
      final int code => translations.inventory.uploadFailedServer(code: code),
      null => translations.inventory.uploadFailed,
    };
  }
}

final inventoryUploadControllerProvider = Provider<InventoryUploadController>((
  ref,
) {
  return InventoryUploadController(ref);
});
