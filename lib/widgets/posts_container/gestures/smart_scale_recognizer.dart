import 'dart:ui';

import 'package:flutter/gestures.dart';


class SmartScaleRecognizer extends ScaleGestureRecognizer {
  SmartScaleRecognizer({
    super.debugOwner,
    this.onDismissOverlay,
  });

  final VoidCallback? onDismissOverlay;

  int _pointerCount = 0;

  @override
  void addAllowedPointer(PointerDownEvent event) {
    super.addAllowedPointer(event);
    _pointerCount++;

    if (_pointerCount >= 2) {
     
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    _pointerCount = 0;
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void rejectGesture(int pointer) {
    if (_pointerCount >= 2) {
      acceptGesture(pointer);
    } else {
      super.rejectGesture(pointer);
    }
  }
}