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
