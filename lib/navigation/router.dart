import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:jellybean/core/auth/views/auth.view.dart';
import 'package:jellybean/core/home/views/home.view.dart';
import 'package:jellybean/core/library/views/library.view.dart';
import 'package:jellybean/core/settings/views/settings.view.dart';
import 'package:jellybean/navigation/route_names.dart';
import 'package:jellybean/navigation/widgets/scaffold.selector.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:jellybean/widgets/connecting_to_server.dart';
import 'package:jellybean/widgets/error.dart';

// ref:https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart

// router key
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

// page keys
final GlobalKey<NavigatorState> libraryNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'libNav');
final GlobalKey<NavigatorState> homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'homNav');
final GlobalKey<NavigatorState> settingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settNav');

final ignoreRedirectsForPaths = {loadingRoute, errorRoute, authRoute};

// GoRouter configuration
final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: homeRoute,
  onException: (context, state, router) {
    context.go(errorRoute, extra: state.error);
  },
  redirect: (context, state) {
    final currentPath = state.fullPath;
    if (currentPath == null) {
      logDebug('Invalid path');
      return errorRoute;
    }

    if (ignoreRedirectsForPaths.contains(currentPath)) {
      // ignore redirect for these paths
      return currentPath;
    }

    final isInvalid = settings.areSettingsInvalid();
    if (isInvalid) {
      return authRoute;
    }

    // continue normal
    return currentPath;
  },
  routes: [
    GoRoute(
      name: errorRouteName,
      path: errorRoute,
      builder: (context, state) => const ErrorView(),
    ),
    GoRoute(
      name: loadingRouteName,
      path: loadingRoute,
      builder: (context, state) => const ConnectingToServer(),
    ),
    GoRoute(
      path: authRoute,
      name: authRouteName,
      redirect: (context, state) async {
        final isInvalid = settings.areSettingsInvalid();
        if (isInvalid) {
          // continue to auth
          return null;
        }
        return homeRoute;
      },
      builder: (context, state) => const AuthView(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          BaseScaffoldSelector(shell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: homeNavigatorKey,
          routes: [
            GoRoute(
              path: homeRoute,
              name: homeRouteName,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeView(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: libraryNavigatorKey,
          routes: [
            GoRoute(
              path: libraryRoute,
              name: libraryRouteName,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: LibraryView(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: settingsNavigatorKey,
          routes: [
            GoRoute(
              path: settingsRoute,
              name: settingsRouteName,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: SettingsView(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
