import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/sidebar/models/sidebar.model.dart';
import 'package:song_recommender_ai/utils/res/icons.dart';

abstract class ISidebarRepository {
  Future<List<Conversation>> getSidebarTile();
  List<FooterItems> getSidebarFooter();
}

class SidebarRepository extends ISidebarRepository {
  @override
  Future<List<Conversation>> getSidebarTile() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return [
        Conversation(title: 'Frank Sinatra'),
        Conversation(title: 'Sorrow'),
        Conversation(title: 'Summer Songs'),
        Conversation(title: 'Party'),
        Conversation(title: 'Fly me to the moon'),
        Conversation(title: 'Al-Green'),
        Conversation(title: 'Jazz'),
      ];
    });
  }

  @override
  List<FooterItems> getSidebarFooter() {
    return [
      FooterItems(
        title: 'Clear Conversations',
        icon: AppIcons.deleteIcon,
        onTap: () {},
      ),
      FooterItems(
        title: 'Subscribe',
        icon: Icons.subscriptions,
        onTap: () {},
      ),
      FooterItems(
        title: 'FAQ & Updates',
        icon: AppIcons.faqIcon,
        onTap: () {},
      ),
      FooterItems(
        title: 'Logout',
        icon: AppIcons.logoutIcon,
        onTap: () {},
      ),
    ];
  }
}
