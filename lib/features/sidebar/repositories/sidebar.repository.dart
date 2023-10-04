import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/services/chats_database.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';
import 'package:song_recommender_ai/features/sidebar/models/sidebar.model.dart';
import 'package:song_recommender_ai/features/sidebar/viewmodels/sidebar.viewmodel.dart';
import 'package:song_recommender_ai/utils/res/icons.dart';

abstract class ISidebarRepository {
  Future<List<Conversation>> getSidebarChatTiles(String uid);
  List<FooterItems> getSidebarFooter(String uid, BuildContext context);
}

class SidebarRepository extends ISidebarRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Conversation>> getSidebarChatTiles(String uid) async {
    final querysnapshot =
        await _firestore.collection('users').doc(uid).collection('chats').get();
    final chats = querysnapshot.docs.map((chat) {
      final chatId = chat.id.toString();
      final chatTitle = chat.data()['title'];
      return Conversation(title: chatTitle, chatId: chatId);
    }).toList();
    return chats;
  }

  @override
  List<FooterItems> getSidebarFooter(String uid, BuildContext context) {
    ChatsDatabase chatsDatabase = ChatsDatabase(uid: uid);
    return [
      FooterItems(
        title: 'Clear Conversations',
        icon: AppIcons.deleteIcon,
        onTap: () async {
          await chatsDatabase.removeAllChats();
          if (!context.mounted) return;
          context.read<ChatProvider>().fetchChats(uid);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const ChatPage()));
        },
      ),
      FooterItems(
        title: 'Subscribe',
        icon: Icons.paid_outlined,
        onTap: () {},
      ),
      FooterItems(
        title: 'FAQ & Updates',
        icon: Icons.question_answer_outlined,
        onTap: () {},
      ),
      FooterItems(
        title: 'Logout',
        icon: AppIcons.logoutIcon,
        onTap: () {},
      ),
    ];
  }
}
