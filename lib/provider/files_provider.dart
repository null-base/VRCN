import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart' hide Response;

final FutureProvider<FilesApi> vrchatFilesProvider = FutureProvider((
  ref,
) async {
  final rawApi = await ref.watch(vrchatRawApiProvider);
  return rawApi.getFilesApi();
});

// ファイル検索パラメータクラス
@immutable
class FileSearchParams {
  const FileSearchParams({this.tag, this.userId, this.n = 60, this.offset = 0});
  final String? tag;
  final String? userId;
  final int? n;
  final int? offset;

  // パラメータの比較用
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FileSearchParams &&
        other.tag == tag &&
        other.userId == userId &&
        other.n == n &&
        other.offset == offset;
  }

  @override
  int get hashCode => Object.hash(tag, userId, n, offset);
}

// ファイル一覧を取得するプロバイダー
final FutureProviderFamily<List<File>, FileSearchParams> getFilesProvider =
    FutureProvider.family<List<File>, FileSearchParams>((
      ref,
      params,
    ) async {
      final filesApi = await ref.watch(vrchatFilesProvider.future);

      try {
        final response = await filesApi.getFiles(
          tag: params.tag,
          userId: params.userId,
          n: params.n,
          offset: params.offset,
        );

        if (response.data == null) {
          return []; // データがない場合は空リストを返す
        }

        return response.data!;
      } catch (e) {
        throw Exception('ファイル一覧の取得に失敗しました: $e');
      }
    });

// 特定のタグのファイルを取得するヘルパープロバイダー
final FutureProviderFamily<List<File>, String> getFilesByTagProvider =
    FutureProvider.family<List<File>, String>((
      ref,
      tag,
    ) {
      final params = FileSearchParams(tag: tag);
      return ref.watch(getFilesProvider(params).future);
    });

// 画像アップロード用のパラメータクラス
@immutable
class UploadImageParams {
  const UploadImageParams({
    required this.file,
    required this.tag,
    this.frames,
    this.framesOverTime,
    this.animationStyle,
    this.maskTag,
  });
  final MultipartFile file;
  final String tag;
  final int? frames;
  final int? framesOverTime;
  final String? animationStyle;
  final String? maskTag;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UploadImageParams &&
        other.file == file &&
        other.tag == tag &&
        other.frames == frames &&
        other.framesOverTime == framesOverTime &&
        other.animationStyle == animationStyle &&
        other.maskTag == maskTag;
  }

  @override
  int get hashCode =>
      Object.hash(file, tag, frames, framesOverTime, animationStyle, maskTag);
}

// 汎用画像アップロードプロバイダー
final FutureProviderFamily<File, UploadImageParams> uploadImageProvider =
    FutureProvider.family<File, UploadImageParams>((
      ref,
      params,
    ) async {
      final filesApi = await ref.watch(vrchatFilesProvider.future);

      try {
        // タグに応じて適切なAPIエンドポイントを呼び出す
        Response<File> response;

        switch (params.tag) {
          case 'gallery':
            // ギャラリー専用エンドポイント
            response = await filesApi.uploadGalleryImage(file: params.file);

          case 'icon':
            // アイコン専用エンドポイント
            response = await filesApi.uploadIcon(file: params.file);

          case 'emoji':
          case 'sticker':
          default:
            // 汎用エンドポイント（追加パラメータ付き）
            response = await filesApi.uploadImage(
              file: params.file,
              tag: _imagePurposeForTag(params.tag),
            );
        }

        if (response.data == null) {
          throw Exception('画像のアップロードレスポンスがnullでした');
        }

        // アップロード成功後、対応するファイル一覧を更新
        ref.invalidate(getFilesByTagProvider(params.tag));

        return response.data!;
      } catch (e) {
        // より詳細なエラー情報を提供
        if (e is DioException) {
          rethrow;
        }
        throw Exception('画像のアップロードに失敗しました: $e');
      }
    });

ImagePurpose _imagePurposeForTag(String tag) {
  return ImagePurpose.values.firstWhere(
    (purpose) => purpose.value == tag,
    orElse: () =>
        throw ArgumentError.value(tag, 'tag', 'Unsupported image tag'),
  );
}

// ファイルパスからMultipartFileを作成するヘルパープロバイダー
final FutureProviderFamily<MultipartFile, String> createMultipartFileProvider =
    FutureProvider.family<MultipartFile, String>((ref, filePath) async {
      try {
        // ファイル拡張子を確認してMIMEタイプを設定
        final extension = filePath.split('.').last.toLowerCase();
        String? contentType;

        switch (extension) {
          case 'png':
            contentType = 'image/png';
          case 'jpg':
          case 'jpeg':
            contentType = 'image/jpeg';
          case 'gif':
            contentType = 'image/gif';
          default:
            contentType = 'image/png'; // デフォルトはPNG
        }

        return await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
          contentType: MediaType.parse(contentType),
        );
      } catch (e) {
        throw Exception('ファイルの読み込みに失敗しました: $e');
      }
    });

// 汎用画像アップロード用のパラメータクラス（ファイルパス用）
@immutable
class UploadImageFromPathParams {
  const UploadImageFromPathParams({
    required this.filePath,
    required this.tag,
    this.frames,
    this.framesOverTime,
    this.animationStyle,
    this.maskTag,
  });
  final String filePath;
  final String tag;
  final int? frames;
  final int? framesOverTime;
  final String? animationStyle;
  final String? maskTag;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UploadImageFromPathParams &&
        other.filePath == filePath &&
        other.tag == tag &&
        other.frames == frames &&
        other.framesOverTime == framesOverTime &&
        other.animationStyle == animationStyle &&
        other.maskTag == maskTag;
  }

  @override
  int get hashCode => Object.hash(
    filePath,
    tag,
    frames,
    framesOverTime,
    animationStyle,
    maskTag,
  );
}

// ファイルパスから汎用画像をアップロードするヘルパープロバイダー
final FutureProviderFamily<File, UploadImageFromPathParams>
uploadImageFromPathProvider =
    FutureProvider.family<File, UploadImageFromPathParams>((ref, params) async {
      // ファイルパスからMultipartFileを作成
      final multipartFile = await ref.watch(
        createMultipartFileProvider(params.filePath).future,
      );

      // アップロードパラメータを作成
      final uploadParams = UploadImageParams(
        file: multipartFile,
        tag: params.tag,
      );

      // アップロードを実行
      return ref.watch(uploadImageProvider(uploadParams).future);
    });
