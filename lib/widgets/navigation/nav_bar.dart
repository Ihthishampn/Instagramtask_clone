import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/navigation_provider.dart';

class InstagramNavBar extends StatelessWidget {
  const InstagramNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // use NavigationProvider in child items

    return BottomAppBar(
      color: Colors.black,
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavBarItem(
              icon: Icons.home_rounded,
              activeIcon: Icons.home,
              index: 0,
            ),
            _NavBarItem(
              icon: Icons.ondemand_video_rounded,
              activeIcon: Icons.video_collection,
              index: 1,
            ),
            // spacer for center FAB
            _NavBarItem(icon: Icons.send, activeIcon: Icons.favorite, index: 3),
            _NavBarItem(
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              index: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
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

    return IconButton(
      onPressed: () => nav.setIndex(index),
      icon: Icon(active ? activeIcon : icon, color: Colors.white),
    );
  }
}
