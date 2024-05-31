import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_kit_video/media_kit_video.dart';

import 'package:jellybean/core/player/player.controller.dart';

class PlayerDesktopView extends ConsumerWidget {
  const PlayerDesktopView({
    required this.controller,
    super.key,
  });

  final PlayerController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        // todo implement custom video ui
        child: Video(controller: controller.videoController),
      ),
    );
  }
}
