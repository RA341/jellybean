import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/utils/assets.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:jellydart/api.dart';

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
        'Found ${data.totalRecordCount} items from startIndex: ${data.startIndex}');
    // TODO make scrollable
    return Row(
      children: data.items!.map(itemBuilder).toList(),
    );
  }

  ResumeWatchingItem itemBuilder(BaseItemDto item) =>
      ResumeWatchingItem(item: item);
}

class ResumeWatchingItem extends ConsumerWidget {
  const ResumeWatchingItem({
    required this.item,
    super.key,
  });

  final BaseItemDto item;

  Future<Widget> getImage(ApiClient client) async {
    final imageAPI = ImageApi(client);
    try {
      // final fg = await imageAPI.getItemImage(item.id!,);
      // if (fg == null || fg.isEmpty) {
      //   // TODO show default image
      //   return const Icon(Icons.error);
      // }


    } catch (e) {
      logError('Could not find image', error: e);
    }

    return const Icon(Icons.error);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(apiClientProvider);

    if (client != null) getImage(client);

    return SizedBox(
      width: 100,
      height: 75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            height: 100,
            child: CachedNetworkImage(
              imageUrl: 'https://letsenhance.io/static/73136da51c245e80edc6ccfe44888a99/1015f/MainBefore.jpg',
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Image.asset(
                AppAssets.movieClipBoard,
              ),
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(item.name ?? 'No name'),
        ],
      ),
    );
  }
}
