import 'package:flutter/material.dart';
import 'package:vrchat/gen/strings.g.dart';

/// VRChatのユーザータイプに関するヘルパー関数を提供するクラス
class UserTypeHelper {
  // インスタンス化を防止
  UserTypeHelper._();

  /// ユーザータグからユーザータイプを判定
  static String getUserTypeText(
    List<String>? tags, [
    Translations? translations,
  ]) {
    final strings = translations ?? t;
    if (tags == null) return strings.profile.userTypes.visitor;

    if (tags.contains('admin')) return strings.profile.userTypes.admin;
    if (tags.contains('system_trust_veteran')) {
      return strings.profile.userTypes.trusted;
    }
    if (tags.contains('system_trust_trusted')) {
      return strings.profile.userTypes.known;
    }
    if (tags.contains('system_trust_known')) {
      return strings.profile.userTypes.user;
    }
    if (tags.contains('system_trust_basic')) {
      return strings.profile.userTypes.newUser;
    }

    return strings.profile.userTypes.visitor;
  }

  /// ユーザータグに基づいて色を返す
  static Color getUserTypeColor(List<String>? tags) {
    if (tags == null) return Colors.grey;

    if (tags.contains('admin')) return Colors.red;
    if (tags.contains('system_trust_veteran')) {
      return Colors.deepPurpleAccent; // Trusted
    }
    if (tags.contains('system_trust_trusted')) return Colors.orange; // Known
    if (tags.contains('system_trust_known')) return Colors.green; // User
    if (tags.contains('system_trust_basic')) return Colors.blue; // New User

    return Colors.grey; // Visitor
  }
}

extension UserTagsExtension on List<String>? {
  /// ユーザータイプのテキスト表現を取得
  String get userTypeText => UserTypeHelper.getUserTypeText(this);

  /// ユーザータイプの色を取得
  Color get userTypeColor => UserTypeHelper.getUserTypeColor(this);
}
