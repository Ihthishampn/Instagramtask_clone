import 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../models/zoom_state.dart';


class ZoomOverlayWidget extends StatelessWidget {
  final Rect Function() getRect; 
  final ui.Image snapshot;
  final ValueNotifier<ZoomState> zoomNotifier;
  final AnimationController controller;
  final Animation<double> Function() scaleAnim;
  final Animation<Offset> Function() transAnim;
  final Animation<double> Function() dimAnim;

  const ZoomOverlayWidget({
    super.key,
    required this.getRect,
    required this.snapshot,
    required this.zoomNotifier,
    required this.controller,
    required this.scaleAnim,
    required this.transAnim,
    required this.dimAnim,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return ValueListenableBuilder<ZoomState>(
          valueListenable: zoomNotifier,
          builder: (_, zoom, __) {
            final animating =
                controller.isAnimating ||
                controller.status == AnimationStatus.completed;

            final scale = animating ? scaleAnim().value : zoom.scale;
            final translate = animating ? transAnim().value : zoom.translate;
            final dim = animating ? dimAnim().value : zoom.dim;

            final rect = getRect();

            if (rect.isEmpty || rect.width.isNaN || rect.height.isNaN) {
              return const SizedBox.shrink();
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                IgnorePointer(
                  child: ColoredBox(color: Colors.black.withOpacity(dim)),
                ),
                Positioned(
                  left: rect.left,
                  top: rect.top,
                  width: rect.width,
                  height: rect.height,
                  child: IgnorePointer(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..translate(translate.dx, translate.dy)
                        ..scale(scale),
                      child: RawImage(
                        image: snapshot,
                        width: rect.width,
                        height: rect.height,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
