import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/utils/widgets/user_input.dart';
import 'package:song_recommender_ai/features/sidebar/views/sidebar.dart';
import 'package:song_recommender_ai/utils/res/utils.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = TextEditingController();
  final chatFocus = FocusNode();

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.setAppbar(Builder(builder: (BuildContext context) {
        return IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: const Icon(
            Icons.menu,
            size: 20,
          ),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      }), () {}),
      drawer: const AppDrawer(),
      body: Consumer<ChatModel>(builder: (context, model, child) {
        List<Widget> messages = model.getmessages;
        return Stack(
          children: [
            //chat
            Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: ListView(
                children: [
                  for (int i = 0; i < messages.length; i++) messages[i]
                ],
              ),
            ),
            //input
            UserInput(
              chatcontroller: chatController,
              chatFocus: chatFocus,
            )
          ],
        );
      }),
    );
  }
}
