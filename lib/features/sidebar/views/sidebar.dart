import 'package:flutter/material.dart';
import 'package:song_recommender_ai/features/sidebar/models/sidebar.model.dart';
import 'package:song_recommender_ai/features/sidebar/repositories/sidebar.repository.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static ISidebarRepository sidebarRepo = SidebarRepository();
  static List<FooterItems> sidebarFooter = sidebarRepo.getSidebarFooter();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: Column(
        children: [
          FutureBuilder<List<Conversation>>(
              future: sidebarRepo.getSidebarTile(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                      return ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(8),
                        children: List.generate(
                            snapshot.data!.length,
                            (index) => ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  leading: const Icon(
                                    Icons.chat_bubble_outline,
                                    size: 20,
                                  ),
                                  style: ListTileStyle.drawer,
                                  title: Text(
                                      snapshot.data![index].title.toString()),
                                  onTap: () {},
                                )),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'An ${snapshot.error} occurred',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                        ),
                      );
                    }
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }),
          ListView(
            shrinkWrap: true,
            children: List<Widget>.generate(
              sidebarFooter.length,
              (index) => ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                leading: Icon(
                  sidebarFooter[index].icon,
                  size: 20,
                ),
                onTap: () {},
                title: Text(sidebarFooter[index].title.toString()),
                style: ListTileStyle.drawer,
              ),
            ),
          )
        ],
      )),
    );
  }
}
