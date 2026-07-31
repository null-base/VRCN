import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:vrchat/provider/settings_provider.dart';

final StateNotifierProviderFamily<UserNoteNotifier, String, String>
userNoteProvider =
    StateNotifierProvider.family<UserNoteNotifier, String, String>(
      UserNoteNotifier.new,
    );

class UserNoteNotifier extends StateNotifier<String> {
  UserNoteNotifier(this.ref, this.userId) : super('') {
    state = ref.read(sharedPreferencesProvider).getString(_key) ?? '';
  }

  final Ref ref;
  final String userId;

  String get _key => 'user_note_$userId';

  Future<void> save(String note) async {
    final trimmed = note.trim();
    state = trimmed;

    if (trimmed.isEmpty) {
      await ref.read(sharedPreferencesProvider).remove(_key);
      return;
    }

    await ref.read(sharedPreferencesProvider).setString(_key, trimmed);
  }
}
