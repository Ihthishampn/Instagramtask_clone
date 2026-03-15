import 'package:flutter/material.dart';

class ProfilePlaceholder extends StatelessWidget {
  final double size;
  const ProfilePlaceholder({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    final headSize = size * 0.4;
    final bodyHeight = size * 0.36;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: size * 0.14,
            child: Container(
              width: headSize,
              height: headSize,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: size * 0.06,
            child: Container(
              width: size * 0.86,
              height: bodyHeight,
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(bodyHeight / 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
