
import 'package:flutter/material.dart';
import 'package:instagram_task_clone/providers/navigation_provider.dart';
import 'package:provider/provider.dart';

class NavBarItem extends StatelessWidget {
  final Widget icon;
  final Widget activeIcon;
  final int index;
  const NavBarItem({super.key, 
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
