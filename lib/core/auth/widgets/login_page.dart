import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellybean/core/auth/auth.controller.dart';
import 'package:jellybean/core/auth/auth.providers.dart';
import 'package:jellybean/core/auth/widgets/public_user_display.dart';


import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/utils/setup.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    required this.controller,
    super.key,
  });

  final AuthController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicUsers = ref.watch(publicUsersProvider);

    return Column(
      children: [
        BackToServerButton(controller: controller),
        Expanded(child: PublicUsersList(users: publicUsers)),
        Expanded(
          flex: 10,
          child: SizedBox(
            width: 560,
            child: UserNameAndPass(cont: controller),
          ),
        ),
      ],
    );
  }
}

class BackToServerButton extends StatelessWidget {
  const BackToServerButton({
    required this.controller,
    super.key,
  });

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => controller.goToPage(0),
      child: const Text('Back'),
    );
  }
}

class UserNameAndPass extends ConsumerWidget {
  const UserNameAndPass({required this.cont, super.key});

  final AuthController cont;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final host = ref.watch(hostListProvider).first;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: cont.userBox,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Username',
          ),
        ),
        const Padding(padding: EdgeInsets.all(10)),
        TextField(
          obscureText: true,
          controller: cont.passBox,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Password',
          ),
        ),
        const Padding(padding: EdgeInsets.all(30)),
        ElevatedButton(
          onPressed: () => cont.loginUser(
            host,
            context,
            ref,
          ),
          child: const Text('Login'),
        ),
      ],
    );
  }
}
