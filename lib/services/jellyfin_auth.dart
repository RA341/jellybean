import 'dart:async';

import 'package:jellybean/models/auth.model.dart';

import 'package:jellybean/utils/setup.dart';
import 'package:jellybean/utils/utils.dart';
import 'package:jellydart/jellydart.dart';
import 'package:jellydart/auth_with_metadata.dart';

Future<String?> testConnection(String host) async {
  final testClient = ApiClient(basePath: host);
  try {
    await SystemApi(testClient).getPublicSystemInfo();
    return null;
  } catch (e) {
    logDebug('failed to connect to $host', error: e);
    return e.toString().split('\n').first;
  }
}

Future<String?> loginToJellyFin(
  String host,
  String username,
  String pass,
  String deviceData,
) async {
  // override the default api client
  var tmpApiClient = ApiClient(basePath: host)
    ..addDefaultHeader('Authorization', deviceData);

  try {
    final userAuth = await UserApi(tmpApiClient).authenticateUserByName(
      AuthenticateUserByName(
        username: username,
        pw: pass,
      ),
    );

    if (userAuth == null || userAuth.accessToken == null) {
      logInfo('Authentication failed or access token is null');
      return null;
    }
    logInfo(
        'User ${userAuth.user?.name ?? 'No name found'} logged in, saving...');

    final auth = AuthWithMetadata(
      accessToken: userAuth.accessToken!,
      deviceString: deviceData,
    );
    tmpApiClient = ApiClient(basePath: host, authentication: auth);
    final user = await UserApi(tmpApiClient).getCurrentUser();

    if (user != null) {
      return userAuth.accessToken;
    }

    logDebug('Test ping failed, User is empty');
  } catch (e) {
    logError('Failed to login', error: e);
    return null;
  }
  return null;
}

Future<String> connectionLoop(
  List<String> hostList,
  int delay,
  int maximumTries,
) async {
  var connectionTries = 0;
  while (connectionTries < maximumTries) {
    for (final host in hostList) {
      try {
        final testClient = ApiClient(basePath: host);
        final serverInfo = await SystemApi(testClient).getPublicSystemInfo();
        logDebug('Server connected ${serverInfo?.serverName}');
        // exit loop if successful in making connection to server
        return host;
      } catch (e) {
        logInfo('Failed to connect to host $host', error: e);
        logDebug('Connecting to next host in list after $delay ms');
        await Future<void>.delayed(Duration(milliseconds: delay));
      }
    }
    connectionTries++;
  }
  throw Exception(
    'Maximum retries exceeded, client could not connect to server from the host list',
  );
}

Future<JellyFinClientData> collectClientData() async {
  final appVersion = await getAppInfo();
  final deviceData = await getDeviceInfo();

  return JellyFinClientData(
    version: appVersion,
    client: 'Jellybean-${deviceData[2]}',
    deviceId: deviceData[1],
    device: deviceData[2],
  );
}

Future<void> saveServerAddressToSharedPrefs(
  String address,
  String accessToken,
  String serverNickName,
) async {
  try {
    final server = (settings.getServer(serverNickName) ?? Server())
      ..accessToken = accessToken
      ..hostList.add(address)
      ..nickName = serverNickName;
    await settings.setNewServer(server);
  } catch (e) {
    logError('Failed to save settings', error: e);
    rethrow;
  }
}
