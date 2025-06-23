import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:prosecat/generated/l10n.dart';
import 'package:prosecat/providers/pages_provider.dart';
import 'package:provider/provider.dart';

class AnimatedButtonNavbar extends StatelessWidget {
  const AnimatedButtonNavbar({super.key});

  @override
  Widget build(BuildContext context) {  
      final pagesProvider = Provider.of<PagesProvider>(context);
      
     return ConvexAppBar(
      key: pagesProvider.appBarKey,
      curveSize: 100,
      initialActiveIndex: pagesProvider.pageController.initialPage,
      height: 55,
      backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.grey[900],
      color: Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white,
      activeColor: Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white,
      style: TabStyle.react,
      items: [
        TabItem(
          icon: const Icon(Icons.map_outlined),
          activeIcon: const Icon(Icons.map_outlined), title: S.of(context).labelMapa),
        TabItem(
          icon: const Icon(Icons.drive_eta_outlined), 
          activeIcon: const Icon(Icons.drive_eta_outlined), title: S.of(context).labelDispositivos),
        TabItem(
          icon: const Icon(Icons.notifications_active_outlined), 
          activeIcon: const Icon(Icons.notifications_active_outlined), title: S.of(context).labelAlertas),
        TabItem(
          icon: const Icon(Icons.history_outlined), 
          activeIcon: const Icon(Icons.history_outlined), title: S.of(context).labelHistorial),
      ],
      onTap: (int i) => pagesProvider.animateToPage(i),
    );
  }
}