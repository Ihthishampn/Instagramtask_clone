import 'package:flutter/material.dart';
import '../../widgets/story_tray/story_constants.dart';

String formatRelativeTime(Duration d) {
  if (d.inDays > 0) return '${d.inDays}d';
  if (d.inHours > 0) return '${d.inHours}h';
  if (d.inMinutes > 0) return '${d.inMinutes}m';
  return 'now';
}

double computeAvailableHeight(
  MediaQueryData mq, {
  double actionBar = actionBarHeight,
}) {
  return mq.size.height - actionBar - mq.padding.top - mq.padding.bottom;
}

Widget buildSendIcon({
  double angle = -0.4,
  double size = 24.0,
  double scale = 1.0,
  Color color = Colors.white,
}) {
  Widget icon = Icon(Icons.send_rounded, color: color, size: size);
  if (scale != 1.0) icon = Transform.scale(scale: scale, child: icon);
  if (angle != 0.0) icon = Transform.rotate(angle: angle, child: icon);
  return icon;
}
