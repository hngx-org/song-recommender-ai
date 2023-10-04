import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';

class UserInput extends StatelessWidget {
  final TextEditingController chatcontroller;
  final FocusNode chatFocus;
  final String chatId;
  final ScrollController scrollController;
  const UserInput({
    Key? key,
    required this.chatcontroller,
    required this.chatFocus,
    required this.chatId,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          onFieldSubmitted: (e) async {
            final msg =
                Message(isSender: true, prompt: e, shouldAnimate: false);
            if (chatcontroller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter some message.')));
            } else {
              if (!context.mounted) return;
              await context.read<ChatModel>().sendPrompt(msg, context, chatId);
              chatFocus.unfocus();
              chatcontroller.clear();
              if (scrollController.hasClients) {
                scrollController.animateTo(
                    scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.fastLinearToSlowEaseIn);
              }
            }
          },
          controller: chatcontroller,
          style: const TextStyle(
            color: Color(0xff667085),
          ),
          decoration: InputDecoration(
            hintText: 'Write your favorite song...',
            hintStyle: const TextStyle(color: Color(0xffc4c4c4)),
            focusColor: Colors.white,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: const Icon(
              Icons.send,
              color: Color(0xffc4c4c4),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff2D2B2E)),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xffe3e3e3)),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
