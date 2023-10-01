import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/models/message.model.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:http/http.dart' as http;
import 'package:song_recommender_ai/features/chat/services/chats_database.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';
import 'package:song_recommender_ai/utils/constants.dart';

abstract class IOPENAIRepository {
  Future<Map<String, dynamic>> sendMessage(
      Message message, BuildContext context, String chatId);
}

class OAIRepository extends IOPENAIRepository {
  static var client = http.Client();

  ChatsDatabase chatsDatabase = ChatsDatabase(uid: '112sss');
  @override
  Future<Map<String, dynamic>> sendMessage(
      Message message, BuildContext context, String chatId) async {
    context.read<ChatModel>().setLoading(true);
    try {
      List<Map<String, String>> messageList = [];

      final propmt =
          '''I want you to act as a DJ. You will create a playlist of 10-20 songs (sometimes 10 and sometimes 20) similar to the following text either it is a song/keyword/lyrics/a short prose.
           You must add the title, description and songs with artist names to the answer. No song or artist should be
            repeated and do not add any anything apart from playlist, descriptiona and title : "${message.prompt}"''';

      var headers = {
        'Authorization': 'Bearer ${Url.oaiToken}',
        'Content-Type': 'application/json'
      };

      final messageSystem = MessageModel(
          role: 'system', content: 'You are a Music Recommendation Asistant.');

      messageList.add(messageSystem.toMap());

      final messageUser = messageSystem.copyWith(role: 'user', content: propmt);
      messageList.add(messageUser.toMap());

      chatsDatabase.saveChat(message.prompt.toString(), chatId,
          message.prompt.toString(), 'user', false);

      var request =
          http.Request('POST', Uri.parse('${Url.endpoint}completions'));

      if (kDebugMode) {
        print(messageList.toString());
      }

      request.body = json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': messageList,
        'temperature': 0,
        'max_tokens': 600
      });

      context.read<MessageViewModel>().fetchMessages(chatId, '112sss');
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();

        if (kDebugMode) {
          print(jsonDecode(data));
        }

        var responseData = jsonDecode(data);

        final msgResponse =
            responseData['choices'][0]['message']['content'].toString();

        final messageAssistant =
            messageUser.copyWith(role: 'assistant', content: msgResponse);

        messageList.add(messageAssistant.toMap());
        chatsDatabase.saveChat(
            message.prompt.toString(), chatId, msgResponse, 'assist', true);
        if (!context.mounted) {
          return {};
        }
        context.read<ChatModel>().setLoading(false);
        context.read<MessageViewModel>().fetchMessages(chatId, '112sss');

        return responseData;
      } else {
        return {'status': false, 'message': 'some error occurred'};
      }
    } catch (e) {
      return {'status': false, 'message': 'some error occurred $e'};
    }
  }
}
