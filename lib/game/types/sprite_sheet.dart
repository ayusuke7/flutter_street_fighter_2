import 'dart:ui' as ui;

import 'package:platform_game/game/types/vector.dart';

class SpriteSheetData {
  final ui.Image spriteSheet;
  final Map<String, List<Sprite>> animations;

  SpriteSheetData({
    required this.spriteSheet,
    required this.animations,
  });
}

class Sprite {
  final double x;
  final double y;
  final double width;
  final double height;
  final Vector anchor;
  final double delay;

  Sprite(
    this.x,
    this.y,
    this.width,
    this.height, {
    this.delay = 0,
    required this.anchor,
  });
}
