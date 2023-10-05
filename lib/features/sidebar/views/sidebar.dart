import 'dart:math';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/services/chats_database.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';
import 'package:song_recommender_ai/features/sidebar/models/sidebar.model.dart';
import 'package:song_recommender_ai/features/sidebar/repositories/sidebar.repository.dart';
import 'package:song_recommender_ai/features/sidebar/viewmodels/sidebar.viewmodel.dart';
import 'package:song_recommender_ai/utils/res/utils.dart';

import '../../authentication/viewmodels/auth.viewmodel.dart';

class AppDrawer extends StatefulWidget {
  final String uid;
  const AppDrawer({super.key, required this.uid});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  ISidebarRepository sidebarRepository = SidebarRepository();
  List<FooterItems>? sidebarFooters;
  ChatsDatabase? chatsDatabase;
  String chatId = '';
  @override
  void initState() {
    final sidebarchats = Provider.of<ChatProvider>(context, listen: false);
    sidebarchats.fetchChats(widget.uid);
    debugPrint(widget.uid);
    sidebarFooters = sidebarRepository.getSidebarFooter(widget.uid, context);
    chatsDatabase = ChatsDatabase(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return SafeArea(
      child: ModalProgressHUD(
        color: Colors.blue,
        inAsyncCall: Provider.of<AuthViewModel>(context).isLoading,
        child: Drawer(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 230,
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
                          Random num = Random();
                          final chatId = '${num.nextInt(2354)}chat';
                          // print(chatId);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(chatid: chatId),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () {
                          Scaffold.of(context).closeDrawer();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 25,
                        )),
                  ],
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
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline_rounded),
                        onPressed: () {
                          Utils.showConfirmationDialog(
                              context,
                              'Confirmation',
                              'Are you sure you want to delete this chat.',
                              'delete', () async {
                            final response = await chatsDatabase
                                ?.removeSingleChat(chat.chatId);
                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response.toString())));
                            context.read<ChatProvider>().fetchChats(widget.uid);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ChatPage()));
                          });
                        },
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
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
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
      ),
    );
  }
}
