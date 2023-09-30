import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/repositories/chat_ai.repository.dart';
import 'package:song_recommender_ai/utils/widgets/ai.widget.dart';
import 'package:song_recommender_ai/utils/widgets/user.widget.dart';

class ChatModel with ChangeNotifier {
  List<Widget> messages = [];
  List<Widget> get getmessages => messages;

  IOPENAIRepository iopenaiRepository = OAIRepository();

  Future<void> sendPrompt(Message message) async {
    addUserMessageWidget(message.prompt);
    Map<String, dynamic> response =
        await iopenaiRepository.sendMessage(message);
    print(response.toString());
    String text = response['choices'][0]['message']['content'].toString();
    messages.add(AiMessage(text: text));
    notifyListeners();
  }

  void addUserMessageWidget(String txt) {
    messages.add(UserMessage(
      text: txt,
    ));
    notifyListeners();
  }
}
