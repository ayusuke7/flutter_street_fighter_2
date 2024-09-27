import 'dart:ui';

import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';

abstract class Stage {
  final SpriteSheetData spriteSheetData;

  Stage({
    required this.spriteSheetData,
  });

  void draw(Canvas canvas);

  void update(FrameTime time, Size size);
}
