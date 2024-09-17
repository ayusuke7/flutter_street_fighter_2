import 'package:platform_game/game/data/fighter_data.dart';
import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/types/vector.dart';
import 'package:platform_game/game/utils/assets.dart';

class Ken extends Fighter {
  Ken({
    required super.position,
    required super.direction,
  }) : super(
          spriteSheetData: SpriteSheetData(
            spriteSheet: AssetsUtil.kenSpriteSheet,
            animations: {
              FighterState.IDLE.name: [
                Sprite(346, 688, 60, 89, anchor: Vector(34, 86)),
                Sprite(2, 687, 59, 90, anchor: Vector(33, 87)),
                Sprite(72, 685, 58, 92, anchor: Vector(32, 89)),
                Sprite(142, 684, 55, 93, anchor: Vector(31, 90)),
              ],
              FighterState.WALK_FRONT.name: [
                Sprite(8, 872, 53, 83, anchor: Vector(27, 81)),
                Sprite(70, 867, 60, 89, anchor: Vector(35, 86)),
                Sprite(140, 866, 64, 90, anchor: Vector(35, 87)),
                Sprite(215, 865, 65, 89, anchor: Vector(29, 88)),
                Sprite(288, 866, 54, 89, anchor: Vector(25, 87)),
                Sprite(357, 867, 50, 89, anchor: Vector(25, 86)),
              ],
              FighterState.WALK_BACK.name: [
                Sprite(417, 868, 61, 87, anchor: Vector(35, 85)),
                Sprite(487, 866, 59, 90, anchor: Vector(36, 87)),
                Sprite(558, 865, 57, 90, anchor: Vector(36, 88)),
                Sprite(629, 864, 58, 90, anchor: Vector(38, 89)),
                Sprite(702, 865, 58, 91, anchor: Vector(36, 88)),
                Sprite(773, 866, 57, 89, anchor: Vector(36, 87)),
              ]
            },
          ),
        );
}
