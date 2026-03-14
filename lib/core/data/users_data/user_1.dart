import 'package:instagram_task_clone/model/post_model.dart';
import 'package:instagram_task_clone/model/user_model.dart';

UserModel userOne() {
  return UserModel(
    id: 1,

    profileImage:
        "https://i.pinimg.com/736x/60/a2/25/60a22527dab0ba99d3e79595b8255125.jpg",
    username: "Amii",
    posts: [
      PostModel(
        id: 1,
        location: "Kondotty",
        image: [
          "https://i.pinimg.com/736x/6b/3b/b5/6b3bb5aa7e719e7c0664db73bca209da.jpg",

          "https://i.pinimg.com/736x/29/d7/86/29d78686ce8eb9fe3956ffe1d81210ba.jpg",
        ],
        caption: "Finally got my GT.A dream machine that excites every drive.Speed and style perfectly combined.Every ride feels like a thrilling race.Living the dream, one ride at a time.",
        hashTag: ["#GT", "GT650", "Bike"],
        shareCount: 1200,
        duration: Duration(hours: 3),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 2000,
        likeCount: 20000,
        repostCount: 1000,
      ),
      PostModel(
        id: 2,
        location: "Kochi",
        image: [
          "https://i.pinimg.com/736x/78/f5/a4/78f5a4fab89a27928d0b0503dfa851a3.jpg",
        ],
        caption:
            "Writing code, fixing bugs, and learning something new every day.The process is hard, but the result is always worth it.",
        hashTag: ["#programming", "#developer", "#coding"],
        shareCount: 3000,
        duration: Duration(hours: 5),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 4000,
        likeCount: 23000,
        repostCount: 9000,
      ),
      PostModel(
        id: 3,
        location: "Calicut",
        image: [
          "https://i.pinimg.com/736x/ae/23/ad/ae23adfb3c1d9c1863df82f3ea6bc512.jpg",
        ],
        caption:
            "Coffee first, everything else later. A perfect cup and a calm moment at the café.",
        hashTag: ["#coffee", "#coffeetime"],
        shareCount: 7,
        duration: Duration(hours: 7),
        isLiked: false,
        isReposted: false,
        isSaved: false,
        commentCount: 3000,
        likeCount: 15000,
        repostCount: 1500,
      ),
      PostModel(
        id: 4,
        location: "Malappuram",
        image: [
          "https://i.pinimg.com/736x/20/bb/12/20bb1206ce6aa7329f5fa8d3e03db751.jpg",
          "https://i.pinimg.com/736x/62/23/10/622310fc2d87ce84607e14a749314444.jpg",
          "https://i.pinimg.com/736x/82/c7/45/82c745defcd6502f92adc8cfdcc349f0.jpg",
        ],
        caption:
            "Fresh air, calm mind, and a peaceful start to the day. Morning walks make everything feel better.",
        hashTag: ["#freshmorning🌅🚶‍♂️", "#healthyhabit"],
        shareCount: 5,
        duration: Duration(hours: 9),
        isLiked: true,
        isReposted: false,
        isSaved: false,
        commentCount: 2000,
        likeCount: 3500,
        repostCount: 1255,
      ),
    ],
  );
}
