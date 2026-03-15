import 'package:flutter/material.dart';

class PostCarouselProvider extends ChangeNotifier {
  final List<String> images;

  PostCarouselProvider(this.images);

  int _currentPage = 0;
  int get currentPage => _currentPage;

  void setPage(int page) {
    if (_currentPage == page) return;
    _currentPage = page;
    notifyListeners();
  }
}
