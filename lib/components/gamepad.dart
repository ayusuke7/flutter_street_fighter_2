import 'package:flutter/material.dart';

class Gamepad extends StatelessWidget {
  final VoidCallback onTapUp;
  final VoidCallback onTapDown;
  final VoidCallback onTapLeft;
  final VoidCallback onTapRight;

  final VoidCallback onTapA;
  final VoidCallback onTapB;
  final VoidCallback onTapX;
  final VoidCallback onTapY;

  const Gamepad({
    super.key,
    required this.onTapDown,
    required this.onTapUp,
    required this.onTapLeft,
    required this.onTapRight,
    required this.onTapA,
    required this.onTapB,
    required this.onTapX,
    required this.onTapY,
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
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.grey.shade900,
                    ),
                    foregroundColor: const WidgetStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  icon: const Icon(Icons.expand_less),
                  onPressed: onTapUp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade900,
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      icon: const Icon(Icons.navigate_before),
                      onPressed: onTapLeft,
                    ),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade900,
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      icon: const Icon(Icons.navigate_next),
                      onPressed: onTapRight,
                    ),
                  ],
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.grey.shade900,
                    ),
                    foregroundColor: const WidgetStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  icon: const Icon(Icons.expand_more),
                  onPressed: onTapDown,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.grey.shade900,
                    ),
                    foregroundColor: const WidgetStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  icon: const Text('X', style: style),
                  onPressed: onTapX,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade900,
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      icon: const Text('Y', style: style),
                      onPressed: onTapY,
                    ),
                    IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.grey.shade900,
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
                          Colors.white,
                        ),
                      ),
                      icon: const Text('A', style: style),
                      onPressed: onTapA,
                    ),
                  ],
                ),
                IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.grey.shade900,
                    ),
                    foregroundColor: const WidgetStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  icon: const Text('B', style: style),
                  onPressed: onTapB,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
