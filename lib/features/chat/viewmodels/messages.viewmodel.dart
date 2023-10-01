import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/repositories/messages.repository.dart';

class MessageViewModel with ChangeNotifier {
  IMessagesRepository messagesRepository = MessagesRepository();
  List<Message>? messages = [];
  List<Message>? get getmessages => messages;

  Future<void> fetchMessages(String chatId, String uid) async {
    messages = await messagesRepository.fetchChatMsgs(uid, chatId);
    notifyListeners();
  }
}
