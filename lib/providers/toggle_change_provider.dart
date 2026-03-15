import 'package:flutter/material.dart';

class ToggleChangeProvider extends ChangeNotifier {
  bool _isHeartVisible = false;
  bool get isHeartVisible => _isHeartVisible;

  AnimationController? _heartAnimationController;
  bool _listenerAttached = false;

  void setAnimationController(AnimationController controller) {
    _heartAnimationController = controller;
  }

  void showHeart() {
    if (_heartAnimationController == null) return;

    _isHeartVisible = true;
    notifyListeners();

    _heartAnimationController!.forward(from: 0.0);

    if (!_listenerAttached) {
      _listenerAttached = true;
      _heartAnimationController!.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isHeartVisible = false;
          notifyListeners();
        }
      });
    }
  }

  bool handleDoubleTap() {
    showHeart();
    return true;
  }

  @override
  void dispose() {
    //  AnimationController 
    super.dispose();
  }
}
