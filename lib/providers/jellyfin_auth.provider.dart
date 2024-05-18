import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellybean/services/jellyfin_auth.dart';

import 'package:jellybean/utils/setup.dart';
import 'package:jellydart/api.dart';
import 'package:jellydart/auth_with_metadata.dart';

/// rotates host list of the default server to fina the active url
final serverHostProvider = FutureProvider<String?>((ref) async {
  final server = settings.getDefaultServer();
  if (server == null) {
    return null;
  }
  return connectionLoop(
    server.hostList,
    settings.retryDelayInMilliseconds,
    settings.timesToRetry,
  );
});

final apiClientProvider = Provider<ApiClient?>((ref) {
  final hostList = ref.watch(serverHostProvider).value;
  if (hostList == null) {
    return null;
  }

  final server = settings.getDefaultServer()!;
  final accessToken = server.accessToken!;

  final deviceInfo = settings.deviceData;
  final auth = AuthWithMetadata(
    accessToken: accessToken,
    deviceString: deviceInfo,
  );

  return ApiClient(
    basePath: hostList,
    authentication: auth,
  );
});

final currentUserProvider = FutureProvider<UserDto?>((ref) async {
  final apiClient = ref.watch(apiClientProvider);
  if (apiClient == null) {
    return null;
  }
  return UserApi(apiClient).getCurrentUser();
});
