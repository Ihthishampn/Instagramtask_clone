import 'package:flutter/material.dart';

import 'package:instagram_task_clone/model/feed_post_model.dart';
import 'package:instagram_task_clone/repositories/post_repository.dart';

class FeedProvider extends ChangeNotifier {
  final PostRepository _repository;

  FeedProvider(this._repository);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<FeedPost> _feedPosts = [];
  List<FeedPost> get feedPosts => _feedPosts;

  final Map<int, int> _carouselPositions = {};
  Map<int, int> get carouselPositions => _carouselPositions;

  Future<void> loadFeed() async {
    _isLoading = true;
    notifyListeners();

    try {
      _feedPosts = await _repository.fetchFeedPosts();
      _carouselPositions.clear();
    } catch (_) {
      _feedPosts = [];
      _carouselPositions.clear();
    }

    _isLoading = false;
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

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> loadMorePosts() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    notifyListeners();

    try {
      final morePosts = await _repository
          .fetchFeedPosts();
      _feedPosts.addAll(morePosts);
    } catch (_) {
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  void toggleSave(int index) {
    if (index < 0 || index >= _feedPosts.length) return;
    final post = _feedPosts[index].post;
    post.isSaved = !post.isSaved;
    notifyListeners();
  }
}
