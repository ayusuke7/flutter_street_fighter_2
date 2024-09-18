enum FighterDir {
  LEFT,
  RIGTH;

  int get side => this == RIGTH ? 1 : -1;
}

enum FighterState {
  IDLE,
  WALK_BACK,
  WALK_FRONT,
  JUMP_UP,
  JUMP_FRONT,
  JUMP_BACK,
  CROUCH,
  CROUCH_UP,
  CROUCH_DOWN;

  List<FighterState> get validStates {
    switch (this) {
      case IDLE:
        return [
          IDLE,
          WALK_BACK,
          WALK_FRONT,
          JUMP_UP,
          JUMP_FRONT,
          JUMP_BACK,
          CROUCH,
          CROUCH_UP,
          CROUCH_DOWN,
        ];
      case WALK_FRONT:
        return [IDLE, WALK_BACK];
      case WALK_BACK:
        return [IDLE, WALK_FRONT];
      case JUMP_UP:
        return [IDLE];
      case JUMP_FRONT:
        return [IDLE];
      case JUMP_BACK:
        return [IDLE];
      case CROUCH:
        return [CROUCH_DOWN];
      case CROUCH_UP:
        return [CROUCH];
      case CROUCH_DOWN:
        return [IDLE, WALK_FRONT, WALK_BACK];
      default:
        return [];
    }
  }
}

abstract class FighterData {
  static const GRAVITY = 1000.0;

  static const WALK_FRONT = 200.0;
  static const WALK_BACK = 150.0;
  static const JUMP_FRONT = 170.0;
  static const JUMP_BACK = 200.0;
  static const JUMP_UP = 420.0;
}
