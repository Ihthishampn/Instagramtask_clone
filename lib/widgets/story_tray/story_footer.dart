import 'package:flutter/material.dart';

import 'story_constants.dart';
import '../../core/shared/ui_helpers.dart';

class StoryFooter extends StatelessWidget {
  final MediaQueryData mq;
  final VoidCallback? onSend;

  const StoryFooter({super.key, required this.mq, this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 22, 22, 23),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: actionBarHeight + mq.padding.bottom,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.65),
                        width: 1.0,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: const Text(
                      'Send message',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 26,
                ),
                const SizedBox(width: 12),

                const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),

                GestureDetector(
                  onTap: onSend,
                  child: buildSendIcon(angle: -0.7, size: 25),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
