import 'package:flutter/material.dart';

/// Immutable state class representing the current zoom state of an image.
@immutable
class ZoomState {
  final double scale;
  final Offset translate;
  final double dim;

  const ZoomState({
    required this.scale,
    required this.translate,
    required this.dim,
  });

  static const zero = ZoomState(scale: 1.0, translate: Offset.zero, dim: 0.0);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ZoomState &&
        other.scale == scale &&
        other.translate == translate &&
        other.dim == dim;
  }

  @override
  int get hashCode => Object.hash(scale, translate, dim);

  @override
  String toString() {
    return 'ZoomState(scale: $scale, translate: $translate, dim: $dim)';
  }
}
