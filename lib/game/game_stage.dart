import 'package:flutter/material.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/stages/stage.dart';
import 'package:platform_game/game/types/frame_time.dart';

class GameStage extends CustomPainter {
  final FrameTime frameTime;
  final Stage stage;

  final Fighter? player1;
  final Fighter? player2;

  GameStage({
    required this.frameTime,
    required this.stage,
    this.player1,
    this.player2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    stage.update(size, frameTime);
    stage.draw(canvas, size);

    player2?.opponent = player1;
    player1?.opponent = player2;

    if (player1 != null) {
      player1?.update(size, frameTime);
      player1?.draw(canvas);
    }

    if (player2 != null) {
      player2?.update(size, frameTime);
      player2?.draw(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
