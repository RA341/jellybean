import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellybean/core/auth/auth.controller.dart';
import 'package:jellybean/core/auth/widgets/login_page.dart';
import 'package:jellybean/core/auth/widgets/server_login.dart';

import 'package:jellybean/utils/app.constants.dart';

class AuthDesktopView extends ConsumerWidget {
  const AuthDesktopView({required this.controller, super.key});

  final AuthController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      children: [
        ServerPage(controller: controller),
        LoginPage(controller: controller),
      ],
    );
  }
}
