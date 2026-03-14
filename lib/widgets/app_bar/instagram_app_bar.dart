import 'package:flutter/material.dart';
import 'package:instagram_task_clone/core/constants/image.dart';
import 'package:instagram_task_clone/core/constants/my_colors.dart';
import 'package:instagram_task_clone/widgets/app_bar/my_icon_button.dart';

class InstagramAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double width;

  const InstagramAppBar({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // plus
      leading: MyIconButton(onpressed: () {}, icon: Icons.add),
      centerTitle: true,
      title: Image.asset(
        logoImage,
        color: MyColors.logo,
        width: (width * 0.35).clamp(100, 200),
      ),
      actions: [
        // fav
        MyIconButton(onpressed: () {}, icon: Icons.favorite_border_outlined),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
