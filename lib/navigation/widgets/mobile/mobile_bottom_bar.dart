import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({required this.navShell, required this.switchPage, super.key});

  final StatefulNavigationShell navShell;
  final void Function(int) switchPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.2,
      width: double.infinity,
      child: NavigationBar(
        onDestinationSelected: switchPage,
        selectedIndex: navShell.currentIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.browse_gallery),
            label: 'Browse',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
