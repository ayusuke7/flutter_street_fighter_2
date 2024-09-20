import 'package:flutter/material.dart';
import 'package:platform_game/game/data/fighter_data.dart';
import 'package:platform_game/game/data/game_data.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/key_map.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/types/vector.dart';

abstract class Fighter with KeyMap {
  final String name;

  final SpriteSheetData spriteSheetData;
  final Vector velocity = Vector.zero;
  final Vector position;
  final double gravity;

  FighterState fighterState;
  FighterDir direction;
  Fighter? opponent;

  int animationFrame = 0;
  int animationTimer = 0;

  Fighter({
    required this.name,
    required this.spriteSheetData,
    required this.position,
    required this.direction,
    this.fighterState = FighterState.IDLE,
    this.gravity = FighterData.GRAVITY,
  }) {
    _initState();
    flip = direction.flip;
  }

  List<Sprite> get currentAnimation {
    return spriteSheetData.animations[fighterState.name]!;
  }

  Sprite get currentAnimationFrame {
    return currentAnimation[animationFrame];
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
        (position.x * direction.side).floor() - currentAnimationFrame.anchor!.x,
        position.y.floor() - currentAnimationFrame.anchor!.y,
        currentAnimationFrame.width,
        currentAnimationFrame.height,
      ),
      Paint(),
    );
    final matrix = Matrix4.identity();
    canvas.transform(matrix.storage);
    _debug(canvas);
  }

  /* Privates Methods */

  void _initState() {
    switch (fighterState) {
      case FighterState.IDLE:
        velocity.x = 0;
        velocity.y = 0;
        break;
      case FighterState.WALK_FRONT:
        velocity.x = FighterData.WALK_FRONT;
        break;
      case FighterState.WALK_BACK:
        velocity.x = -FighterData.WALK_BACK;
        break;
      case FighterState.JUMP_UP:
        velocity.y = -FighterData.JUMP_UP;
        break;
      case FighterState.JUMP_FRONT:
        velocity.y = -FighterData.JUMP_UP;
        velocity.x = FighterData.JUMP_FRONT;
        break;
      case FighterState.JUMP_BACK:
        velocity.y = -FighterData.JUMP_UP;
        velocity.x = -FighterData.JUMP_BACK;
        break;
      default:
        break;
    }
  }

  void _changeState(FighterState newState) {
    if (newState == fighterState || !fighterState.validStates.contains(newState)) return;

    fighterState = newState;
    animationFrame = 0;

    _initState();
  }

  void _updateState(FrameTime time) {
    switch (fighterState) {
      case FighterState.IDLE:
        if (keyRight) {
          _changeState(FighterState.WALK_FRONT);
        } else if (keyLeft) {
          _changeState(FighterState.WALK_BACK);
        } else if (keyUp) {
          _changeState(FighterState.JUMP_UP);
        } else if (keyDown) {
          _changeState(FighterState.CROUCH_DOWN);
        }
        break;
      case FighterState.WALK_FRONT:
        if (!keyRight) {
          _changeState(FighterState.IDLE);
        }
        if (keyUp) {
          _changeState(FighterState.JUMP_FRONT);
        }
        break;
      case FighterState.WALK_BACK:
        if (!keyLeft) {
          _changeState(FighterState.IDLE);
        }
        if (keyUp) {
          _changeState(FighterState.JUMP_BACK);
        }
        break;
      case FighterState.JUMP_UP:
      case FighterState.JUMP_FRONT:
      case FighterState.JUMP_BACK:
        velocity.y += gravity * time.secondsPassed;
        if (position.y > GameData.STAGE_FLOOR) {
          position.y = GameData.STAGE_FLOOR;
          _changeState(FighterState.IDLE);
        }
        break;
      case FighterState.CROUCH_UP:
      case FighterState.CROUCH_DOWN:
        if (currentAnimationFrame.delay == -2) {
          _changeState(FighterState.CROUCH);
        }
        if (!keyDown) {
          _changeState(FighterState.IDLE);
        }
        break;
      default:
        break;
    }
  }

  void _updateAnimation(FrameTime time) {
    final frameDelay = currentAnimationFrame.delay;

    if (time.previous > animationTimer + frameDelay) {
      animationTimer = time.previous;

      if (frameDelay > 0) {
        animationFrame++;
      }

      if (animationFrame >= currentAnimation.length) {
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
    // HitBox
    if (currentAnimationFrame.hitBox != null) {
      final paintHitBox = Paint()
        ..color = Colors.green.withOpacity(.5)
        ..style = PaintingStyle.fill;

      canvas.drawRect(
        Rect.fromLTWH(
          (position.x * direction.side) + currentAnimationFrame.hitBox!.x,
          position.y + currentAnimationFrame.hitBox!.y,
          currentAnimationFrame.hitBox!.width,
          currentAnimationFrame.hitBox!.height,
        ),
        paintHitBox,
      );
    }

    // Anchor Origin
    if (currentAnimationFrame.anchor != null) {
      final paintAnchor = Paint()
        ..color = Colors.white
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      final sideX = position.x.floorToDouble() * direction.side;
      canvas.drawLine(
        Offset(sideX - 4.5, position.y.floorToDouble()),
        Offset(sideX + 4.5, position.y.floorToDouble()),
        paintAnchor,
      );
      canvas.drawLine(
        Offset(sideX, position.y.floorToDouble() - 4.5),
        Offset(sideX, position.y.floorToDouble() + 4.5),
        paintAnchor,
      );
    }
  }
}
