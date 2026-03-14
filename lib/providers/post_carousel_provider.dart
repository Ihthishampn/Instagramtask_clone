import 'dart:async';

import 'package:flutter/material.dart';

class PostCarouselProvider extends ChangeNotifier {
  final List<String> images;

  PostCarouselProvider(this.images);

  int _currentPage = 0;
  int get currentPage => _currentPage;

  double _height = 0;
  double get height => _height;

  double? _lastScreenWidth;

  bool _isDisposed = false;

  bool get hasComputedSize => _height > 0;

  void setPage(int page) {
    if (_isDisposed || _currentPage == page) return;
    _currentPage = page;
    notifyListeners();
  }

  Future<void> ensureSizeFor(double screenWidth) async {
    if (_isDisposed || (_lastScreenWidth == screenWidth && hasComputedSize)) {
      return;
    }
    _lastScreenWidth = screenWidth;

    if (images.isEmpty) {
      if (_isDisposed) return;
      _height = screenWidth;
      notifyListeners();
      return;
    }

    if (_isDisposed) return;

    // Use a stable, conservative estimate for carousel height and avoid
    // re-calculating/resizing later — dynamic resizing while the feed is
    // being scrolled can cause layout jumps and snapping behavior.
    _height = (screenWidth * 0.8).clamp(200.0, 500.0);
    notifyListeners();
  }

  // _loadActualSizes intentionally retained but disabled: resolving image
  // sizes and updating carousel heights after initial layout can cause
  // mid-scroll relayouts which make the feed jump. Keep the conservative
  // initial height estimate instead.

  // Image size resolving is disabled to keep carousel height stable.

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
