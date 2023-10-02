import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';
import 'package:song_recommender_ai/utils/widgets/ai.widget.dart';
import 'package:song_recommender_ai/utils/widgets/loading_widget.dart';
import 'package:song_recommender_ai/utils/widgets/user.widget.dart';
import 'package:song_recommender_ai/utils/widgets/user_input.dart';
import 'package:song_recommender_ai/features/sidebar/views/sidebar.dart';
import 'package:song_recommender_ai/utils/res/utils.dart';

class ChatPage extends StatefulWidget {
  final String chatid;
  const ChatPage({super.key, this.chatid = '1'});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatController = TextEditingController();
  final chatFocus = FocusNode();
  final uid = '112sss';
  @override
  void initState() {
    final messagesVM = Provider.of<MessageViewModel>(context, listen: false);
    messagesVM.fetchMessages(widget.chatid, uid);
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatModel>(context);
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
      drawer: const AppDrawer(
        uid: '112sss',
      ),
      body: Consumer<MessageViewModel>(builder: (context, model, child) {
        List<Message>? messages = model.getmessages;
        final itemCount = messages!.length.toInt();
        print('Messages:${messages.length} items: $itemCount');
        return Stack(
          children: [
            //chat
            Container(
              margin: const EdgeInsets.only(bottom: 80),
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  final messageItem = messages[index];
                  String key = 'aas';
                  String num = Random(256).toString();
                  // if (index < messages.length) {
                  if (messageItem.isSender) {
                    return UserMessage(
                      text: messageItem.prompt,
                    );
                  } else {
                    return AiMessage(
                        text: messageItem.prompt,
                        key: Key(key + num),
                        shouldAnimate: messageItem.shouldAnimate);
                  }
                  // } else {
                  //   return const TypewriterLoading();
                  // }
                },
              ),
            ),
            //input
            UserInput(
              chatcontroller: chatController,
              chatFocus: chatFocus,
              chatId: widget.chatid,
            )
          ],
        );
      }),
    );
  }
}
