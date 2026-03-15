import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userEight() {
  return UserModel(
    storyImage: "https://i.pinimg.com/736x/d9/b9/3e/d9b93e22c142c8125b8a79f89cc0c108.jpg",
    id: 8,
    storyWacthed: false,
timeStoryPosted: Duration(hours: 18),
    profileImage: "https://i.pinimg.com/736x/2f/ef/2d/2fef2dd6fe75a96a6e8f74eaafe271b2.jpg",
    username: "Nazeel",
    posts: [
      PostModel(
        id: 28,
        location: "Bangalore",
        image: ["https://i.pinimg.com/736x/7c/98/36/7c983668af1969800ebb2a5f04f0fb67.jpg", "https://i.pinimg.com/736x/86/e4/0f/86e40f2ffecd3fc9748a64d7e7ffd6bf.jpg"],
        caption:
            "Tried a new café today. The place had a calm vibe, soft music, and the smell of fresh coffee everywhere. Perfect place to sit, think, and just enjoy the moment.",
        hashTag: ["#cafediary", "#weekendvibes", "#coffeeaddict"],
        shareCount: 2300,
        duration: Duration(hours: 3),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4600,
        likeCount: 15200,
        repostCount: 3200,
      ),
     
    ],
  );
}