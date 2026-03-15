import 'package:flutter/foundation.dart';

class StoryViewerProvider extends ChangeNotifier {
  int _currentIndex;

  StoryViewerProvider(this._currentIndex);

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int idx) {
    if (_currentIndex == idx) return;
    _currentIndex = idx;
    notifyListeners();
  }
}
