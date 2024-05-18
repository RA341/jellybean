import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jellybean/core/home/views/home.view.desktop.dart';
import 'package:jellybean/core/home/views/home.view.mobile.dart';
import 'package:jellybean/navigation/nav_utils.dart';
import 'package:jellybean/providers/jellyfin_auth.provider.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO ui
    return const LayoutSwitcher(
      mobileLayout: HomeMobileView(),
      desktopLayout: HomeDesktopView(),
    );
  }
}
