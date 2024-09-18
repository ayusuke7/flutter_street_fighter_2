import 'package:flutter/material.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/types/frame_time.dart';

class KenStage extends CustomPainter {
  final FrameTime frameTime;
  final Fighter? player1;
  final Fighter? player2;

  KenStage({
    required this.frameTime,
    this.player1,
    this.player2,
  });

  @override
  void paint(Canvas canvas, Size size) {
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
