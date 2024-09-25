import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:platform_game/game/data/sprites_data.dart';
import 'package:platform_game/game/stages/stage.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/utils/assets.dart';

class KenStage extends Stage {
  KenStage()
      : super(
          spriteSheetData: SpriteSheetData(
            spriteSheet: AssetsUtil.kenStageSpriteSheet,
          ),
        );

  @override
  void draw(Canvas canvas, Size size) {
    final bg = SpritesData.kenStage(SpriteKey.KEN_BG)[0];
    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      bg.toRect(),
      bg.toDest(-190, -10),
      Paint(),
    );

    final boat = SpritesData.kenStage(SpriteKey.KEN_BOAT)[0];
    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      boat.toRect(),
      boat.toDest(-128, -10),
      Paint(),
    );

    final floor = SpritesData.kenStage(SpriteKey.KEN_FLOOR)[0];
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
