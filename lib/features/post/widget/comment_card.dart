import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../model/comment_model.dart';

class CommentCard extends ConsumerWidget {
  final Comment comment;
  const CommentCard({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    comment.profilePic,
                  ),
                  radius: 18,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'u/${comment.username}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(comment.text)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward),
                  // color: post.upvotes.contains(user.uid)
                  //     ? Colors.green
                  //     : null,
                ),
                // Text(
                //   (post.upvotes.length-post.downvotes.length).toString(),
                //   style: currentTheme.textTheme.bodyText2!
                //       .copyWith(
                //     color: currentTheme
                //         .textTheme.bodyText2!.color!
                //         .withOpacity(0.8),
                //   ),
                // ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_downward),
                  // color: post.downvotes.contains(user.uid)
                  //     ? Colors.red
                  //     : null,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.reply),
                ),
                const Text('Reply'),
              ],
            ),
            const Divider()

          ],
        ),
    );
  }
}
