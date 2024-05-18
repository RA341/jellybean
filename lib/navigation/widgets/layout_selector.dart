import 'package:flutter/material.dart';

import 'package:jellybean/navigation/nav_utils.dart';

class LayoutSwitcher extends StatelessWidget {
  const LayoutSwitcher({
    required this.mobileLayout,
    required this.desktopLayout,
    super.key,
  });

  final Widget mobileLayout;
  final Widget desktopLayout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use for tablets and desktops
        if (isMobileWidth(context)) {
          return mobileLayout;
        } else if (isTablet(context)) {
          // TODO tablet view
          return desktopLayout;
        } else {
          return desktopLayout;
        }
      },
    );
  }
}
