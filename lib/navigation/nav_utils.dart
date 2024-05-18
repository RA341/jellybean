import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:jellybean/navigation/responsive.dart';

bool isMobileWidth(BuildContext context) =>
    MediaQuery.of(context).size.width < mobileMaxWidth;

bool isMobileOS() => Platform.isAndroid || Platform.isIOS;

// tablet if has dimensions of a desktop but using mobile os
bool isTablet(BuildContext context) => isMobileOS() && !isMobileWidth(context);

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
        if (!isMobileWidth(context)) {
          return desktopLayout;
        } else {
          return mobileLayout;
        }
      },
    );
  }
}
