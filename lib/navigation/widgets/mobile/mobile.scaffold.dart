import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MobileBaseScaffold extends StatelessWidget {
  const MobileBaseScaffold({
    required this.navShell,
    required this.bottomNav,
    super.key,
  });

  final StatefulNavigationShell navShell;
  final Widget bottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navShell,
      bottomNavigationBar: bottomNav,
    );
  }
}
