import 'package:jellybean/utils/device.constants.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

/// used for passing state between mobile and desktop
class PlayerController {
  PlayerController();

  late final VideoController videoController;
  late final Player player;

  void init() {
    player = Player(
      configuration: PlayerConfiguration(
        // Supply your options:
        title: appName,
        ready: () {
          logDebug('The initialization is complete.');
        },
      ),
    );
    videoController = VideoController(player);
  }

  void dispose(){
    player.dispose();
  }
}
