import 'package:flutter/material.dart';

class StoryTouchZones extends StatelessWidget {
  final VoidCallback onTouchDown;
  final VoidCallback onLeftTapUp;
  final VoidCallback onRightTapUp;
  final VoidCallback onTapCancel;

  const StoryTouchZones({
    super.key,
    required this.onTouchDown,
    required this.onLeftTapUp,
    required this.onRightTapUp,
    required this.onTapCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (_) => onTouchDown(),
            onTapUp: (_) => onLeftTapUp(),
            onTapCancel: () => onTapCancel(),
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTapDown: (_) => onTouchDown(),
            onTapUp: (_) => onRightTapUp(),
            onTapCancel: () => onTapCancel(),
          ),
        ),
      ],
    );
  }
}
