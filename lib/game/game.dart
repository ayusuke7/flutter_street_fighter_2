import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:platform_game/components/gamepad.dart';
import 'package:platform_game/game/data/fighter_data.dart';
import 'package:platform_game/game/data/game_data.dart';
import 'package:platform_game/game/figthers/ryu.dart';
import 'package:platform_game/game/stages/ken_stage.dart';
import 'package:platform_game/game/types/frame_time.dart';
import 'package:platform_game/game/types/vector.dart';

class GameStage extends StatefulWidget {
  const GameStage({super.key});

  @override
  State<GameStage> createState() => _GameStageState();
}

class _GameStageState extends State<GameStage> {
  final frameTime = FrameTime(0, 0);

  final ryu = Ryu(
    position: Vector(100, GameData.STAGE_FLOOR),
    direction: FighterDir.RIGTH,
  );
  final ken = Ryu(
    position: Vector(600, GameData.STAGE_FLOOR),
    direction: FighterDir.LEFT,
  );

  void _gameLoop() {
    SchedulerBinding.instance.scheduleFrameCallback(_frame);
  }

  void _frame(Duration timeStamp) {
    int currentTime = timeStamp.inMilliseconds;

    if (frameTime.previous == 0) {
      frameTime.previous = currentTime;
    }

    frameTime.secondsPassed = (currentTime - frameTime.previous) / 1000.0;
    frameTime.previous = currentTime;

    SchedulerBinding.instance.scheduleFrameCallback(_frame);
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
          child: Column(
            children: [
              Focus(
                autofocus: true,
                onKeyEvent: keyListenner,
                child: ColoredBox(
                  color: Colors.black,
                  child: CustomPaint(
                    size: GameData.GAME_VIEWPORT,
                    painter: KenStage(
                      frameTime: frameTime,
                      player1: ryu,
                      player2: ken,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 400.0,
                child: Gamepad(
                  onTapUp: GamePadAction(
                    onUp: () {
                      ryu.keyUp = false;
                    },
                    onDown: () {
                      ryu.keyUp = true;
                    },
                  ),
                  onTapLeft: GamePadAction(
                    onUp: () {
                      ryu.keyLeft = false;
                    },
                    onDown: () {
                      ryu.keyLeft = true;
                    },
                  ),
                  onTapDown: GamePadAction(
                    onUp: () {
                      ryu.keyDown = false;
                    },
                    onDown: () {
                      ryu.keyDown = true;
                    },
                  ),
                  onTapRight: GamePadAction(
                    onUp: () {
                      ryu.keyRight = false;
                    },
                    onDown: () {
                      ryu.keyRight = true;
                    },
                  ),
                  onTapX: GamePadAction(
                    onUp: () {
                      ryu.keyX = false;
                    },
                    onDown: () {
                      ryu.keyX = true;
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  KeyEventResult keyListenner(FocusNode node, KeyEvent event) {
    final pressed = HardwareKeyboard.instance.isLogicalKeyPressed(
      event.logicalKey,
    );

    if (event.logicalKey == LogicalKeyboardKey.keyW) {
      ryu.keyUp = pressed;
    } else if (event.logicalKey == LogicalKeyboardKey.keyA) {
      ryu.keyLeft = pressed;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      ryu.keyRight = pressed;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      ryu.keyDown = pressed;
    }

    return KeyEventResult.handled;
  }
}
