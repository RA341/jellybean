import 'package:flutter/material.dart';

import 'package:jellybean/core/library/views/library.view.desktop.dart';
import 'package:jellybean/core/library/views/library.view.mobile.dart';
import 'package:jellybean/navigation/nav_utils.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO UI
    return const LayoutSwitcher(
      mobileLayout: LibraryMobileView(),
      desktopLayout: LibraryDesktopView(),
    );
  }
}