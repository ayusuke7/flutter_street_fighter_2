import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:platform_game/components/gamepad.dart';
import 'package:platform_game/game/data/fighter_data.dart';
import 'package:platform_game/game/data/game_data.dart';
import 'package:platform_game/game/figthers/ken.dart';
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
  final ken = Ken(
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
        appBar: AppBar(title: Text("FPS: ${frameTime.fps}")),
        backgroundColor: const Color(0xFF3f3851),
        body: Column(
          children: [
            ColoredBox(
              color: Colors.black,
              child: CustomPaint(
                size: GameData.GAME_VIEWPORT,
                painter: KenStage(
                  frameTime: frameTime,
                  figthers: [ryu],
                ),
              ),
            ),
            SizedBox(
              width: 400.0,
              child: Gamepad(
                onTapUp: () {
                  ryu.changeState(FighterState.JUMP_UP);
                },
                onTapLeft: () {
                  ryu.changeState(FighterState.WALK_BACK);
                },
                onTapDown: () {
                  ryu.changeState(FighterState.CROUCH_DOWN);
                },
                onTapRight: () {
                  ryu.changeState(FighterState.WALK_FRONT);
                },
                onTapX: () {
                  ryu.changeState(FighterState.JUMP_FRONT);
                },
                onTapY: () {},
                onTapA: () {},
                onTapB: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
