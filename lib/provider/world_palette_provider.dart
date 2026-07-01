import 'dart:async';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
import 'package:vrchat/utils/cache_manager.dart';

final FutureProviderFamily<CorePalette?, String> worldPaletteProvider =
    FutureProvider.family<CorePalette?, String>((
      ref,
      imageUrl,
    ) async {
      if (imageUrl.isEmpty) return null;

      try {
        final imageProvider = CachedNetworkImageProvider(
          imageUrl,
          cacheManager: JsonCacheManager(),
          headers: const {'User-Agent': 'VRCN'},
        );
        final completer = Completer<ui.Image>();
        final stream = imageProvider.resolve(const ImageConfiguration());
        late ImageStreamListener listener;
        listener = ImageStreamListener((info, _) {
          completer.complete(info.image);
          stream.removeListener(listener);
        });
        stream.addListener(listener);
        final uiImage = await completer.future;
        final byteData = await uiImage.toByteData();
        if (byteData == null) return null;

        final pixels = byteData.buffer.asUint32List();
        final quantized = await QuantizerCelebi().quantize(pixels, 16);
        final ranked = Score.score(quantized.colorToCount, desired: 1);
        final topColor = ranked.isNotEmpty ? ranked.first : 0xFF888888;
        return CorePalette.of(topColor);
      } catch (_) {
        return null;
      }
    });
