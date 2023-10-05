import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatsDatabase {
  final String? uid;

  ChatsDatabase({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> saveChat(String title, String chatid, String msg, String role,
      bool shouldAnimate) async {
    final userChatsReference =
        userCollection.doc(uid).collection('chats').doc(chatid);
    userChatsReference.set({'title': title});
    userChatsReference.collection('messages').add({
      'text': msg,
      'sender': role,
      'animate': shouldAnimate,
      'timestamp': FieldValue.serverTimestamp()
    });
  }

  Future<String> removeAllChats() async {
    try {
      final QuerySnapshot chatDocuments =
          await userCollection.doc(uid).collection('chats').get();

      for (QueryDocumentSnapshot chatDocument in chatDocuments.docs) {
        await chatDocument.reference
            .collection('messages')
            .get()
            .then((snapshot) {
          for (DocumentSnapshot messageDocument in snapshot.docs) {
            messageDocument.reference.delete();
          }
        });
        await chatDocument.reference.delete();
      }
      if (kDebugMode) {
        print('All chats removed successfully.');
      }
      return 'All chats removed successfully.';
    } catch (e) {
      if (kDebugMode) {
        print('Error removing chats: $e');
      }
      return 'Error removing chat: $e';
    }
  }

  Future<String> removeSingleChat(String chatId) async {
    try {
      final DocumentReference chatRef =
          userCollection.doc(uid).collection('chats').doc(chatId);

      // Delete all messages within the chat
      final QuerySnapshot messageDocuments =
          await chatRef.collection('messages').get();
      for (QueryDocumentSnapshot messageDocument in messageDocuments.docs) {
        await messageDocument.reference.delete();
      }

      /// Delete the chat itself
      await chatRef.delete();

      if (kDebugMode) {
        print('Chat removed successfully.');
      }

      return 'Chat removed successfully.';
    } catch (e) {
      if (kDebugMode) {
        print('Error removing chat: $e');
      }
      return 'Error removing chat: $e';
    }
  }
}
