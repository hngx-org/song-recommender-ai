import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:song_recommender_ai/features/sidebar/viewmodels/sidebar.viewmodel.dart';
import 'package:song_recommender_ai/utils/res/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
      tools: const [
        ...DevicePreview.defaultTools,
      ],
    ),
  );
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
        locale: DevicePreview.locale(context),
        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
          useMaterial3: true,
        ),
        home: const SafeArea(bottom: true, top: false, child: ChatPage()),
      ),
    );
  }
}
