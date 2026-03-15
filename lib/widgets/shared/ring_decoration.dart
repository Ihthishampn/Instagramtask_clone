import 'package:flutter/material.dart';

class RingDecoration extends StatelessWidget {
  final double outerSize;
  final double padding;
  final bool showGradient;
  final bool isYourStory;
  final Widget child;

  const RingDecoration({
    super.key,
    required this.outerSize,
    required this.padding,
    required this.showGradient,
    required this.isYourStory,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: outerSize,
      height: outerSize,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: showGradient
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFEDA75),
                  Color(0xFFFA7E1E),
                  Color(0xFFD62976),
                  Color(0xFF962FBF),
                  Color(0xFF4F5BD5),
                ],
              )
            : null,
        color: (!showGradient && isYourStory) ? const Color(0xFF1A1A1A) : null,
      ),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
