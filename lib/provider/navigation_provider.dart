import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

/// ナビゲーションインデックスを管理するプロバイダー
final navigationIndexProvider = StateProvider<int>((ref) => 0);

final navigationActionsProvider = Provider<NavigationActions>(
  NavigationActions.new,
);

class NavigationActions {
  const NavigationActions(this._ref);

  final Ref _ref;

  void setIndex(int index) {
    _ref.read(navigationIndexProvider.notifier).state = index;
  }
}

/// Scaffoldキーを管理するプロバイダー
final scaffoldKeyProvider = Provider<GlobalKey<ScaffoldState>>((ref) {
  return GlobalKey<ScaffoldState>();
});
