import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/repositories/chat_ai.repository.dart';

class ChatModel with ChangeNotifier {
  List<Message> messages = [];
  List<Message> get getmessages => messages;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isScroll = false;
  bool get isScroll => _isScroll;

  void setScroll(bool scroll) {
    _isScroll = scroll;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  IOPENAIRepository iopenaiRepository = OAIRepository();
  Future<void> sendPrompt(
      Message message, BuildContext context, String chatId) async {
    if (!context.mounted) return;
    String response =
        await iopenaiRepository.sendMessage(message, context, chatId);

    if (kDebugMode) {
      print(response.toString());
    }
    notifyListeners();
  }
}
