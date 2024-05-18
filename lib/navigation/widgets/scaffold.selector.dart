import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:jellybean/navigation/nav_utils.dart';
import 'package:jellybean/navigation/responsive.dart';
import 'package:jellybean/navigation/widgets/desktop/desktop.scaffold.dart';
import 'package:jellybean/navigation/widgets/desktop/desktop_nav_rail.dart';
import 'package:jellybean/navigation/widgets/mobile/mobile.scaffold.dart';
import 'package:jellybean/navigation/widgets/mobile/mobile_bottom_bar.dart';
import 'package:jellybean/utils/setup.dart';

class BaseScaffoldSelector extends StatelessWidget {
  const BaseScaffoldSelector({required this.shell, super.key});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final isPageWithNavBar = !routesWithNoNavbar.contains(shell.currentIndex);
    return LayoutBuilder(
      builder: (context, constraints) {
        return LayoutSwitcher(
          desktopLayout: DesktopBaseScaffold(
            navShell: shell,
            sideNav: isPageWithNavBar
                ? DesktopNavRail(
                    switchPage: _pageSelector,
                    currentIndex: shell.currentIndex,
                  )
                : const SizedBox(),
          ),
          mobileLayout: MobileBaseScaffold(
            navShell: shell,
            bottomNav: isPageWithNavBar
                ? MobileNavBar(
                    navShell: shell,
                    switchPage: _pageSelector,
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }

  void _pageSelector(int pageIndex) {
    try {
      shell.goBranch(
        pageIndex,
        initialLocation: pageIndex == shell.currentIndex,
      );
    } catch (e) {
      logError(
        'Failed to navigate to ${shell.route.routes[pageIndex]}',
        error: e,
      );
    }
  }
}
