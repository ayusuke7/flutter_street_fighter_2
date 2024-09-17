import 'dart:ui';

abstract class GameData {
  static const GAME_VIEWPORT = Size(720.0, 480.0);

  static get STAGE_FLOOR => GAME_VIEWPORT.height - 80.0;
}
