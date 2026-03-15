import 'package:flutter/material.dart';

class PostMoreSheet extends StatelessWidget {
  const PostMoreSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2C),
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _LargeAction(icon: Icons.bookmark_border, label: 'Save'),
                _LargeAction(icon: Icons.qr_code_scanner, label: 'QR code'),
              ],
            ),

            const SizedBox(height: 18),

            Column(
              children: [
                const PostMoreAction(
                  icon: Icons.star_border,
                  label: 'Add to favorites',
                ),
                const PostMoreAction(
                  icon: Icons.person_remove_alt_1_outlined,
                  label: 'Unfollow',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Divider(
                    color: const Color.fromARGB(255, 79, 79, 79),
                    thickness: 0.5,
                    height: 1,
                  ),
                ),
                const PostMoreAction(
                  icon: Icons.info_outline,
                  label: "Why you're seeing this post",
                ),
                const PostMoreAction(icon: Icons.hide_source, label: 'Hide'),
                const PostMoreAction(
                  icon: Icons.account_circle_outlined,
                  label: 'About this account',
                ),
                const PostMoreAction(
                  icon: Icons.report_gmailerrorred_outlined,
                  label: 'Report',
                  danger: true,
                ),
              ],
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class PostMoreAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool danger;

  const PostMoreAction({
    super.key,
    required this.icon,
    required this.label,
    this.danger = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = danger ? Colors.red : Colors.white;
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(label, style: TextStyle(color: color, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class _LargeAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _LargeAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFF3A3A3C),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
