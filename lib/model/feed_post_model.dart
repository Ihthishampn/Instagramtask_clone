import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

class FeedPost {
  final UserModel user;
  final PostModel post;

  FeedPost({required this.user, required this.post});
}
