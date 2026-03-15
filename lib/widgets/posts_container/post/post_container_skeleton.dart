import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PostContainerSkeleton extends StatelessWidget {
  const PostContainerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade900,
                  highlightColor: Colors.grey.shade700,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade900,
                        highlightColor: Colors.grey.shade700,
                        child: Container(
                          height: 12,
                          width: 120,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade900,
                        highlightColor: Colors.grey.shade700,
                        child: Container(
                          height: 10,
                          width: 80,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade900,
            highlightColor: Colors.grey.shade700,
            child: Container(height: 320, color: Colors.black),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                for (var i = 0; i < 4; i++) ...[
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade900,
                    highlightColor: Colors.grey.shade700,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                const Spacer(),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade900,
                  highlightColor: Colors.grey.shade700,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
