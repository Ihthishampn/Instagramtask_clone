import 'package:flutter/material.dart';
import 'package:instagram_task_clone/widgets/navigation/nav_item.dart';


class InstagramNavBar extends StatelessWidget {
  const InstagramNavBar({super.key});

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
      top: false,
      child: Container(
        color: const Color.fromARGB(220, 12, 12, 12),
        child: SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavBarItem(
                icon: const Icon(
                  Icons.home_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                activeIcon: const Icon(
                  Icons.home,
                  color: Colors.white,
                  size: 26,
                ),
                index: 0,
              ),
              NavBarItem(
                icon: const Icon(
                  Icons.ondemand_video_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                activeIcon: const Icon(
                  Icons.video_collection,
                  color: Colors.white,
                  size: 26,
                ),
                index: 1,
              ),
              NavBarItem(
                icon: Transform.rotate(
                  angle: -0.6,
                  child: Transform.scale(
                    scale: 0.92,
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
                activeIcon: const Icon(
                  Icons.send_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                index: 2,
              ),
              NavBarItem(
                icon: const Icon(Icons.search, color: Colors.white, size: 26),
                activeIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 26,
                ),
                index: 3,
              ),
              NavBarItem(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 26,
                ),
                activeIcon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 26,
                ),
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
