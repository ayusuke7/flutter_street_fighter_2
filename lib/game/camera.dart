import 'dart:math';
import 'dart:ui';

import 'package:platform_game/game/data/game_data.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/types/vector.dart';

import 'types/frame_time.dart';

class Camera {
  final Fighter player1;
  final Fighter player2;

  Vector position = GameData.CAMERA_START_POSITION;
  double speed = 60.0;

  Camera(
    this.player1,
    this.player2,
  );

  void update(FrameTime time, Size size) {
    // position.x += speed * time.secondsPassed;

    // if (position.x > 640 || position.x < 256) {
    //   speed = -speed;
    // }

    position.y = -6 + (min(player2.position.y, player1.position.y) / 10).floorToDouble();

    var minX = min(player2.position.x, player1.position.x);
    var maxX = max(player2.position.x, player1.position.x);

    if (maxX - minX > size.width - GameData.SCROLL_BOUNDRY * 2) {
      var midPoint = (maxX - minX) / 2;
      position.x = minX + midPoint - (size.width / 2);
    } else {
      for (var fighter in [player1, player2]) {
        if (fighter.position.x < position.x + GameData.SCROLL_BOUNDRY &&
                fighter.velocity.x * fighter.direction.side < 0 ||
            fighter.position.x > position.x + size.width - GameData.SCROLL_BOUNDRY &&
                fighter.velocity.x * fighter.direction.side > 0) {
          position.x += fighter.velocity.x * fighter.direction.side * time.secondsPassed;
        }
      }
    }

    if (position.x < GameData.STAGE_PADDING) {
      position.x = GameData.STAGE_PADDING;
    }

    if (position.x > GameData.STAGE_WIDTH + GameData.STAGE_PADDING - size.width) {
      position.x = GameData.STAGE_WIDTH + GameData.STAGE_PADDING - size.width;
    }

    if (position.y < 0) {
      position.y = 0;
    }

    if (position.y > GameData.STAGE_HEIGHT - size.height) {
      position.y = GameData.STAGE_HEIGHT - size.height;
    }
  }
}
