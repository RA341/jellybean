import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DesktopBaseScaffold extends StatelessWidget {
  const DesktopBaseScaffold({
    required this.navShell,
    required this.sideNav,
    super.key,
  });

  final StatefulNavigationShell navShell;
  final Widget sideNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          sideNav,
          Expanded(child: navShell),
        ],
      ),
    );
  }
}
