import 'dart:async';

import 'package:flutter/material.dart';
import 'image_size_cache.dart';

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

    
    final first = images.isNotEmpty ? images.first : null;
    if (first != null) {
      final s = ImageSizeCache.instance.get(first);
      if (s != null && s.width > 0 && s.height > 0) {
        final proposed = screenWidth * (s.height / s.width);
        _height = proposed.clamp(200.0, 2000.0);
        notifyListeners();
        return;
      }
    }

    _height = (screenWidth * 0.8).clamp(200.0, 500.0);
    notifyListeners();
  }


  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
