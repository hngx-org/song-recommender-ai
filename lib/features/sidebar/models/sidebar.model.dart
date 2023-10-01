// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Conversation {
  final String title;
  final String chatId;
  Conversation({required this.title, required this.chatId});
}

class FooterItems {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  FooterItems({
    required this.title,
    required this.icon,
    required this.onTap,
  });
}
