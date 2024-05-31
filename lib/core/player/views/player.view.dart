import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart';

import 'package:jellybean/core/home/home.providers.dart';
import 'package:jellybean/core/player/player.controller.dart';
import 'package:jellybean/core/player/views/player.view.desktop.dart';
import 'package:jellybean/core/player/views/player.view.mobile.dart';
import 'package:jellybean/navigation/nav_utils.dart';
import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/utils/setup.dart';

class PlayerView extends ConsumerStatefulWidget {
  const PlayerView({
    required this.routeState,
    super.key,
  });

  final GoRouterState routeState;

  @override
  ConsumerState createState() => _PlayerViewState();
}

class _PlayerViewState extends ConsumerState<PlayerView> {
  // future me refactor these flags into something better
  bool isLoading = true;
  bool hasError = false;

  late final PlayerController playerController = PlayerController();

  @override
  void initState() {
    playerController.init();

    final urlApi = ref.read(getUrlApiProvider)!;
    final user = ref.read(currentUserProvider).value!;
    urlApi
        .getHlsUrl(
      widget.routeState.pathParameters['itemId']!,
      user.id!,
    )
        .then(
      (value) {
        setState(() {
          isLoading = false;
          playerController.player
              .open(Media(value, httpHeaders: urlApi.headers));
        });
      },
    ).onError(
      (error, stackTrace) {
        logError('Failed to get video url', error: error);
        hasError = true;
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : hasError
            ? const Text('Error could not load video')
            : LayoutSwitcher(
                mobileLayout: PlayerMobileView(controller: playerController),
                desktopLayout: PlayerDesktopView(controller: playerController),
              );
  }
}
