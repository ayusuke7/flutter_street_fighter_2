import 'package:flutter/material.dart';
import 'package:platform_game/game/game.dart';
import 'package:platform_game/game/utils/assets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AssetsUtil.loadImages();
  runApp(const Game());
}
