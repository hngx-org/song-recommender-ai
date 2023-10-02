import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/sidebar/models/sidebar.model.dart';
import 'package:song_recommender_ai/features/sidebar/repositories/sidebar.repository.dart';

class ChatProvider with ChangeNotifier {
  final ISidebarRepository sidebarRepository = SidebarRepository();
  List<Conversation> _chats = [];
  List<Conversation> get chats => _chats;

  Future<void> fetchChats(String uid) async {
    _chats = await sidebarRepository.getSidebarChatTiles(uid);
    notifyListeners();
  }
}
