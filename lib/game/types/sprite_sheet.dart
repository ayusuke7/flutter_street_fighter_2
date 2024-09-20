import 'dart:ui' as ui;

import 'package:platform_game/game/types/vector.dart';

class SpriteSheetData {
  final ui.Image spriteSheet;
  Map<String, List<Sprite>> animations;

  SpriteSheetData({
    required this.spriteSheet,
    this.animations = const {},
  });
}

class Sprite {
  final double x;
  final double y;

  final double width;
  final double height;
  final double delay;

  final HitBox? hitBox;
  final Vector? anchor;

  const Sprite(
    this.x,
    this.y,
    this.width,
    this.height, {
    this.delay = 0,
    this.hitBox,
    this.anchor,
  });

  ui.Rect toRect() => ui.Rect.fromLTWH(x, y, width, height);

  ui.Rect toDest(double dx, double dy) => ui.Rect.fromLTWH(dx, dy, width, height);
}

class HitBox {
  final double x;
  final double y;

  final double width;
  final double height;

  HitBox(this.x, this.y, this.width, this.height);
}
