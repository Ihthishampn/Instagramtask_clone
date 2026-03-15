import 'package:flutter/material.dart';

import 'package:instagram_task_clone/model/feed_post_model.dart';
import 'package:instagram_task_clone/repositories/post_repository.dart';

class FeedProvider extends ChangeNotifier {
  final PostRepository _repository;
  static const int _pageSize = 5;

  FeedProvider(this._repository);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMore = true;
  bool get hasMore => _hasMore;

  List<FeedPost> _allPosts = [];
  List<FeedPost> _feedPosts = [];
  List<FeedPost> get feedPosts => _feedPosts;

  final Map<int, int> _carouselPositions = {};
  Map<int, int> get carouselPositions => _carouselPositions;

  Future<void> loadFeed() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allPosts = await _repository.fetchFeedPosts();
      _feedPosts = _allPosts.take(_pageSize).toList();
      _carouselPositions.clear();
      _hasMore = _allPosts.length > _pageSize;
    } catch (_) {
      _allPosts = [];
      _feedPosts = [];
      _carouselPositions.clear();
      _hasMore = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMorePosts() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    try {
      final currentCount = _feedPosts.length;
      final newPosts = _allPosts.skip(currentCount).take(_pageSize).toList();
      _feedPosts.addAll(newPosts);
      _hasMore = _feedPosts.length < _allPosts.length;
    } catch (_) {
      _hasMore = false;
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  int getCarouselPosition(int postIndex) {
    return _carouselPositions[postIndex] ?? 0;
  }

  void setCarouselPosition(int postIndex, int page) {
    if (_carouselPositions[postIndex] != page) {
      _carouselPositions[postIndex] = page;
      notifyListeners();
    }
  }

  void toggleLike(int index) {
    if (index < 0 || index >= _feedPosts.length) return;
    final post = _feedPosts[index].post;
    post.isLiked = !post.isLiked;
    notifyListeners();
  }

  void likePost(int index) {
    if (index < 0 || index >= _feedPosts.length) return;
    final post = _feedPosts[index].post;
    if (!post.isLiked) {
      post.isLiked = true;
      notifyListeners();
    }
  }

  void toggleSave(int index) {
    if (index < 0 || index >= _feedPosts.length) return;
    final post = _feedPosts[index].post;
    post.isSaved = !post.isSaved;
    notifyListeners();
  }
}
