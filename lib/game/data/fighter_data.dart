enum FighterDir {
  LEFT,
  RIGTH;

  int get side => this == RIGTH ? 1 : -1;

  bool get flip => this == LEFT ? true : false;
}

enum FighterState {
  IDLE,
  IDLE_TURN,
  WALK_BACK,
  WALK_FRONT,
  JUMP_UP,
  JUMP_START,
  JUMP_FRONT,
  JUMP_BACK,
  JUMP_LAND,
  CROUCH,
  CROUCH_UP,
  CROUCH_DOWN,
  CROUCH_TURN;

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
          JUMP_LAND,
          CROUCH_UP,
        ];
      case IDLE_TURN:
        return [IDLE, WALK_BACK, WALK_FRONT];
      case WALK_FRONT:
        return [IDLE, WALK_BACK];
      case WALK_BACK:
        return [IDLE, WALK_FRONT];
      case JUMP_START:
        return [IDLE, WALK_FRONT, WALK_BACK, JUMP_LAND];
      case JUMP_UP:
        return [JUMP_START];
      case JUMP_FRONT:
        return [JUMP_START];
      case JUMP_BACK:
        return [JUMP_START];
      case JUMP_LAND:
        return [JUMP_UP, JUMP_FRONT, JUMP_BACK];
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
