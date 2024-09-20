import 'package:flutter/material.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';

abstract class Stage {
  final SpriteSheetData spriteSheetData;

  Stage({
    required this.spriteSheetData,
  });

  void update(Size size, FrameTime time);

  void draw(Canvas canvas, Size size);
}
