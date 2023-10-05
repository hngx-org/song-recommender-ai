import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hng_authentication/widgets/widget.dart';
import 'package:hngx_openai/repository/openai_repository.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';
import 'package:song_recommender_ai/features/chat/services/chats_database.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';

abstract class IOPENAIRepository {
  Future<String> sendMessage(
      Message message, BuildContext context, String chatId);
}

class OAIRepository extends IOPENAIRepository {
  static var client = http.Client();
  @override
  Future<String> sendMessage(
      Message message, BuildContext context, String chatId) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    ChatsDatabase chatsDatabase = ChatsDatabase(uid: sp.getString('userId'));

    chatsDatabase.saveChat(message.prompt.toString(), chatId,
        message.prompt.toString(), 'user', false);
    if (!context.mounted) return '';
    context.read<ChatModel>().setLoading(true);
    context.read<ChatModel>().setScroll(true);

    try {
      List<String> messageList = [];
      final userPrompt =
          '''I want you to act as a DJ. You will create a playlist of 10 songs similar to the following text either it is a song/keyword/lyrics/artist/a short prose.
          You must add the short title, one liner playlist description and songs with artist names to the answer. No song should be
            repeated and do not add any anything apart from one liner playlist description, title and songs : "${message.prompt}"''';

      // var headers = {
      //   'Authorization': 'Bearer ${Url.oaiToken}',
      //   'Content-Type': 'application/json'
      // };
      log('User Cookies: ${sp.getString('cookie')}');
      final cookie = sp.getString('cookie') ??
          'session=8b611d1b-d438-4755-90e8-d3ff0610baa1.AL8Tvg99Y7hbKMnHkiYKqA8-kso';

      // final messageSystem = MessageModel(
      //     role: 'system', content: 'You are a Music Recommendation Assistant.');

      // messageList.add(messageSystem.toMap());

      // final messageUser = messageSystem.copyWith(role: 'user', content: userPrompt);
      messageList.add(userPrompt);

      // var request =
      //     http.Request('POST', Uri.parse('${Url.endpoint}completions'));

      ///Instantiating the HNG OpenAI package to call the OpenAI

      OpenAIRepository openAI = OpenAIRepository();

      var aiResponse = 'No Chat';

      if (messageList.length == 1) {
        debugPrint('Starting of the new chat!');
        aiResponse = await openAI.getChat(userPrompt, cookie);
      } else if (messageList.length > 1) {
        debugPrint('Old Chat!');
        aiResponse =
            await openAI.getChatCompletions(messageList, userPrompt, cookie);
      }

      if (aiResponse.startsWith('Error:')) {
        debugPrint('aiResponse: $aiResponse');
        if (!context.mounted) return '';
        showSnackbar(context, const Color(0xff121F33), aiResponse.substring(6));
      } else if (aiResponse.startsWith('Message:')) {
        aiResponse = aiResponse.substring(8);
        chatsDatabase.saveChat(
            message.prompt.toString(), chatId, aiResponse, 'assist', true);

        messageList.add(aiResponse.toString());
        if (kDebugMode) {
          print(messageList.toString());
        }
      }
      // request.body = json.encode({
      //   'model': 'gpt-3.5-turbo',
      //   'messages': messageList,
      //   'temperature': 0,
      //   'max_tokens': 600
      // });
      if (!context.mounted) return '';
      context.read<MessageViewModel>().fetchMessages(chatId);
/*       request.headers.addAll(headers);

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
 */

      context.read<MessageViewModel>().fetchMessages(chatId);
      context.read<ChatModel>().setScroll(true);

      return aiResponse;
    } catch (e) {
      return 'Some error: $e';
    } finally {
      if (context.mounted) {
        context.read<ChatModel>().setLoading(false);
        context.read<ChatModel>().setScroll(true);
      }
    }
  }
}
