import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellybean/utils/device.constants.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:media_kit/media_kit.dart';

final playerProvider = Provider<Player>((ref) {
  final player = Player(
    configuration: PlayerConfiguration(
      // Supply your options:
      title: appName,
      ready: () {
        logDebug('The initialization is complete.');
      },
    ),
  );

  ref.onDispose(player.dispose);

  return player;
});

final playVideoProvider = FutureProvider.autoDispose.family<void, String>((
  ref,
  videoId,
) async {
  final player = ref.watch(playerProvider);
  return player.open(Media(videoId));
});

// final getVidoUrlProvider = FutureProvider<String>((ref) async {
//
//   return ;
// });