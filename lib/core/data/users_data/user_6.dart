import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userSix() {
  return UserModel(
    id: 6,
    profileImage: "https://i.pinimg.com/736x/ba/81/ba/ba81ba02ed79d14de61a248c34ab5e32.jpg",
    username: "Yaseen",
    posts: [
      PostModel(
        id: 25,
        location: "Malappuram",
        image: [ "https://i.pinimg.com/736x/21/d0/db/21d0db96938efc71589be35a2886e4ba.jpg"],
        caption:
            "Calm evening after a long day. The sky slowly changing colors and the cool breeze make the moment feel peaceful and quiet.",
        hashTag: ["#eveningvibes", "#calmmoment", "#relaxmode"],
        shareCount: 1700,
        duration: Duration(hours: 2),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4200,
        likeCount: 13200,
        repostCount: 2500,
      ),
      PostModel(
        id: 26,
        location: "Kochi",
        image: ["https://i.pinimg.com/736x/f9/a0/3c/f9a03ca9088828c52667d08c822d9ca6.jpg"],
        caption:
            "A smooth ride through the city streets at night. Lights everywhere, cool wind, and the road ahead.",
        hashTag: ["#cityride", "#nightdrive", "#urbanlife"],
        shareCount: 2100,
        duration: Duration(hours: 5),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 4800,
        likeCount: 15800,
        repostCount: 3100,
      ),
    ],
  );
}