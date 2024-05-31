import 'package:flutter/material.dart';

import 'package:jellybean/navigation/nav_utils.dart';
import 'package:jellybean/core/settings/views/settings.view.desktop.dart';
import 'package:jellybean/core/settings/views/settings.view.mobile.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const LayoutSwitcher(
      mobileLayout: SettingsMobileView(),
      desktopLayout: SettingsDesktopView(),
    );
  }
}