import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:song_recommender_ai/features/chat/models/user_message.model.dart';

abstract class IMessagesRepository {
  Future<List<Message>?> fetchChatMsgs(String uId, String chatId);
}

///This Repository is used to fetch messages from the firestore fpr each chat,
///We are using abstraction and repository pattern to ensure separation of
///concerns and easy understanding.
///[fetchChatMsgs] method contains the main logic to fetch the chat msgs.
///we are also updating the [animate] bool parameter to ensure that ai message
///does not animate each time we fetch data from the firestore.
///At the end we are returning the list of message objects.

class MessagesRepository extends IMessagesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Message>?> fetchChatMsgs(String uId, String chatId) async {
    try {
      final chatRef = _firestore
          .collection('users')
          .doc(uId)
          .collection('chats')
          .doc(chatId)
          .collection('messages');

      final querySnapshot =
          await chatRef.orderBy('timestamp', descending: false).get();
      final messages = querySnapshot.docs.map((message) {
        final role = message.data()['sender'].toString();
        final content = message.data()['text'].toString();
        final animate = message.data()['animate'];

        if (animate) {
          chatRef.doc(message.id).update({'animate': false});
        }
        return Message(
            isSender: (role == 'user') ? true : false,
            prompt: content,
            shouldAnimate: animate);
      }).toList();
      return messages;
    } catch (e) {
      if (kDebugMode) {
        print('Some Error Occurred: ${e.toString()}');
      }
    }
    return [];
  }
}
