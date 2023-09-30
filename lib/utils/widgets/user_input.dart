import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';

class UserInput extends StatelessWidget {
  final TextEditingController chatcontroller;
  final FocusNode chatFocus;
  const UserInput({
    Key? key,
    required this.chatcontroller,
    required this.chatFocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: TextFormField(
          // autofocus: true,
          onFieldSubmitted: (e) {
            final msg = Message(isSender: true, prompt: e);
            if (chatcontroller.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter some message.')));
            } else {
              context.read<ChatModel>().sendPrompt(msg);
              chatFocus.unfocus();
              chatcontroller.clear();
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
