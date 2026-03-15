import 'package:flutter/material.dart';
import 'package:instagram_task_clone/core/constants/image.dart';
import 'package:instagram_task_clone/core/constants/my_colors.dart';
import 'package:instagram_task_clone/widgets/app_bar/my_icon_button.dart';

class IgSliverAppBar extends StatelessWidget {
  const IgSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SliverAppBar(
      leading: MyIconButton(onpressed: () {}, icon: Icons.add),
      centerTitle: true,
      pinned: false,
      snap: false,
      floating: false,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            logoImage,
            color: MyColors.logo,
            width: (width * 0.35).clamp(100, 200),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.keyboard_arrow_down, size: 25, color: Colors.white),
        ],
      ),
      actions: [
        MyIconButton(onpressed: () {}, icon: Icons.favorite_border_outlined),
      ],
    );
  }
}
