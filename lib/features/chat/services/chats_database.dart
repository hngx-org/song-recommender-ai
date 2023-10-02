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

  Future<void> removeAllChats() async {
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
    } catch (e) {
      if (kDebugMode) {
        print('Error removing chats: $e');
      }
    }
  }
}
