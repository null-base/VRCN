import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:http/http.dart' as http;
import 'package:vrchat/models/avtrdb_search_result.dart';
import 'package:vrchat/provider/settings_provider.dart';
import 'package:vrchat/utils/app_logger.dart';

final FutureProviderFamily<List<AvtrDbSearchResult>, String>
avtrDbSearchProvider = FutureProvider.family<List<AvtrDbSearchResult>, String>((
  ref,
  query,
) async {
  if (query.isEmpty) {
    return [];
  }

  // 設定からAPIのURLを取得
  final settings = ref.watch(settingsProvider);
  final baseUrl = settings.avatarSearchApiUrl;

  // ユーザーが URL を設定していない場合はエラーを返す
  if (baseUrl.isEmpty) {
    throw Exception('アバター検索APIのURLが設定されていません。設定画面から入力してください。');
  }

  final encodedQuery = Uri.encodeComponent(query);
  final url = Uri.parse('$baseUrl?search=$encodedQuery&n=5000');

  try {
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json; charset=utf-8',
        'Accept-Charset': 'utf-8',
      },
    );

    if (response.statusCode == 200) {
      final decodedResponse = utf8.decode(response.bodyBytes);
      final decoded = jsonDecode(decodedResponse);
      if (decoded is! List<Object?>) {
        throw const FormatException('アバター検索APIのレスポンス形式が不正です');
      }

      return [
        for (final json in decoded)
          if (json is Map<String, dynamic>) AvtrDbSearchResult.fromJson(json),
      ];
    } else {
      appLogger.d('アバター検索APIエラー: ${response.statusCode}');
      throw Exception('アバター検索に失敗しました: ${response.statusCode}');
    }
  } catch (e) {
    appLogger.d('アバター検索例外: $e');
    throw Exception('アバター検索中にエラーが発生しました: $e');
  }
});
