import 'package:flutter/material.dart';
import 'package:platform_game/game/camera.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/overlays/hud.dart';
import 'package:platform_game/game/stages/stage.dart';
import 'package:platform_game/game/types/frame_time.dart';

class GameStage extends CustomPainter {
  final FrameTime time;

  final Fighter player1;
  final Fighter player2;

  final Stage? stage;
  final Hud? hud;

  final Camera camera;

  GameStage({
    required this.time,
    required this.camera,
    required this.player1,
    required this.player2,
    this.stage,
    this.hud,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /* Camera */
    camera.update(time, size);

    /* Draw Stage */
    stage?.update(time, size);
    stage?.draw(canvas, camera);

    /* Draw Figthers */
    player1.update(time, size, camera);
    player1.draw(canvas, camera);

    player2.update(time, size, camera);
    player2.draw(canvas, camera);

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
