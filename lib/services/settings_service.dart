import 'package:shared_preferences/shared_preferences.dart';

import 'package:jellybean/core/auth/auth.utils.dart';
import 'package:jellybean/models/auth.model.dart';

class SettingsService {
  late final SharedPreferences prefs;

  List<String> get serverNamesList => prefs.getStringList(SKeys.serverList)!;

  /// how many times to try to connect to a specific host
  int get timesToRetry => prefs.getInt(SKeys.timesToRetry)!;

  /// delay before next connection request
  int get retryDelayInMilliseconds =>
      prefs.getInt(SKeys.retryDelayInMilliseconds)!;

  /// times to go through the host list
  /// i.e go to the host list 3 times before showing error message
  int get listRetryTimes => prefs.getInt(SKeys.listRetryTimes)!;

  /// url with lowest index will have the highest connection priority
  List<Server> get serverList => readServers();

  /// default server in the list
  String get defaultServer => prefs.getString(SKeys.defaultServer) ?? '';

  /// device string to use during auth
  String get deviceData => prefs.getString(SKeys.deviceData)!;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    await _initData();
  }

  Future<void> _initData() async {
    if (!prefs.containsKey(SKeys.timesToRetry)) {
      await prefs.setInt(SKeys.timesToRetry, 3);
    }
    if (!prefs.containsKey(SKeys.retryDelayInMilliseconds)) {
      await prefs.setInt(SKeys.retryDelayInMilliseconds, 100);
    }
    if (!prefs.containsKey(SKeys.defaultServer)) {
      await prefs.setString(SKeys.defaultServer, '');
    }
    if (!prefs.containsKey(SKeys.serverList)) {
      await prefs.setStringList(SKeys.serverList, []);
    }
    if (!prefs.containsKey(SKeys.deviceData)) {
      final data = await getDeviceInfoString();
      await prefs.setString(SKeys.deviceData, data);
    }
  }

  bool areSettingsInvalid() {
    if (getDefaultServer() == null) {
      // if no default server exists
      // implies no data exists
      return true;
    }
    return false;
  }

  Server? getDefaultServer() {
    if (defaultServer.isEmpty) {
      return null;
    }
    return getServer(defaultServer);
  }

  Server? getServer(String name) {
    final data = prefs.getStringList(name);
    if (data == null) {
      return null;
    }

    return Server.fromPrefs(
      nickName: name,
      accessToken: data[0],
      hostList: data.sublist(1),
    );
  }

  List<Server> readServers() =>
      serverNamesList.map((e) => getServer(e)!).toList();

  Future<void> setNewServer(Server server) async {
    await prefs.setStringList(server.nickName!, server.toPrefs());
    if (defaultServer.isEmpty) {
      // if first server being inserted
      await prefs.setString(SKeys.defaultServer, server.nickName!);
    }

    // store server nickname
    final newServerList = prefs.getStringList(SKeys.serverList)!
      ..add(server.nickName!);
    await prefs.setStringList(SKeys.serverList, newServerList);
  }

  Future<void> deleteNewServer(Server server) async {
    // remove server with key
    await prefs.remove(server.nickName!);
    // remove server name from server name list
    final current = serverNamesList..remove(server.nickName);
    await prefs.setStringList(SKeys.serverList, current);
  }

  Future<void> clearSettings() async {
    await prefs.clear();
  }

  Future<void> logout() async {
    for (final element in prefs.getStringList(SKeys.serverList)!) {
      await prefs.remove(element);
    }
    await prefs.setStringList(SKeys.serverList, []);
    await prefs.setString(SKeys.defaultServer, '');
  }
}

class SKeys {
  static const timesToRetry = 'timesToRetry';

  // delay before next connection request
  static const retryDelayInMilliseconds = 'retryDelay';

  // times to go through the host list
  // i.e go to the host list 3 times before showing error message
  static const listRetryTimes = 'listRetryTimes';

  // url with lowest index will have the highest connection priority
  static const serverList = 'ServerList';

  // default server in the list
  static const defaultServer = 'defaultServer';

  // device string to use during auth
  static const deviceData = 'deviceData';
}
