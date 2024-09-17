enum FighterDir { LEFT, RIGTH }

enum FighterState {
  IDLE,
  WALK_BACK,
  WALK_FRONT,
  JUMP_UP,
  JUMP_FRONT,
  JUMP_BACK,
  CROUCH,
  CROUCH_UP,
  CROUCH_DOWN,
}

extension FighterDirSide on FighterDir {
  int get side => this == FighterDir.RIGTH ? 1 : -1;
}

abstract class FighterData {
  static const GRAVITY = 1000.0;
  static const VELOCITY = 150.0;

  static const WALK_FRONT = 200.0;
  static const WALK_BACK = 150.0;
  static const JUMP_FRONT = 170.0;
  static const JUMP_BACK = 200.0;
  static const JUMP_UP = 450.0;
}
