import 'package:flutter/material.dart';

import 'package:jellybean/navigation/nav_utils.dart';
import 'package:jellybean/core/player/views/player.view.desktop.dart';
import 'package:jellybean/core/player/views/player.view.mobile.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO UI
    return const LayoutSwitcher(
      mobileLayout: PlayerMobileView(),
      desktopLayout: PlayerDesktopView(),
    );
  }
}