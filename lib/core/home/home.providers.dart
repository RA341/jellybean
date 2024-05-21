import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:jellydart/jellydart.dart';

final latestAndRecommendedProvider = Provider<List<String>>((ref) {
  return [''];
});

final continueWatchingProvider =
    FutureProvider<BaseItemDtoQueryResult?>((ref) async {
  final user = ref.watch(currentUserProvider).value;
  if (user == null) {
    return null;
  }

  final client = ref.watch(apiClientProvider)!;

  final itemsApi = await ItemsApi(client).getResumeItems(
    user.id!,
    limit: 12,
    fields: [ItemFields.primaryImageAspectRatio, ItemFields.basicSyncInfo],
    enableImageTypes: [ImageType.primary, ImageType.backdrop, ImageType.thumb],
    mediaTypes: ['Video'],
  );
  return itemsApi;
});

final videoApi = Provider<VideosApi?>((ref) {
  final client = ref.watch(apiClientProvider);
  if (client == null) return null;

  return VideosApi(client);
});
