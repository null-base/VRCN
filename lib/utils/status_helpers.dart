import 'package:flutter/material.dart';
import 'package:vrchat/gen/strings.g.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

/// VRChatのユーザーステータスに関するヘルパー関数を提供するクラス
class StatusHelper {
  // インスタンス化を防止
  StatusHelper._();

  /// ユーザーステータスに応じた色を返す
  static Color getStatusColor(UserStatus? status) {
    switch (status) {
      case UserStatus.active:
        return Colors.green;
      case UserStatus.joinMe:
        return Colors.blue;
      case UserStatus.askMe:
        return Colors.orange;
      case UserStatus.busy:
        return Colors.red;
      case UserStatus.offline:
      default:
        return Colors.grey;
    }
  }

  /// ユーザーステータスに応じたテキストを返す
  static String getStatusText(UserStatus? status) {
    switch (status) {
      case UserStatus.active:
        return t.status.active;
      case UserStatus.joinMe:
        return t.status.joinMe;
      case UserStatus.askMe:
        return t.status.askMe;
      case UserStatus.busy:
        return t.status.busy;
      case UserStatus.offline:
        return t.status.offline;
      default:
        return t.status.unknown;
    }
  }

  /// ユーザーステータスに応じたアイコンを返す
  static IconData getStatusIcon(UserStatus? status) {
    switch (status) {
      case UserStatus.active:
        return Icons.check_circle_outline;
      case UserStatus.joinMe:
        return Icons.group_add;
      case UserStatus.askMe:
        return Icons.question_answer;
      case UserStatus.busy:
        return Icons.do_not_disturb_on;
      case UserStatus.offline:
      default:
        return Icons.offline_bolt;
    }
  }
}

/// UserStatusに対する拡張メソッド
extension UserStatusExtension on UserStatus? {
  /// このステータスの色を取得
  Color get color => StatusHelper.getStatusColor(this);

  /// このステータスのテキスト表現を取得
  String get text => StatusHelper.getStatusText(this);

  /// このステータスのアイコンを取得
  IconData get icon => StatusHelper.getStatusIcon(this);
}
