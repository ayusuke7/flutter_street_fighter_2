import 'package:flutter/material.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/stages/stage.dart';
import 'package:platform_game/game/types/frame_time.dart';

class GameStage extends CustomPainter {
  final FrameTime time;
  final Stage stage;

  final Fighter? player1;
  final Fighter? player2;

  GameStage({
    required this.time,
    required this.stage,
    this.player1,
    this.player2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /* Draw Stage */
    stage.update(size, time);
    stage.draw(canvas, size);

    /* Draw Figthers */
    if (player1 != null) {
      player1?.update(size, time);
      player1?.draw(canvas, Paint());
    }

    if (player2 != null) {
      player2?.update(size, time);
      player2?.draw(
        canvas,
        Paint()
          ..colorFilter = const ColorFilter.mode(
            Colors.black,
            BlendMode.srcATop,
          ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
