import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';
import 'package:song_recommender_ai/utils/widgets/ai.widget.dart';
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
  ///[chatController] & [chatFocus] for user Input
  ///[scrollController] to animate the listview to the bottom.

  final chatController = TextEditingController();
  final chatFocus = FocusNode();
  ScrollController scrollController = ScrollController();
  Future<List<Message>?>? messages;

  final uid = '112sss';
  bool showProgressIndicator = true;

  ///We are fetching messages in the initState method from the firestore.
  @override
  void initState() {
    super.initState();
    final messagesVM = Provider.of<MessageViewModel>(context, listen: false);
    messagesVM.fetchMessages(widget.chatid, uid);
  }

  @override
  void dispose() {
    chatController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatModel>(context);
    // if (chat.isScroll) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     scrollToBottom();
    //     context.read<ChatModel>().setScroll(false);
    //   });
    // }
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      }
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
      showProgressIndicator = false;
    });

    ///Sidebar and appbar widgets are handled in the separate widget and called here.
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

      ///Consumer function from the provider package to load the messages list.
      body: Stack(
        children: [
          //chat
          Consumer<MessageViewModel>(builder: (context, value, child) {
            if (value.getmessages == null || value.getmessages!.isEmpty) {
              return showProgressIndicator
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Center(child: Text('No chats Started!'));
            } else {
              return Container(
                margin: const EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    Flexible(
                      flex: 6,
                      fit: FlexFit.loose,
                      child: ListView.builder(
                        controller: scrollController,
                        shrinkWrap: true,
                        itemCount: value.getmessages?.length,
                        itemBuilder: (context, index) {
                          final messageItem = value.getmessages?[index];
                          String key = 'aas';
                          Random num = Random();
                          if (index == (value.getmessages!.length.toInt())) {
                            return Container(
                              height: 150,
                            );
                          }
                          if (messageItem!.isSender) {
                            return UserMessage(
                              text: messageItem.prompt,
                            );
                          } else {
                            return AiMessage(
                              text: messageItem.prompt,
                              key: Key(key + num.nextInt(256).toString()),
                              shouldAnimate: messageItem.shouldAnimate,
                              scrollController: scrollController,
                            );
                          }
                        },
                      ),
                    ),
                    if (chat.isLoading) ...[
                      const Center(
                          child: SpinKitThreeBounce(
                        color: Color(0xff3c3c3c),
                      ))
                    ]
                  ],
                ),
              );
            }
          }),
          Positioned(
            bottom: 90,
            right: 30,
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_downward_outlined,
                  color: Color(0xff3c3c3c),
                ),
                onPressed: () {
                  scrollToBottom();
                }),
          ),
          /* FutureBuilder<List<Message>?>(
              future: context.read<MessageViewModel>().getmessages,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  if (kDebugMode) {
                    print(snapshot.error.toString());
                  }
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Start new chat!'));
                } else {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 6,
                          fit: FlexFit.loose,
                          child: ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              final messageItem = snapshot.data?[index];
                              String key = 'aas';
                              String num = Random(256).toString();
                              if (messageItem!.isSender) {
                                return UserMessage(
                                  text: messageItem.prompt,
                                );
                              } else {
                                return AiMessage(
                                    text: messageItem.prompt,
                                    key: Key(key + num),
                                    shouldAnimate: messageItem.shouldAnimate);
                              }
                            },
                          ),
                        ),
                        if (chat.isLoading) ...[
                          const Flexible(
                              fit: FlexFit.loose,
                              flex: 1,
                              child: Center(
                                  child: SpinKitThreeBounce(
                                color: Color(0xff3c3c3c),
                              )))
                        ]
                      ],
                    ),
                  );
                }
              }),
 */ //input
          UserInput(
            scrollController: scrollController,
            chatcontroller: chatController,
            chatFocus: chatFocus,
            chatId: widget.chatid,
          )
        ],
      ),
    );
  }

  void scrollToItem(int itemCount) {
    if (scrollController.hasClients) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(itemCount.toDouble());
      });
    }
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 10),
            curve: Curves.fastOutSlowIn);
      });
    }
  }
}
