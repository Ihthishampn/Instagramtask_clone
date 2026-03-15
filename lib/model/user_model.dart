import 'package:instagram_task_clone/model/post_model.dart';

class UserModel {
  final int id;
  final String profileImage;
  final String username;
  final List<PostModel> posts;
  final String storyImage;
  bool storyWacthed;
  final Duration timeStoryPosted;

  UserModel({
    required this.storyWacthed,
    required this.id,
    required this.username,
    required this.posts,
    required this.profileImage,
    required this.storyImage, required this.timeStoryPosted,
  });
}
