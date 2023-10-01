import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';
import 'package:song_recommender_ai/features/sidebar/models/sidebar.model.dart';
import 'package:song_recommender_ai/features/sidebar/repositories/sidebar.repository.dart';
import 'package:song_recommender_ai/features/sidebar/viewmodels/sidebar.viewmodel.dart';

class AppDrawer extends StatefulWidget {
  final String uid;
  const AppDrawer({super.key, required this.uid});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  ISidebarRepository sidebarRepository = SidebarRepository();
  List<FooterItems>? sidebarFooters;
  String chatId = '';
  @override
  void initState() {
    final sidebarchats = Provider.of<ChatProvider>(context, listen: false);
    sidebarchats.fetchChats(widget.uid);
    sidebarFooters = sidebarRepository.getSidebarFooter(widget.uid, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return SafeArea(
      child: Drawer(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  style: ListTileStyle.drawer,
                  leading: const Icon(
                    Icons.add,
                    size: 25,
                  ),
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(15)),
                  title: const Text('Start new chat'),
                  onTap: () {
                    Random num = Random(256);
                    chatId = num.toString();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatPage(chatid: chatId),
                      ),
                    );
                  },
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: chatProvider.chats.length,
                itemBuilder: (context, index) {
                  final chat = chatProvider.chats[index];
                  return ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    leading: const Icon(
                      Icons.chat_bubble_outline,
                      size: 20,
                    ),
                    style: ListTileStyle.drawer,
                    title: Text(chat.title.toString()),
                    onTap: () {
                      chatId = chat.chatId;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ChatPage(
                                    chatid: chatId,
                                  )));
                    },
                  );
                },
              ),
            ],
          ),
          /* FutureBuilder<List<Conversation>>(
              future: sidebarRepo.getSidebarTile(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      return ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: List.generate(
                            snapshot.data!.length,
                            (index) => ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  leading: const Icon(
                                    Icons.chat_bubble_outline,
                                    size: 20,
                                  ),
                                  style: ListTileStyle.drawer,
                                  title: Text(
                                      snapshot.data![index].title.toString()),
                                  onTap: () {},
                                )),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'An ${snapshot.error} occurred',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      );
                    }
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }), */
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.4,
            child: ListView(
              shrinkWrap: true,
              children: List<Widget>.generate(
                sidebarFooters!.length,
                (index) => ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  leading: Icon(
                    sidebarFooters?[index].icon,
                    color: Colors.black87,
                    size: 25,
                  ),
                  onTap: sidebarFooters?[index].onTap,
                  title: Text(sidebarFooters![index].title.toString()),
                  style: ListTileStyle.drawer,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
