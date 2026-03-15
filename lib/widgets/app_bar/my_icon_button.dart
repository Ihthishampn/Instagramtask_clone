import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final VoidCallback onpressed;
  final IconData icon;
  const MyIconButton({super.key, required this.onpressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 7,
      onPressed: onpressed,
      color: Colors.white,
      icon: Icon(icon, size: 26),
    );
  }
}
