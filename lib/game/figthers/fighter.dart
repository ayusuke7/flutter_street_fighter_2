import 'package:flutter/material.dart';
import 'package:platform_game/game/data/fighter_data.dart';
import 'package:platform_game/game/data/game_data.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/key_map.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/types/vector.dart';

const initialVelocitys = {
  FighterState.WALK_FRONT: FighterData.WALK_FRONT,
  FighterState.JUMP_FRONT: FighterData.JUMP_FRONT,
  FighterState.WALK_BACK: -FighterData.WALK_FRONT,
  FighterState.JUMP_BACK: -FighterData.JUMP_BACK,
};

abstract class Fighter with KeyMap {
  final String name;

  final SpriteSheetData spriteSheetData;
  final Vector velocity = Vector(0, 0);
  final Vector position;
  final double gravity;

  FighterState fighterState;
  FighterDir direction;
  Fighter? oponnent;

  int animationFrame = 0;
  int animationTimer = 0;

  Fighter({
    required this.name,
    required this.position,
    required this.direction,
    required this.spriteSheetData,
    this.gravity = FighterData.GRAVITY,
    this.fighterState = FighterState.IDLE,
  }) {
    _initState();
  }

  List<Sprite> get currentAnimation {
    return spriteSheetData.animations[fighterState.name]!;
  }

  Sprite get currentAnimationFrame {
    return currentAnimation[animationFrame];
  }

  FighterDir get currentDirection {
    if (oponnent != null && position.x >= oponnent!.position.x) {
      return FighterDir.LEFT;
    }

    return FighterDir.RIGTH;
  }

  void update(Size size, FrameTime time) {
    position.x += (velocity.x * direction.side) * time.secondsPassed;
    position.y += velocity.y * time.secondsPassed;

    if ([
      FighterState.IDLE,
      FighterState.WALK_FRONT,
      FighterState.WALK_BACK,
    ].contains(fighterState)) {
      direction = currentDirection;
    }

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
    canvas.transform(Matrix4.identity().storage);

    _debug(canvas);
  }

  /* Privates Methods */

  void _changeState(FighterState newState) {
    if (newState == fighterState || !newState.validStates.contains(fighterState)) {
      return;
    }

    fighterState = newState;
    animationFrame = 0;

    _initState();
  }

  void _initState() {
    switch (fighterState) {
      case FighterState.IDLE:
      case FighterState.JUMP_START:
      case FighterState.JUMP_LAND:
      case FighterState.CROUCH_DOWN:
        _handleIdleInit();
        break;
      case FighterState.WALK_FRONT:
      case FighterState.WALK_BACK:
        _handleMoveInit();
        break;
      case FighterState.JUMP_UP:
      case FighterState.JUMP_FRONT:
      case FighterState.JUMP_BACK:
        _handleJumpInit();
        break;
      default:
        break;
    }
  }

  void _updateState(FrameTime time) {
    switch (fighterState) {
      case FighterState.IDLE:
        _handleIdleState();
        break;
      case FighterState.WALK_FRONT:
        _handleWalkFrontState();
        break;
      case FighterState.WALK_BACK:
        _handleWalkBackState();
        break;
      case FighterState.JUMP_UP:
      case FighterState.JUMP_FRONT:
      case FighterState.JUMP_BACK:
        _handleJumpState(time);
        break;
      case FighterState.JUMP_START:
        _handleJumpStartState();
        break;
      case FighterState.JUMP_LAND:
        _handleJumpLandState();
        break;
      case FighterState.CROUCH:
        _handleCrouchState();
        break;
      case FighterState.CROUCH_UP:
        _handleCrouchUpState();
        break;
      case FighterState.CROUCH_DOWN:
        _handleCrouchDownState();
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

  /* Handle Init States */

  void _handleIdleInit() {
    velocity.x = 0;
    velocity.y = 0;
  }

  void _handleMoveInit() {
    velocity.x = initialVelocitys[fighterState] ?? 0;
  }

  void _handleJumpInit() {
    velocity.y = -FighterData.JUMP_UP;
    _handleMoveInit();
  }

  /* Handle Update States */

  void _handleIdleState() {
    if (isUp) {
      _changeState(FighterState.JUMP_START);
    }
    if (isDown) {
      _changeState(FighterState.CROUCH_DOWN);
    }
    if (isForward) {
      _changeState(FighterState.WALK_FRONT);
    }
    if (isBackward) {
      _changeState(FighterState.WALK_BACK);
    }
  }

  void _handleWalkFrontState() {
    if (!isForward) {
      _changeState(FighterState.IDLE);
    }
    if (isUp) {
      _changeState(FighterState.JUMP_START);
    }
    if (isDown) {
      _changeState(FighterState.CROUCH_DOWN);
    }
  }

  void _handleWalkBackState() {
    if (!isBackward) {
      _changeState(FighterState.IDLE);
    }
    if (isUp) {
      _changeState(FighterState.JUMP_START);
    }
    if (isDown) {
      _changeState(FighterState.CROUCH_DOWN);
    }
  }

  void _handleJumpState(FrameTime time) {
    velocity.y += gravity * time.secondsPassed;
    if (position.y > GameData.STAGE_FLOOR) {
      position.y = GameData.STAGE_FLOOR;
      _changeState(FighterState.JUMP_LAND);
    }
  }

  void _handleJumpStartState() {
    if (currentAnimationFrame.delay == -2) {
      if (isBackward) {
        _changeState(FighterState.JUMP_BACK);
      } else if (isForward) {
        _changeState(FighterState.JUMP_FRONT);
      } else {
        _changeState(FighterState.JUMP_UP);
      }
    }
  }

  void _handleJumpLandState() {
    if (animationFrame < 1) return;

    if (!isIdle) {
      _handleIdleState();
    } else if (currentAnimationFrame.delay != -2) {
      return;
    }

    _changeState(FighterState.IDLE);
  }

  void _handleCrouchState() {
    if (!isDown) {
      _changeState(FighterState.CROUCH_UP);
    }
  }

  void _handleCrouchDownState() {
    if (currentAnimationFrame.delay == -2) {
      _changeState(FighterState.CROUCH);
    }
  }

  void _handleCrouchUpState() {
    if (currentAnimationFrame.delay == -2) {
      _changeState(FighterState.IDLE);
    }
  }

  /* Debug */

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
