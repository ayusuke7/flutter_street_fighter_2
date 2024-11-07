import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:platform_game/game/camera.dart';
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

  final bg = SpritesData.kenStage(SpriteKey.KEN_BG)[0];
  final boat = SpritesData.kenStage(SpriteKey.KEN_BOAT)[0];
  final floor = SpritesData.kenStage(SpriteKey.KEN_FLOOR)[0];

  @override
  void draw(Canvas canvas, Camera camera) {
    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      bg.toRect(),
      bg.toDest((16 - (camera.position.x / 2.15)).floorToDouble(), -camera.position.y),
      Paint(),
    );

    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      boat.toRect(),
      boat.toDest((150 - (camera.position.x / 1.61)).truncateToDouble(), -1 - camera.position.y),
      Paint(),
    );

    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      floor.toRect(),
      floor.toDest((192 - camera.position.x).floorToDouble(), 176 - camera.position.y),
      Paint(),
    );
  }

  @override
  void update(FrameTime time, Size size) {}
}
