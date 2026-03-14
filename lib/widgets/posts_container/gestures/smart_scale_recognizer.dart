import 'dart:ui';

import 'package:flutter/gestures.dart';

/// A scale recognizer that:
/// - Wins the arena INSTANTLY when 2+ fingers are down (any angle, no threshold)
/// - Never touches the arena for single-finger touches so vertical feed
///   scroll and horizontal PageView swipe always work freely
/// - Exposes [onDismissOverlay] so the owner can clean up if needed
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
      // Second finger down → seize the arena immediately.
      // No angle check, no distance threshold — exactly like Instagram.
      resolve(GestureDisposition.accepted);
    }
    // First finger → do NOT resolve. Let scroll/PageView compete normally.
  }

  @override
  void didStopTrackingLastPointer(int pointer) {
    _pointerCount = 0;
    super.didStopTrackingLastPointer(pointer);
  }

  @override
  void rejectGesture(int pointer) {
    if (_pointerCount >= 2) {
      // Don't let the arena take zoom away once two fingers are down.
      acceptGesture(pointer);
    } else {
      // Single finger — let scroll win normally.
      super.rejectGesture(pointer);
    }
  }
}