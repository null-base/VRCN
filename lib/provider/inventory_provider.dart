import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_extended_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final inventoryItemsProvider = FutureProvider<List<InventoryItem>>((ref) async {
  final api = await ref.watch(vrchatInventoryApiProvider.future);
  final response = await api.getInventory(n: 100);
  return response.data?.data ?? const <InventoryItem>[];
});

final ownPrintsProvider = FutureProvider<List<Print>>((ref) async {
  final api = await ref.watch(vrchatPrintsApiProvider.future);
  final user = await ref.watch(currentUserProvider.future);
  final response = await api.getUserPrints(userId: user.id);
  final prints = response.data ?? const <Print>[];
  return [...prints]..sort((a, b) => b.timestamp.compareTo(a.timestamp));
});

final inventoryActionsProvider = Provider<InventoryActions>(
  InventoryActions.new,
);

class InventoryActions {
  const InventoryActions(this._ref);

  final Ref _ref;

  Future<void> spawnItem(String itemId) async {
    final api = await _ref.read(vrchatInventoryApiProvider.future);
    await api.spawnInventoryItem(id: itemId);
  }

  Future<void> unequipSlot(InventoryEquipSlot slot) async {
    final api = await _ref.read(vrchatInventoryApiProvider.future);
    await api.unequipOwnInventorySlot(inventoryItemId: slot);
    _ref.invalidate(inventoryItemsProvider);
  }

  Future<void> deletePrint(String printId) async {
    final api = await _ref.read(vrchatPrintsApiProvider.future);
    await api.deletePrint(printId: printId);
    _ref.invalidate(ownPrintsProvider);
  }
}
