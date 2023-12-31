import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/authentication/views/login_page.dart';
import 'package:song_recommender_ai/features/authentication/views/sign_up.dart';
import 'package:song_recommender_ai/features/chat/views/chat_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      
      case '/login':
        page = const AuthLogin();
        break;
      case '/signup':
        page = const AuthSignUP
        ();
        break;
      case '/chat':
        page = const ChatPage();
        break;
      default:
        page = const Center(
          child: Text('No Specified Route'),
        );
    }
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionDuration: const Duration(seconds: 0),
    );
  }
}