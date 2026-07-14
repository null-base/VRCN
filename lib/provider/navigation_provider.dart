import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// ナビゲーションインデックスを管理するプロバイダー
final navigationIndexProvider = StateProvider<int>((ref) => 0);

/// Scaffoldキーを管理するプロバイダー
final scaffoldKeyProvider = Provider<GlobalKey<ScaffoldState>>((ref) {
  return GlobalKey<ScaffoldState>();
});
