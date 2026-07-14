// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/abuki.png
  AssetGenImage get abuki => const AssetGenImage('assets/icons/abuki.png');

  /// File path: assets/icons/aihuru.png
  AssetGenImage get aihuru => const AssetGenImage('assets/icons/aihuru.png');

  /// File path: assets/icons/annobu.png
  AssetGenImage get annobu => const AssetGenImage('assets/icons/annobu.png');

  /// File path: assets/icons/enadori.png
  AssetGenImage get enadori => const AssetGenImage('assets/icons/enadori.png');

  /// File path: assets/icons/etoeto.png
  AssetGenImage get etoeto => const AssetGenImage('assets/icons/etoeto.png');

  /// File path: assets/icons/hare.png
  AssetGenImage get hare => const AssetGenImage('assets/icons/hare.png');

  /// File path: assets/icons/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/icons/icon.png');

  /// File path: assets/icons/kabi_lun.png
  AssetGenImage get kabiLun => const AssetGenImage('assets/icons/kabi_lun.png');

  /// File path: assets/icons/kazkiller.png
  AssetGenImage get kazkiller =>
      const AssetGenImage('assets/icons/kazkiller.png');

  /// File path: assets/icons/le0yuki.png
  AssetGenImage get le0yuki => const AssetGenImage('assets/icons/le0yuki.png');

  /// File path: assets/icons/masukawa.png
  AssetGenImage get masukawa =>
      const AssetGenImage('assets/icons/masukawa.png');

  /// File path: assets/icons/miyamoto.png
  AssetGenImage get miyamoto =>
      const AssetGenImage('assets/icons/miyamoto.png');

  /// File path: assets/icons/nullkalne.png
  AssetGenImage get nullkalne =>
      const AssetGenImage('assets/icons/nullkalne.png');

  /// File path: assets/icons/pampy.png
  AssetGenImage get pampy => const AssetGenImage('assets/icons/pampy.png');

  /// File path: assets/icons/r4in.png
  AssetGenImage get r4in => const AssetGenImage('assets/icons/r4in.png');

  /// File path: assets/icons/ray.png
  AssetGenImage get ray => const AssetGenImage('assets/icons/ray.png');

  /// File path: assets/icons/rea.png
  AssetGenImage get rea => const AssetGenImage('assets/icons/rea.png');

  /// File path: assets/icons/roize.png
  AssetGenImage get roize => const AssetGenImage('assets/icons/roize.png');

  /// File path: assets/icons/sasami_st.png
  AssetGenImage get sasamiSt =>
      const AssetGenImage('assets/icons/sasami_st.png');

  /// File path: assets/icons/vrcn.png
  AssetGenImage get vrcn => const AssetGenImage('assets/icons/vrcn.png');

  /// File path: assets/icons/vrcn_icon.png
  AssetGenImage get vrcnIcon =>
      const AssetGenImage('assets/icons/vrcn_icon.png');

  /// File path: assets/icons/vrcn_logo.png
  AssetGenImage get vrcnLogo =>
      const AssetGenImage('assets/icons/vrcn_logo.png');

  /// File path: assets/icons/yume.png
  AssetGenImage get yume => const AssetGenImage('assets/icons/yume.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    abuki,
    aihuru,
    annobu,
    enadori,
    etoeto,
    hare,
    icon,
    kabiLun,
    kazkiller,
    le0yuki,
    masukawa,
    miyamoto,
    nullkalne,
    pampy,
    r4in,
    ray,
    rea,
    roize,
    sasamiSt,
    vrcn,
    vrcnIcon,
    vrcnLogo,
    yume,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/She_is_watching_you.png
  AssetGenImage get sheIsWatchingYou =>
      const AssetGenImage('assets/images/She_is_watching_you.png');

  /// File path: assets/images/anomea_walk.png
  AssetGenImage get anomeaWalk =>
      const AssetGenImage('assets/images/anomea_walk.png');

  /// File path: assets/images/anomea_walk2.png
  AssetGenImage get anomeaWalk2 =>
      const AssetGenImage('assets/images/anomea_walk2.png');

  /// File path: assets/images/icon.png
  AssetGenImage get icon => const AssetGenImage('assets/images/icon.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/standing.png
  AssetGenImage get standing =>
      const AssetGenImage('assets/images/standing.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    sheIsWatchingYou,
    anomeaWalk,
    anomeaWalk2,
    icon,
    logo,
    standing,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
