import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:song_recommender_ai/features/sidebar/viewmodels/sidebar.viewmodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatModel()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => MessageViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SafeArea(bottom: true, top: false, child: ChatPage()),
      ),
    );
  }
}
