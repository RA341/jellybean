import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:jellybean/core/home/home.providers.dart';
import 'package:jellybean/core/home/home.utils.dart';
import 'package:jellybean/core/home/widgets/latest_recommeded_movies.dart';
import 'package:jellybean/core/home/widgets/resume_watching_row.dart';
import 'package:jellybean/navigation/route_names.dart';
import 'package:jellybean/providers/jellyfin_auth.provider.dart';
import 'package:jellybean/utils/setup.dart';

class HomeDesktopView extends ConsumerWidget {
  const HomeDesktopView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          LatestAndRecommendedMediaCarousal(),
          ResumeWatching(),
          LatestMediaCollections(),
        ],
      ),
    );
  }
}

class ResumeWatching extends ConsumerWidget {
  const ResumeWatching({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(continueWatchingProvider);
    return handleAsyncValue(
      item,
      (value) {
        if (value == null) {
          return const Text('No data found');
        }
        return ResumeWatchingRow(data: value);
      },
    );
  }
}

class LatestMediaCollections extends StatelessWidget {
  const LatestMediaCollections({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('Latest Media');
  }
}
