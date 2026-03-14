import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../gestures/smart_scale_recognizer.dart';
import '../models/zoom_state.dart';
import 'zoom_overlay_widget.dart';

class PinchZoomOverlay extends StatefulWidget {
  final Widget child;
  const PinchZoomOverlay({super.key, required this.child});

  @override
  State<PinchZoomOverlay> createState() => _PinchZoomOverlayState();
}

class _PinchZoomOverlayState extends State<PinchZoomOverlay>
    with SingleTickerProviderStateMixin {
  final _repaintKey = GlobalKey();

  OverlayEntry? _entry;
  bool _overlayVisible = false;

  final _zoomNotifier = ValueNotifier<ZoomState>(ZoomState.zero);

  late final AnimationController _ctrl;
  late Animation<double> _scaleAnim;
  late Animation<Offset> _transAnim;
  late Animation<double> _dimAnim;

  Offset? _focalStart;
  ui.Image? _snapshot;
  Timer? _autoDismissTimer;


  bool _gestureActive = false;
  bool _pendingSnapBack = false;

  Rect _liveRect() {
    final box = _repaintKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize || box.size.isEmpty) return Rect.zero;
    final sz = box.size;
    if (sz.width <= 0 || sz.height <= 0 || sz.width.isNaN || sz.height.isNaN) {
      return Rect.zero;
    }
    return box.localToGlobal(Offset.zero) & sz;
  }

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        )..addStatusListener((s) {
          if (s == AnimationStatus.completed) {
            _zoomNotifier.value = ZoomState.zero;
            _removeOverlay();
          }
        });
  }

  @override
  void dispose() {
    _cancelAutoDismissTimer();
    try {
      _removeOverlay();
    } catch (_) {}
    _ctrl.dispose();
    _zoomNotifier.dispose();
    _snapshot?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _dismissImmediately();
    super.deactivate();
  }

  @override
  void reassemble() {
    _dismissImmediately();
    super.reassemble();
  }

  void _startAutoDismissTimer() {
    _autoDismissTimer?.cancel();
    _autoDismissTimer = Timer(const Duration(seconds: 1), () {
      _dismissImmediately();
    });
  }

  void _cancelAutoDismissTimer() {
    _autoDismissTimer?.cancel();
    _autoDismissTimer = null;
  }

  Future<ui.Image?> _capture() async {
    final rb =
        _repaintKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
    if (rb == null) return null;
    try {
      return await rb.toImage(pixelRatio: View.of(context).devicePixelRatio);
    } catch (_) {
      return null;
    }
  }

  Future<void> _showOverlay() async {
    if (_overlayVisible) return;

    final snap = await _capture();

    if (!mounted) return;


    if (_pendingSnapBack) {
      _pendingSnapBack = false;
      snap?.dispose();
      return;
    }

    if (!_gestureActive) {
      snap?.dispose();
      return;
    }

    if (snap == null) return;

    _snapshot?.dispose();
    _snapshot = snap;
    _overlayVisible = true;
    _ctrl.reset();

    _entry = OverlayEntry(
      builder: (_) => ZoomOverlayWidget(
        getRect: _liveRect,
        snapshot: _snapshot!,
        zoomNotifier: _zoomNotifier,
        controller: _ctrl,
        scaleAnim: () => _scaleAnim,
        transAnim: () => _transAnim,
        dimAnim: () => _dimAnim,
      ),
    );

    Overlay.of(context).insert(_entry!);
    _startAutoDismissTimer();
  }

  void _removeOverlay() {
    try {
      _entry?.remove();
    } catch (_) {}
    _entry = null;
    _overlayVisible = false;
    _cancelAutoDismissTimer();
  }

  void _dismissImmediately() {
    _gestureActive = false;
    _pendingSnapBack = false;
    if (_ctrl.isAnimating) _ctrl.stop();
    _zoomNotifier.value = ZoomState.zero;
    _removeOverlay();
  }

  void _dismissOverlayIfVisible() {
    if (_overlayVisible) _dismissImmediately();
  }

  void _snapBack() {
    final cur = _zoomNotifier.value;
    final c = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _scaleAnim = Tween<double>(begin: cur.scale, end: 1.0).animate(c);
    _transAnim = Tween<Offset>(
      begin: cur.translate,
      end: Offset.zero,
    ).animate(c);
    _dimAnim = Tween<double>(begin: cur.dim, end: 0.0).animate(c);
    _ctrl.forward();
  }

  void _onScaleStart(ScaleStartDetails d) {
    _gestureActive = true;
    _pendingSnapBack = false;

    if (_ctrl.isAnimating) {
      _ctrl.stop();
      _zoomNotifier.value = ZoomState(
        scale: _scaleAnim.value,
        translate: _transAnim.value,
        dim: _dimAnim.value,
      );
    }
    _focalStart = d.focalPoint;
    _showOverlay(); 
  }

  void _onScaleUpdate(ScaleUpdateDetails d) {
    if (!_overlayVisible) return;
    final scale = d.scale.clamp(1.0, 8.0);
    final delta = d.focalPoint - (_focalStart ?? d.focalPoint);
    _zoomNotifier.value = ZoomState(
      scale: scale,
      translate: delta * (1.0 - 1.0 / scale),
      dim: ((scale - 1.0) / 3.5).clamp(0.0, 0.55),
    );
  }

  void _onScaleEnd(ScaleEndDetails _) {
    _gestureActive = false;

    if (_overlayVisible) {
      _snapBack();
    } else {

      _pendingSnapBack = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        if (_overlayVisible) _dismissImmediately();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (n) {
          if (n is ScrollStartNotification || n is ScrollUpdateNotification) {
            _dismissImmediately();
          }
          return false; 
        },
        child: RawGestureDetector(
          behavior: HitTestBehavior.translucent,
          gestures: {
            SmartScaleRecognizer:
                GestureRecognizerFactoryWithHandlers<SmartScaleRecognizer>(
                  () => SmartScaleRecognizer(
                    debugOwner: this,
                    onDismissOverlay: _dismissOverlayIfVisible,
                  ),
                  (r) {
                    r.onStart = _onScaleStart;
                    r.onUpdate = _onScaleUpdate;
                    r.onEnd = _onScaleEnd;
                  },
                ),
          },
          child: RepaintBoundary(key: _repaintKey, child: widget.child),
        ),
      ),
    );
  }
}
