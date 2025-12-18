import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/models/vrcnsync_models.dart';
import 'package:vrchat/services/vrcnsync_service.dart';

// VRCNSyncの状態を管理するプロバイダー
final vrcnSyncStateProvider =
    StateNotifierProvider<VrcnSyncNotifier, SyncStatus>((ref) {
      final service = ref.watch(vrcnSyncServiceProvider);
      return VrcnSyncNotifier(service);
    });

class VrcnSyncNotifier extends StateNotifier<SyncStatus> {
  final VrcnSyncService _service;

  VrcnSyncNotifier(this._service) : super(const SyncStatus()) {
    _init();
  }

  void _init() {
    // デバイス検索結果を監視
    _service.devicesStream.listen((devices) {
      state = state.copyWith(devices: devices, isScanning: false);
    });
  }

  // 権限をリクエスト
  Future<bool> requestPermissions() async {
    try {
      return await _service.requestPermissions();
    } catch (e) {
      state = state.copyWith(errorMessage: '権限リクエストエラー: $e');
      return false;
    }
  }

  // サーバーを開始（写真受信時のコールバックを更新）
  Future<void> startServer({Function(File, bool)? onPhotoReceived}) async {
    try {
      state = state.copyWith(errorMessage: null);
      final success = await _service.startServer(
        onPhotoReceived: onPhotoReceived,
      );
      state = state.copyWith(isServerRunning: success);

      if (!success) {
        state = state.copyWith(errorMessage: 'サーバーの開始に失敗しました');
      }
    } catch (e) {
      state = state.copyWith(
        isServerRunning: false,
        errorMessage: 'サーバー開始エラー: $e',
      );
    }
  }

  // サーバーを停止
  Future<void> stopServer() async {
    try {
      await _service.stopServer();
      state = state.copyWith(isServerRunning: false);
    } catch (e) {
      state = state.copyWith(errorMessage: 'サーバー停止エラー: $e');
    }
  }


  // エラーメッセージをクリア
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
