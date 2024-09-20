import 'package:platform_game/game/figthers/fighter.dart';
import 'package:platform_game/game/types/sprite_sheet.dart';
import 'package:platform_game/game/utils/assets.dart';

class Ken extends Fighter {
  Ken({
    required super.position,
    required super.direction,
    super.name = "ken",
  }) : super(
          spriteSheetData: SpriteSheetData(
            spriteSheet: AssetsUtil.kenSpriteSheet,
          ),
        );
}
