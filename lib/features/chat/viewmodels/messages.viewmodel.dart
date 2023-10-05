import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/repositories/messages.repository.dart';

class MessageViewModel with ChangeNotifier {
  IMessagesRepository messagesRepository = MessagesRepository();
  List<Message>? _messages;
  List<Message>? get getmessages => _messages;
  bool _isProgress = true;
  bool get isProgress => _isProgress;

  String _uid = '';
  String get uid => _uid;

  String _userCredit = '';
  String get userCredit => _userCredit;

  Future<void> fetchMessages(String chatId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    _uid = sp.getString('userId').toString();
    _userCredit = sp.getString('userCredits').toString();
    _messages = await messagesRepository.fetchChatMsgs(
        sp.getString('userId') ?? '111ss', chatId);
    Future.delayed(const Duration(milliseconds: 500), () {
      _isProgress = false;
      notifyListeners();
    });
    notifyListeners();
  }
}
