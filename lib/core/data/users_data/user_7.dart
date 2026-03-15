import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userSeven() {
  return UserModel(
    storyImage: "https://i.pinimg.com/736x/73/3c/25/733c25a7a5c0219ce925c49c498ea8a6.jpg",
    id: 7,
    storyWacthed: false,
timeStoryPosted: Duration(hours: 15),

    profileImage: "https://i.pinimg.com/736x/20/71/36/207136a883b3094c53a79b5f4ad5de96.jpg",
    username: "Abhinav",
    posts: [
      PostModel(
        id: 27,
        location: "Bangalore",
        image: ["https://i.pinimg.com/736x/5d/68/d2/5d68d213c16e109b9fcda0dab2d56935.jpg"],
        caption: "work day",
        hashTag: ["#office","Working"],
        shareCount: 2000,
        duration: Duration(hours: 1),
        isLiked: false,
        isReposted: false,
        isSaved: false,
           commentCount: 12500,
        likeCount: 8700,
        repostCount: 2100,
      ),
    ],
  );
}
