import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:jellybean/core/home/home.providers.dart';
import 'package:jellybean/navigation/route_names.dart';
import 'package:jellybean/utils/setup.dart';

class SettingsDesktopView extends StatelessWidget {
  const SettingsDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ActionBar(),
      ],
    );
  }
}

class ActionBar extends ConsumerWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () => ref.refresh(continueWatchingProvider.future),
          child: const Text('Refresh'),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
        ElevatedButton(
          onPressed: () async {
            await settings.logout();
            if (!context.mounted) return;
            context.goNamed(homeRouteName);
          },
          child: const Text('Reset db'),
        ),
      ],
    );
  }
}
