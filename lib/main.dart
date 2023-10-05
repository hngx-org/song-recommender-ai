import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_recommender_ai/features/authentication/viewmodels/auth.viewmodel.dart';
import 'package:song_recommender_ai/features/authentication/views/login_page.dart';
import 'package:song_recommender_ai/features/authentication/views/sign_up.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/chat_ai.viewmodel.dart';
import 'package:song_recommender_ai/features/chat/viewmodels/messages.viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';
import 'package:song_recommender_ai/features/inapp_payment/views/payment_page.dart';
import 'package:song_recommender_ai/features/onboarding/views/onboard_screen.dart';
import 'package:song_recommender_ai/features/sidebar/viewmodels/sidebar.viewmodel.dart';
import 'package:song_recommender_ai/utils/res/colors.dart';
import 'package:song_recommender_ai/utils/widgets/faq_page.dart';
import 'package:song_recommender_ai/utils/widgets/splash_screen.dart';

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
        ChangeNotifierProvider(create: (_) => MessageViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel())
      ],
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedColor),
          useMaterial3: true,
        ),
        // home: const SafeArea(bottom: true, top: false, child: ChatPage()),
        initialRoute: '/splash',
        routes: {
          '/onboarding': (context) => const OnboardingView(),
          '/splash': (context) => const SplashScreen(),
          '/signup': (context) => const AuthSignUP(),
          '/login': (context) => const AuthLogin(),
          '/chat': (context) => const ChatPage(),
          '/payment': (context) => PaymentView(),
          '/faq': (context) => const FAQPage()
        },
      ),
    );
  }
}
