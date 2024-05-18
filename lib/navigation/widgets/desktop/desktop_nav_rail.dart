import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DesktopNavRail extends StatelessWidget {
  const DesktopNavRail({
    required this.currentIndex,
    required this.switchPage,
    super.key,
  });

  final void Function(int) switchPage;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      labelType: NavigationRailLabelType.all,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home),
          label: Text('Home'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.browse_gallery),
          label: Text('Browse'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
        ),
      ],
      selectedIndex: currentIndex,
      onDestinationSelected: switchPage,
    );
  }
}
