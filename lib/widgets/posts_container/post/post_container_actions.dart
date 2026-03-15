import 'package:flutter/material.dart';


class ActionIcon extends StatelessWidget {
  final IconData icon;
  final num count;
  final Color? color;
  final VoidCallback onTap;
  final double rotateAngle;

  const ActionIcon({
    required this.icon,
    required this.count,
    required this.onTap,
    this.color,
    this.rotateAngle = 0.0,
    super.key,
  });

  String _formatCount(num count) {
    if (count < 1000) return count.toString();
    double value = count / 1000;
    double rounded = (value * 10).round() / 10;
    if (rounded % 1 == 0) {
      return '${rounded.toInt()}k';
    } else {
      return '${rounded}k';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          rotateAngle != 0.0
              ? Transform.rotate(
                  angle: rotateAngle,
                  child: Icon(icon, size: 26, color: color ?? Colors.white),
                )
              : Icon(icon, size: 26, color: color ?? Colors.white),
          const SizedBox(width: 4),
          Text(
            _formatCount(count),
            style: const TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class IGIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const IGIconButton({
    required this.icon,
    required this.onTap,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        child: Icon(icon, size: 28, color: color),
      ),
    );
  }
}
