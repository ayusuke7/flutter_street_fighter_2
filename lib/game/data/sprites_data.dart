import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/types/vector.dart';

abstract class SpritesData {
  Map<String, List<Sprite>> ryu() {
    final IDLE_HITBOX = HitBox(-16, -80, 32, 78);
    final JUMP_HITBOX = HitBox(-16, -91, 32, 66);
    final BEND_HITBOX = HitBox(-16, -58, 32, 58);
    final CROUCH_HITBOX = HitBox(-16, -50, 32, 50);

    return {
      'IDLE': [
        Sprite(75, 14, 60, 89, anchor: Vector(34, 86), hitBox: IDLE_HITBOX),
        Sprite(7, 14, 59, 90, anchor: Vector(33, 87), hitBox: IDLE_HITBOX),
        Sprite(277, 11, 58, 92, anchor: Vector(32, 89), hitBox: IDLE_HITBOX),
        Sprite(211, 10, 55, 93, anchor: Vector(31, 90), hitBox: IDLE_HITBOX),
      ],
      'WALK_FRONT': [
        Sprite(9, 136, 53, 83, anchor: Vector(27, 81), hitBox: IDLE_HITBOX),
        Sprite(78, 131, 60, 89, anchor: Vector(35, 86), hitBox: IDLE_HITBOX),
        Sprite(152, 128, 64, 92, anchor: Vector(35, 87), hitBox: IDLE_HITBOX),
        Sprite(229, 130, 65, 90, anchor: Vector(29, 88), hitBox: IDLE_HITBOX),
        Sprite(307, 128, 54, 91, anchor: Vector(25, 87), hitBox: IDLE_HITBOX),
        Sprite(371, 128, 50, 89, anchor: Vector(25, 86), hitBox: IDLE_HITBOX),
      ],
      'WALK_BACK': [
        Sprite(777, 128, 61, 87, anchor: Vector(35, 85), hitBox: IDLE_HITBOX),
        Sprite(430, 124, 59, 90, anchor: Vector(36, 87), hitBox: IDLE_HITBOX),
        Sprite(495, 124, 57, 90, anchor: Vector(36, 88), hitBox: IDLE_HITBOX),
        Sprite(559, 124, 58, 90, anchor: Vector(38, 89), hitBox: IDLE_HITBOX),
        Sprite(631, 125, 58, 91, anchor: Vector(36, 88), hitBox: IDLE_HITBOX),
        Sprite(707, 126, 57, 89, anchor: Vector(36, 87), hitBox: IDLE_HITBOX),
      ],
      'JUMP_UP': [
        Sprite(67, 244, 56, 104, anchor: Vector(32, 107), hitBox: JUMP_HITBOX),
        Sprite(138, 233, 50, 89, anchor: Vector(25, 103), hitBox: JUMP_HITBOX),
        Sprite(197, 233, 54, 77, anchor: Vector(25, 103), hitBox: JUMP_HITBOX),
        Sprite(259, 240, 48, 70, anchor: Vector(28, 101), hitBox: JUMP_HITBOX),
        Sprite(319, 234, 48, 89, anchor: Vector(25, 106), hitBox: JUMP_HITBOX),
        Sprite(375, 244, 55, 109, anchor: Vector(31, 113), hitBox: JUMP_HITBOX),
      ],
      'JUMP_ROLL': [
        // Sprite(878, 121, 55, 103, anchor: Vector(25, 106), delay: 200),
        Sprite(442, 261, 61, 78, anchor: Vector(22, 90), hitBox: JUMP_HITBOX),
        Sprite(507, 259, 104, 42, anchor: Vector(61, 76), hitBox: JUMP_HITBOX),
        Sprite(617, 240, 53, 82, anchor: Vector(42, 111), hitBox: JUMP_HITBOX),
        Sprite(676, 257, 122, 44, anchor: Vector(71, 81), hitBox: JUMP_HITBOX),
        Sprite(804, 258, 71, 89, anchor: Vector(53, 98), hitBox: JUMP_HITBOX),
        Sprite(883, 261, 54, 109, anchor: Vector(31, 113), hitBox: JUMP_HITBOX),
      ],
      'JUMP_LAND': [
        Sprite(7, 268, 55, 85, anchor: Vector(29, 83), hitBox: JUMP_HITBOX),
      ],
      'CROUCH': [
        Sprite(679, 44, 61, 61, anchor: Vector(25, 58), hitBox: CROUCH_HITBOX),
        Sprite(611, 36, 57, 69, anchor: Vector(25, 66), hitBox: BEND_HITBOX),
        Sprite(551, 21, 53, 83, anchor: Vector(27, 81), hitBox: IDLE_HITBOX),
        Sprite(551, 21, 53, 83, anchor: Vector(27, 81), hitBox: IDLE_HITBOX),
      ],
    };
  }
}
