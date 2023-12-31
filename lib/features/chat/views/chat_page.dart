import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';
import 'package:song_recommender_ai/utils/res/colors.dart';
import 'package:song_recommender_ai/utils/widgets/ai.widget.dart';
import 'package:song_recommender_ai/utils/widgets/filter_button.dart.dart';
import 'package:song_recommender_ai/utils/widgets/subscription_warning_widget.dart';
import 'package:song_recommender_ai/utils/widgets/user.widget.dart';
import 'package:song_recommender_ai/utils/widgets/user_input.dart';
import 'package:song_recommender_ai/features/sidebar/views/sidebar.dart';
import 'package:song_recommender_ai/utils/res/utils.dart';

class ChatPage extends StatefulWidget {
  final String chatid;
  final String? uid;
  const ChatPage({super.key, this.chatid = '11ssaa', this.uid});

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
  bool showProgressIndicator = true;

  Random randomNum = Random();

  ///We are fetching messages in the initState method from the firestore.
  @override
  void initState() {
    super.initState();
    final messagesVM = Provider.of<MessageViewModel>(context, listen: false);
    messagesVM.fetchMessages(widget.chatid);
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        showProgressIndicator = false;
      });
    });
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
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      }
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
      drawer: AppDrawer(
        uid: Provider.of<MessageViewModel>(context).uid,
      ),

      ///Consumer function from the provider package to load the messages list.
      body: Stack(
        children: [
          //chat
          Consumer<MessageViewModel>(builder: (context, value, child) {
            if (value.userCredit == '0') {
              debugPrint('userCredit: ${value.userCredit}');
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: SubscribeWarning(),
              );
            }
            if (value.getmessages == null || value.getmessages!.isEmpty) {
              return (chat.isLoading)
                  ? const Center(
                      child: SpinKitThreeBounce(
                      color: AppColors.userWidgetColor,
                      size: 50,
                    ))
                  : value.isProgress
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              FilterButtonDart(
                                  onTap: () async {
                                    chat.setLoading(true);
                                    if (!context.mounted) return;
                                    final msg = Message(
                                        isSender: true,
                                        prompt: 'Fly me to the moon!',
                                        shouldAnimate: false);
                                    await context.read<ChatModel>().sendPrompt(
                                        msg, context, widget.chatid);
                                    chatFocus.unfocus();
                                    if (scrollController.hasClients) {
                                      scrollController.animateTo(
                                          scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 10),
                                          curve: Curves.fastLinearToSlowEaseIn);
                                    }
                                  },
                                  content: 'Fly me to the moon!',
                                  leadingIcon: Icons.library_music),
                              const SizedBox(
                                height: 10,
                              ),
                              FilterButtonDart(
                                  onTap: () async {
                                    chat.setLoading(true);
                                    if (!context.mounted) return;
                                    final msg = Message(
                                        isSender: true,
                                        prompt: 'Al-Green',
                                        shouldAnimate: false);
                                    await context.read<ChatModel>().sendPrompt(
                                        msg, context, widget.chatid);
                                    chatFocus.unfocus();
                                    if (scrollController.hasClients) {
                                      scrollController.animateTo(
                                          scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 10),
                                          curve: Curves.fastLinearToSlowEaseIn);
                                    }
                                  },
                                  content: 'Al-Green',
                                  leadingIcon: Icons.music_note),
                              const SizedBox(
                                height: 10,
                              ),
                              FilterButtonDart(
                                  onTap: () async {
                                    if (!context.mounted) return;
                                    final msg = Message(
                                        isSender: true,
                                        prompt: 'Melancholic',
                                        shouldAnimate: false);
                                    await context.read<ChatModel>().sendPrompt(
                                        msg, context, widget.chatid);
                                    chatFocus.unfocus();
                                    if (scrollController.hasClients) {
                                      scrollController.animateTo(
                                          scrollController
                                              .position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 10),
                                          curve: Curves.fastLinearToSlowEaseIn);
                                    }
                                  },
                                  content: 'Melancholic',
                                  leadingIcon: Icons.mood_outlined)
                            ],
                          ),
                        );
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

  void showLoading() {
    const SpinKitThreeBounce(
      color: AppColors.userWidgetColor,
      duration: Duration(seconds: 600),
    );
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
