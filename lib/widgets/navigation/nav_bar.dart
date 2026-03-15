import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/navigation_provider.dart';

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
              _NavBarItem(
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
              _NavBarItem(
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
              _NavBarItem(
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
              _NavBarItem(
                icon: const Icon(Icons.search, color: Colors.white, size: 26),
                activeIcon: const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 26,
                ),
                index: 3,
              ),
              _NavBarItem(
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

class _NavBarItem extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final int index;
  const _NavBarItem({
    required this.icon,
    required this.activeIcon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationProvider>();
    final current = context.watch<NavigationProvider>().currentIndex;
    final active = current == index;

    final Widget toShow = active ? activeIcon : icon;

    return IconButton(
      onPressed: () => nav.setIndex(index),
      icon: toShow,
      splashRadius: 20,
      constraints: const BoxConstraints(minWidth: 44, minHeight: 40),
    );
  }
}
