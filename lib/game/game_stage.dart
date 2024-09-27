import 'package:flutter/material.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/stages/stage.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/overlays/hud.dart';

class GameStage extends CustomPainter {
  final FrameTime time;
  final Fighter player1;
  final Fighter player2;
  final Stage? stage;
  final Hud? hud;

  GameStage({
    required this.time,
    required this.player1,
    required this.player2,
    this.stage,
    this.hud,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /* Draw Stage */
    stage?.update(time, size);
    stage?.draw(canvas);

    /* Draw Figthers */
    player1.update(time, size);
    player1.draw(canvas);

    player2.update(time, size);
    player2.draw(
      canvas,
      Paint()
        ..colorFilter = const ColorFilter.mode(
          Colors.black,
          BlendMode.srcATop,
        ),
    );

    /* Draw HUD */
    hud?.update(
      time,
      player1: player1,
      player2: player2,
    );
    hud?.draw(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
