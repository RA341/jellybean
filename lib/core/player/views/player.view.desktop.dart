import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellybean/core/home/home.utils.dart';
import 'package:jellybean/core/player/player.providers.dart';
import 'package:jellydart/jellydart.dart';
import 'package:media_kit_video/media_kit_video.dart';

class PlayerDesktopView extends ConsumerWidget {
  const PlayerDesktopView({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Placeholder();
    // final player = ref.watch(playVideoProvider(item.));
    // final playerContainer = ref.watch(playerProvider);
    //
    // return handleAsyncValue(player, (p0) {
    //   final vController = VideoController(
    //     playerContainer,
    //   );
    //
    //   return Video(
    //     controller: vController,
    //   );
    // });
  }
}
