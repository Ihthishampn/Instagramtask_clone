import 'dart:async';

import 'package:instagram_task_clone/core/data/users/users.dart';
import 'package:instagram_task_clone/model/feed_post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

class PostRepository {
  Future<List<UserModel>> fetchStories() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return users;
  }

  Future<List<FeedPost>> fetchFeedPosts() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    final all = <FeedPost>[];
    for (final u in users) {
      for (final p in u.posts) {
        all.add(FeedPost(user: u, post: p));
      }
    }
    return all;
  }
}
