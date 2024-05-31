import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:jellybean/core/home/home.providers.dart';
import 'package:jellybean/navigation/route_names.dart';

import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/utils/assets.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:jellydart/jellydart.dart';

class ResumeWatchingRow extends StatelessWidget {
  const ResumeWatchingRow({
    required this.data,
    super.key,
  });

  final BaseItemDtoQueryResult data;

  @override
  Widget build(BuildContext context) {
    if (data.items == null) {
      logInfo('No resume items found, not building row');
      return const SizedBox();
    }
    logInfo(
        'Found ${data.totalRecordCount} items from startIndex: ${data
            .startIndex}');
    // TODO make scrollable
    return Row(
      children: data.items!.map(itemBuilder).toList(),
    );
  }

  MediaItem itemBuilder(BaseItemDto item) => MediaItem(item: item);
}

/// Widget that displays mediainfo used everywhere
/// Things it displays
/// 1. the image of the show/movie, scenes of its already played
/// 2. Play button launches the video player
/// 3. more info button takes you to the main info page for the show (add gesture support for additonal options)
/// 4. progress bar
/// 5. options list for adding to playlist, delete etc
/// 6. a button to mark the item played/unplayed
class MediaItem extends ConsumerWidget {
  const MediaItem({
    required this.item,
    super.key,
  });

  final BaseItemDto item;

  String get itemId => item.id!;

  double? get playedPercentage => item.userData!.playedPercentage;

  void goToPlayer(String itemId, BuildContext ctx) {
    ctx.goNamed(playerRouteName, pathParameters: {'itemId': itemId});
  }

  void showMoreOptions() {
    // todo
  }

  String goToMoreInfo() {
    // todo
    return '';
  }

  // todo
  void togglePlayed() {}

  void toggleFavourite() {}

  Future<Widget> getImageArt(ApiClient client) async {
    // TODO
    final imageAPI = ImageApi(client);
    if (playedPercentage != null) {
      // return scenes form the episode at that time
    }

    // return normal primary image

    try {
      final fg = await imageAPI.getItemImage(item.id!, ImageType.primary);
      if (fg == null) {
        // TODO show default image
        return const Icon(Icons.error);
      }
    } catch (e) {
      logError('Could not find image', error: e);
    }

    return const Icon(Icons.error);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(getUrlApiProvider)!;

    return GestureDetector(
      onTap: () {
        context.goNamed(playerRouteName, pathParameters: {'itemId': itemId});
      },
      child: SizedBox(
        width: 100,
        height: 75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 100,
              child: CachedNetworkImage(
                imageUrl:
                'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Image.asset(
                      AppAssets.movieClipBoard,
                    ),
                fit: BoxFit.scaleDown,
              ),
            ),
            Text(item.name ?? 'No name'),
          ],
        ),
      ),
    );
  }
}
