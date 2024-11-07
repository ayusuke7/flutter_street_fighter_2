import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:platform_game/game/camera.dart';
import 'package:platform_game/game/data/fighter_data.dart';
import 'package:platform_game/game/data/game_data.dart';
import 'package:platform_game/game/figthers/ryu.dart';
import 'package:platform_game/game/game_stage.dart';
import 'package:platform_game/game/stages/ken_stage.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/overlays/hud.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameStageState();
}

class _GameStageState extends State<Game> {
  final frameTime = FrameTime(0, 0);

  static final ryu = Ryu(
    position: GameData.FIGHTER_POSITION_LEFT,
    direction: FighterDir.RIGTH,
  );
  static final ken = Ryu(
    name: "ken",
    position: GameData.FIGHTER_POSITION_RIGHT,
    direction: FighterDir.LEFT,
  );

  final stage = KenStage();
  final camera = Camera(ryu, ken);
  final hud = Hud();

  void _gameLoop() {
    ryu.oponnent = ken;
    ken.oponnent = ryu;

    SchedulerBinding.instance.scheduleFrameCallback(_frame);
  }

  void _frame(Duration timeStamp) {
    SchedulerBinding.instance.scheduleFrameCallback(_frame);
    int currentTime = timeStamp.inMilliseconds;

    frameTime.secondsPassed = (currentTime - frameTime.previous) / 1000.0;
    frameTime.previous = currentTime;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _gameLoop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF3f3851),
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text("FPS: ${frameTime.fps}"),
          backgroundColor: const Color(0xFF3f3851),
        ),
        body: Center(
          child: Focus(
            autofocus: true,
            onKeyEvent: keyListenner,
            child: Transform.scale(
              scale: 2.0,
              child: ColoredBox(
                color: Colors.black,
                child: CustomPaint(
                  size: GameData.GAME_VIEWPORT,
                  painter: GameStage(
                    time: frameTime,
                    camera: camera,
                    player1: ryu,
                    player2: ken,
                    stage: stage,
                    hud: hud,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  KeyEventResult keyListenner(FocusNode node, KeyEvent event) {
    final pressed = HardwareKeyboard.instance.isLogicalKeyPressed(
      event.logicalKey,
    );

    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      ken.arrowUp(pressed);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
      ken.arrowLeft(pressed, ken.direction.flip);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      ken.arrowRight(pressed, ken.direction.flip);
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      ken.arrowDown(pressed);
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      ryu.arrowUp(pressed);
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      ryu.arrowDown(pressed);
    } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
      ryu.arrowLeft(pressed, ryu.direction.flip);
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      ryu.arrowRight(pressed, ryu.direction.flip);
    }

    return KeyEventResult.handled;
  }
}
