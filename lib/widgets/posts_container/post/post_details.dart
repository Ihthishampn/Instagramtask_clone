import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_task_clone/model/feed_post_model.dart';
import 'package:instagram_task_clone/core/shared/ui_helpers.dart';

class PostDetails extends StatefulWidget {
  final FeedPost post;

  const PostDetails({super.key, required this.post});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  bool _isExpanded = false;

  String _timeAgo(Duration duration) {
    final s = formatRelativeTime(duration);
    return s == 'now' ? 'Just now' : '$s ago';
  }

  @override
  Widget build(BuildContext context) {
    final postData = widget.post.post;

    final fullCaption = postData.caption;
    final needsTruncation =
        fullCaption.length > 80 || fullCaption.contains('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: !_isExpanded && needsTruncation
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13.5,
                          ),
                          children: [
                            TextSpan(
                              text: "${widget.post.user.username} ",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(text: fullCaption),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _isExpanded = true),
                      child: const Text(
                        " more",
                        style: TextStyle(color: Colors.grey, fontSize: 13.5),
                      ),
                    ),
                  ],
                )
              : RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 13.5),
                    children: [
                      TextSpan(
                        text: "${widget.post.user.username} ",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: fullCaption),
                      if (needsTruncation) ...[
                        TextSpan(text: " "),
                        TextSpan(
                          text: "less",
                          style: const TextStyle(color: Colors.grey),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => setState(() => _isExpanded = false),
                        ),
                      ],
                    ],
                  ),
                ),
        ),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            postData.hashTag.join(' '),
            style: const TextStyle(color: Color(0xFF3897F0), fontSize: 13),
          ),
        ),
        const SizedBox(height: 3),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Text(
                _timeAgo(postData.duration),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              const SizedBox(width: 6),
              Text("•", style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(width: 6),
              Text(
                "See translation",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
