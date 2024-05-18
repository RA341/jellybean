import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jellybean/core/auth/auth.controller.dart';
import 'package:jellybean/core/auth/views/auth.view.desktop.dart';
import 'package:jellybean/core/auth/views/auth.view.mobile.dart';
import 'package:jellybean/navigation/nav_utils.dart';
import 'package:jellybean/utils/setup.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  late final AuthController controller = AuthController(ref: ref);

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  void dispose() {
    logDebug('Disposing Auth controller state');
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO BUG: if a user is in user login view and app goes to mobile view,
    //  the screen resets to server view
    return Scaffold(
      body: LayoutSwitcher(
        mobileLayout: AuthMobileView(controller: controller),
        desktopLayout: AuthDesktopView(controller: controller),
      ),
    );
  }
}
