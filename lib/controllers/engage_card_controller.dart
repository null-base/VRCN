import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrchat/provider/engage_card_provider.dart';
import 'package:vrchat/services/engage_card_service.dart';

class EngageCardController {
  EngageCardController(this.ref, this._service);

  final Ref ref;
  final EngageCardService _service;

  Future<void> loadBackgroundImage() async {
    ref.read(backgroundImageProvider.notifier).state = await _service
        .loadBackgroundImage();
  }

  Future<void> pickBackgroundImage() async {
    final image = await _service.pickAndPersistBackgroundImage();
    if (image != null) {
      ref.read(backgroundImageProvider.notifier).state = image;
    }
  }

  Future<void> removeBackgroundImage() async {
    await _service.removeBackgroundImage();
    ref.read(backgroundImageProvider.notifier).state = null;
  }
}

final engageCardControllerProvider = Provider<EngageCardController>((ref) {
  return EngageCardController(ref, EngageCardService());
});
