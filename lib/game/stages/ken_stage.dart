import 'package:flutter/material.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/types/frame_time.dart';

class KenStage extends CustomPainter {
  final FrameTime frameTime;
  final List<Fighter> figthers;

  KenStage({
    required this.figthers,
    required this.frameTime,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var figther in figthers) {
      figther.update(size, frameTime);
      figther.draw(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
