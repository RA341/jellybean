import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jellydart/jellydart.dart';

import 'package:jellybean/utils/app.constants.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:jellybean/utils/utils.dart';


final hostListProvider = StateProvider<List<String>>((ref) => []);

final publicUsersProvider =
    FutureProvider.autoDispose<List<UserDto>?>((ref) async {
  final host = ref.watch(hostListProvider).first;
  try {
    final public = await UserApi(ApiClient(basePath: host)).getPublicUsers();
    return public;
  } catch (e) {
    logDebug('Failed to fetch users', error: e);
  }
  logInfo('No public users found');
  return null;
});

final protocolProvider =
    StateProvider.autoDispose<String>((ref) => protocolList.first);
final portProvider = StateProvider.autoDispose<String>((ref) => '8096');
final addressProvider = StateProvider.autoDispose<String>((ref) {
  if (kDebugMode) {
    return '192.168.1.124';
  }
  return '';
});

final urlPreviewProvider = Provider.autoDispose<String>((ref) {
  final address = ref.watch(addressProvider);
  final port = ref.watch(portProvider);
  final protocol = ref.watch(protocolProvider);
  if (address.isEmpty) {
    return '';
  }
  return formatAddress(protocol, address, port);
});
