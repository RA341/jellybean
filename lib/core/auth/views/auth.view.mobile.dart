import 'package:flutter/widgets.dart';

import 'package:jellybean/core/auth/auth.controller.dart';
import 'package:jellybean/core/auth/views/auth.view.desktop.dart';
import 'package:jellybean/utils/setup.dart';

class AuthMobileView extends StatelessWidget {
  const AuthMobileView({required this.controller, super.key});

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    // TODO using desktop view for now change
    //  once mobile is implemented
    return AuthDesktopView(controller: controller);
    logInfo('${controller.pageController.position}');
    return Text('TODO UI: ${controller.addressBox.text}');
  }
}