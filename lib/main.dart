import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellybean/navigation/router.dart';
import 'package:jellybean/utils/setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpAppSingletons();
  AppLifecycleListener(
    onExitRequested: () async {
      logDebug('Exiting...');
      unregisterSingletons();
      return AppExitResponse.exit;
    },
  );
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Jellybean',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}
