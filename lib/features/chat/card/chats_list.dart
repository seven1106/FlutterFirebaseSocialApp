import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled/core/common/loader.dart';
import 'package:untitled/features/chat/card/sender_message_card.dart';
import '../controller/chat_controller.dart';
import 'my_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverId;
  const ChatList({super.key, required this.receiverId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(chatControllerProvider);
    return isLoading
        ? const Loader()
        : ref.watch(chatStream(widget.receiverId)).when(
              data: (chatList) {
                if (chatList.isEmpty) {
                  return const Center(
                    child: Text('No messages yet'),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    final message = chatList[index];
                    final isMyMessage =
                        message.senderId == FirebaseAuth.instance.currentUser!.uid;
                    if (!message.isRead &&
                        message.receiverId == FirebaseAuth.instance.currentUser!.uid) {
                      ref.read(chatControllerProvider.notifier).setChatMessageSeen(
                            widget.receiverId,
                            message.messageId,
                          );
                      ref.read(chatControllerProvider.notifier).updateCurrentUnreadMessagesCount(
                        widget.receiverId,
                      );
                    }
                    ref.read(chatControllerProvider.notifier).updateReceiverUnreadMessagesCount(
                      widget.receiverId,
                    );
                    return isMyMessage
                        ? MyMessageCard(
                            message: message.text,
                            date: formatDate(message.timeSent, [HH, ':', nn]),
                            type: message.type,
                          )
                        : SenderMessageCard(
                            message: message.text,
                            date: formatDate(message.timeSent, [HH, ':', nn]),
                            type: message.type,
                          );
                  },
                );
              },
              loading: () => const Loader(),
              error: (error, stack) => Center(
                child: Text('Error: $error'),
              ),
            );
  }
}
