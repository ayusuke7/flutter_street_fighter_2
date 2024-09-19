import 'package:flutter/material.dart';

class GamePadAction {
  final VoidCallback onUp;
  final VoidCallback onDown;

  GamePadAction({
    required this.onUp,
    required this.onDown,
  });
}

class Gamepad extends StatelessWidget {
  final GamePadAction? onTapUp;
  final GamePadAction? onTapDown;
  final GamePadAction? onTapLeft;
  final GamePadAction? onTapRight;

  final GamePadAction? onTapA;
  final GamePadAction? onTapB;
  final GamePadAction? onTapX;
  final GamePadAction? onTapY;

  const Gamepad({
    super.key,
    this.onTapUp,
    this.onTapDown,
    this.onTapLeft,
    this.onTapRight,
    this.onTapA,
    this.onTapB,
    this.onTapX,
    this.onTapY,
  });

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white);
    return Container(
      margin: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  child: const Icon(Icons.expand_less),
                  onTap: onTapUp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton(
                      child: const Icon(Icons.navigate_before),
                      onTap: onTapLeft,
                    ),
                    _buildButton(
                      child: const Icon(Icons.navigate_next),
                      onTap: onTapRight,
                    ),
                  ],
                ),
                _buildButton(
                  child: const Icon(Icons.expand_more),
                  onTap: onTapDown,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(
                  child: const Text('X', style: style),
                  onTap: onTapX,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildButton(
                      child: const Text('Y', style: style),
                      onTap: onTapY,
                    ),
                    _buildButton(
                      child: const Text('A', style: style),
                      onTap: onTapA,
                    ),
                  ],
                ),
                _buildButton(
                  child: const Text('B', style: style),
                  onTap: onTapB,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButton({
    required Widget child,
    required GamePadAction? onTap,
  }) {
    return InkWell(
      onTapUp: (_) {
        onTap?.onUp();
      },
      onTapDown: (_) {
        onTap?.onDown();
      },
      child: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        child: child,
      ),
    );
  }
}
