import 'package:flutter/material.dart';

class InstagramRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const InstagramRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: Colors.black,
      color: Colors.white,
      strokeWidth: 2.0,
      displacement: 80.0,
      child: child,
    );
  }
}
