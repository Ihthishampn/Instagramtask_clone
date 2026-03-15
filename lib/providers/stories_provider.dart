import 'package:flutter/material.dart';

import 'package:instagram_task_clone/model/user_model.dart';
import 'package:instagram_task_clone/repositories/post_repository.dart';

class StoriesProvider extends ChangeNotifier {
  final PostRepository _repository;

  StoriesProvider(this._repository);

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<UserModel> _users = [];
  List<UserModel> get users => _users;


  void markWatchedAndMoveToEnd(int userIndex) {
    if (userIndex < 0 || userIndex >= _users.length) return;
    final user = _users[userIndex];
    if (!user.storyWacthed) {
      user.storyWacthed = true;
      _users.removeAt(userIndex);
      _users.add(user);
      notifyListeners();
    }
  }

  void markWatched(int userIndex) {
    if (userIndex < 0 || userIndex >= _users.length) return;
    final user = _users[userIndex];
    if (!user.storyWacthed) {
      user.storyWacthed = true;
      notifyListeners();
    }
  }

  void moveWatchedToEndAll() {
    final unwatched = <UserModel>[];
    final watched = <UserModel>[];
    for (final u in _users) {
      if (u.storyWacthed) {
        watched.add(u);
      } else {
        unwatched.add(u);
      }
    }
    _users = [...unwatched, ...watched];
    notifyListeners();
  }

  Future<void> loadStories() async {
    _isLoading = true;
    notifyListeners();

    try {
      _users = await _repository.fetchStories();
    } catch (_) {
      _users = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
