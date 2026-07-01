import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

final FutureProvider<InviteApi> vrchatInviteProvider = FutureProvider((
  ref,
) async {
  try {
    final rawApi = await ref.watch(vrchatRawApiProvider);
    return rawApi.getInviteApi();
  } catch (e) {
    throw Exception('InviteAPIの初期化に失敗しました: $e');
  }
});

@immutable
class InviteParams {
  const InviteParams({required this.worldId, required this.instanceId});
  final String worldId;
  final String instanceId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is InviteParams &&
        other.worldId == worldId &&
        other.instanceId == instanceId;
  }

  @override
  int get hashCode => worldId.hashCode ^ instanceId.hashCode;
}

// 自分に招待を送信
final FutureProviderFamily<SentNotification, InviteParams>
inviteMyselfProvider = FutureProvider.family<SentNotification, InviteParams>((
  ref,
  params,
) async {
  final inviteApi = ref.watch(vrchatInviteProvider).value;
  if (inviteApi == null) {
    throw Exception('招待の送信に失敗しました');
  }
  final response = await inviteApi.inviteMyselfTo(
    worldId: params.worldId,
    instanceId: params.instanceId,
  );
  if (response.data == null) {
    throw Exception('招待の送信に失敗しました');
  }
  return response.data!;
});
