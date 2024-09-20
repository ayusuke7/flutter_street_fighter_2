import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:platform_game/game/stages/stage.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/utils/assets.dart';

class KenStage extends Stage {
  KenStage()
      : super(
          spriteSheetData: SpriteSheetData(
            spriteSheet: AssetsUtil.kenStageSpriteSheet,
            animations: {
              "bg": [const Sprite(72, 208, 768, 176)],
              "boat": [const Sprite(8, 16, 522, 180)],
              "floor": [const Sprite(8, 392, 896, 72)],
            },
          ),
        );

  @override
  void draw(Canvas canvas, Size size) {
    final bg = spriteSheetData.animations['bg']!.first;
    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      bg.toRect(),
      bg.toDest(-190, -16),
      Paint(),
    );

    final boat = spriteSheetData.animations['boat']!.first;
    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      boat.toRect(),
      boat.toDest(-128, -16),
      Paint(),
    );

    final floor = spriteSheetData.animations['floor']!.first;
    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      floor.toRect(),
      floor.toDest(-256, 168),
      Paint(),
    );
  }

  @override
  void update(Size size, FrameTime time) {}
}
