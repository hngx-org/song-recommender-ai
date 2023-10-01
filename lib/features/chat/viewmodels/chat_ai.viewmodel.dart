import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/repositories/chat_ai.repository.dart';

class ChatModel with ChangeNotifier {
  List<Message> messages = [];
  List<Message> get getmessages => messages;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  IOPENAIRepository iopenaiRepository = OAIRepository();
  Future<void> sendPrompt(
      Message message, BuildContext context, String chatId) async {
    addUserMessageWidget(message.prompt);
    Map<String, dynamic> response =
        await iopenaiRepository.sendMessage(message, context, chatId);

    if (kDebugMode) {
      print(response.toString());
    }
    // String text = response['choices'][0]['message']['content'].toString();
    // messages.add(Message(isSender: false, prompt: text));
    notifyListeners();
  }

  void addUserMessageWidget(String txt) {
    // messages.add(Message(isSender: true, prompt: txt));
    notifyListeners();
  }
}
