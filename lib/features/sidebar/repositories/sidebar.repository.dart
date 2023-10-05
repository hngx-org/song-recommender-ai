import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_recommender_ai/features/authentication/viewmodels/auth.viewmodel.dart';
import 'package:song_recommender_ai/features/authentication/views/login_page.dart';
import 'package:song_recommender_ai/features/chat/services/chats_database.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';
import 'package:song_recommender_ai/features/sidebar/models/sidebar.model.dart';
import 'package:song_recommender_ai/features/sidebar/viewmodels/sidebar.viewmodel.dart';
import 'package:song_recommender_ai/utils/res/icons.dart';
import 'package:song_recommender_ai/utils/res/utils.dart';

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
          await Utils.showConfirmationDialog(context, 'Confirmation',
              'Are you sure you want to delete all chats.', 'delete', () async {
            Provider.of<AuthViewModel>(context, listen: false).setLoading(true);
            final response = await chatsDatabase.removeAllChats();

            if (!context.mounted) return;
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(response.toString())));

            context.read<ChatProvider>().fetchChats(uid);
            Provider.of<AuthViewModel>(context, listen: false)
                .setLoading(false);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const ChatPage()));
          });
        },
      ),
      FooterItems(
        title: 'Subscribe',
        icon: Icons.paid_outlined,
        onTap: () {
          Navigator.pushNamed(context, '/payment');
        },
      ),
      FooterItems(
        title: 'FAQ & Updates',
        icon: Icons.question_answer_outlined,
        onTap: () {
          Navigator.pushNamed(context, '/faq');
        },
      ),
      FooterItems(
        title: 'Logout',
        icon: AppIcons.logoutIcon,
        onTap: () async {
          await Utils.showConfirmationDialog(
              context, 'Logout', 'Are you sure you want to logout.', 'logout',
              () async {
            Provider.of<AuthViewModel>(context, listen: false).setLoading(true);
            SharedPreferences sp = await SharedPreferences.getInstance();
            final authUser = Authentication();
            final email = sp.getString('userEmail');
            final response = await authUser.logout(email.toString());
            final msg = response['message'].toString();
            debugPrint(
                'response: ${response.toString()} ${response['message']}');
            if (!context.mounted) return;
            if (msg == 'success') {
              Provider.of<AuthViewModel>(context, listen: false)
                  .setLoading(false);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const AuthLogin()));
            } else {
              Provider.of<AuthViewModel>(context, listen: false)
                  .setLoading(false);
            }
          });
        },
      ),
    ];
  }
}
