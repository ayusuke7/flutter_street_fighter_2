import 'dart:ui' as ui;

import 'package:flutter/services.dart';

abstract class AssetsUtil {
  static late ui.Image ryuSpriteSheet;
  static late ui.Image kenSpriteSheet;
  static late ui.Image kenStageSpriteSheet;

  static Future<void> loadImages() async {
    ryuSpriteSheet = await _loadImage('assets/images/ryu.png');
    kenSpriteSheet = await _loadImage('assets/images/ken.png');
    kenStageSpriteSheet = await _loadImage('assets/images/ken-stage.png');
  }

  static Future<ui.Image> _loadImage(String imageAssetPath) async {
    final data = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    var frame = await codec.getNextFrame();
    return frame.image;
  }
}
