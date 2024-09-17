import 'package:flutter/material.dart';
import 'package:platform_game/game/data/fighter_data.dart';
import 'package:platform_game/game/data/game_data.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/types/vector.dart';

abstract class Fighter {
  final SpriteSheetData spriteSheetData;
  final Vector velocity = Vector(0, 0);
  final Vector position;
  final double gravity;

  FighterState fighterState;
  FighterDir direction;

  int animationFrame = 0;
  int animationTimer = 0;

  Fighter({
    required this.spriteSheetData,
    required this.position,
    required this.direction,
    this.fighterState = FighterState.IDLE,
    this.gravity = FighterData.GRAVITY,
  }) {
    _initState();
  }

  List<Sprite> get currentAnimation {
    return spriteSheetData.animations[fighterState.name]!;
  }

  Sprite get currentAnimationFrame {
    return currentAnimation[animationFrame];
  }

  void changeState(FighterState newState) {
    if (newState == fighterState) return;
    // or !validFrom.contains(fighterState)

    fighterState = newState;
    animationFrame = 0;

    _initState();
  }

  void update(Size size, FrameTime time) {
    position.x += (velocity.x * direction.side) * time.secondsPassed;
    position.y += velocity.y * time.secondsPassed;

    _updateState(time);
    _updateAnimation(time);
    _updateStageContraints(size);
  }

  void draw(Canvas canvas) {
    canvas.scale(direction.side.toDouble(), 1);
    canvas.drawImageRect(
      spriteSheetData.spriteSheet,
      Rect.fromLTWH(
        currentAnimationFrame.x,
        currentAnimationFrame.y,
        currentAnimationFrame.width,
        currentAnimationFrame.height,
      ),
      Rect.fromLTWH(
        (position.x * direction.side).floor() - currentAnimationFrame.anchor.x,
        position.y.floor() - currentAnimationFrame.anchor.y,
        currentAnimationFrame.width,
        currentAnimationFrame.height,
      ),
      Paint(),
    );

    final matrix = Matrix4.identity();
    canvas.transform(matrix.storage);

    // _debug(canvas);
  }

  void _initState() {
    switch (fighterState) {
      case FighterState.IDLE:
        velocity.x = 0;
        velocity.y = 0;
        break;
      case FighterState.WALK_FRONT:
        velocity.x = FighterData.VELOCITY * direction.side;
        break;
      case FighterState.WALK_BACK:
        velocity.x = -FighterData.VELOCITY * direction.side;
        break;
      case FighterState.JUMP_UP:
        velocity.y = -FighterData.JUMP_UP;
        break;
      case FighterState.JUMP_FRONT:
        velocity.y = FighterData.JUMP_FRONT;
        velocity.x = FighterData.VELOCITY * direction.side;
        break;
      case FighterState.JUMP_BACK:
        velocity.y = -FighterData.JUMP_BACK;
        velocity.x = -FighterData.VELOCITY * direction.side;
        break;
      default:
        break;
    }
  }

  void _updateState(FrameTime time) {
    switch (fighterState) {
      case FighterState.JUMP_UP:
        velocity.y += gravity * time.secondsPassed;
        if (position.y > GameData.STAGE_FLOOR) {
          position.y = GameData.STAGE_FLOOR;
          changeState(FighterState.IDLE);
        }
        break;
      case FighterState.CROUCH_UP:
        if (currentAnimationFrame.delay == -2) {
          changeState(FighterState.IDLE);
        }
        break;
      case FighterState.CROUCH_DOWN:
        if (currentAnimationFrame.delay == -2) {
          changeState(FighterState.CROUCH);
        }
        break;
      default:
        break;
    }
  }

  void _updateAnimation(FrameTime time) {
    final frameDelay = currentAnimationFrame.delay;

    if (time.previous > animationTimer + 60) {
      animationTimer = time.previous;

      if (frameDelay > 0) {
        animationFrame++;
      }

      if (animationFrame > currentAnimation.length - 1) {
        animationFrame = 0;
      }
    }
  }

  void _updateStageContraints(Size size) {
    const width = 32.0;

    if (position.x > size.width - width) {
      position.x = size.width - width;
    }

    if (position.x < width) {
      position.x = width;
    }
  }

  void _debug(Canvas canvas) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(position.x.floorToDouble() - 4.5, position.y.floorToDouble()),
      Offset(position.x.floorToDouble() + 4.5, position.y.floorToDouble()),
      paint,
    );
    canvas.drawLine(
      Offset(position.x.floorToDouble(), position.y.floorToDouble() - 4.5),
      Offset(position.x.floorToDouble(), position.y.floorToDouble() + 4.5),
      paint,
    );
  }
}
