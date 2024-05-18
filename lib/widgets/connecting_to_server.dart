import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:jellybean/core/home/home.utils.dart';
import 'package:jellybean/navigation/route_names.dart';
import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/utils/setup.dart';

class ConnectingToServer extends ConsumerWidget {
  const ConnectingToServer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiVal = ref.watch(serverHostProvider);
    return Scaffold(
      body: handleAsyncValue(
        apiVal,
        (data) {
          if (data == null) context.go(authRoute);
          // if host is null implies default server was not found
          Future(
            () {
              logDebug('Api provider is found');
              context.go(homeRoute);
            },
          );
          return const Text('Server found redirecting...');
        },
        errorFunc: (p0, p1) {
          Future(
            () => context.go(
              errorRoute,
              extra: 'Failed to make connection with server',
            ),
          );
          return const Text('Could connect to server !!');
        },
      ),
    );
  }
}
