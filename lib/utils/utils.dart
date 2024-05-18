import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:jellybean/utils/setup.dart';
import 'package:package_info_plus/package_info_plus.dart';

String formatAddress(String protocol, String address, String port) {
  if (port.isEmpty) {
    return '$protocol$address';
  }
  return '$protocol$address:$port';
}

Future<String> getAppInfo() async {
  try {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  } catch (e) {
    logError('Failed to get app version', error: e);
  }
  return 'NoVersion-V0.0.1';
}

Future<List<String>> getDeviceInfo() async {
  final deviceInfo = DeviceInfoPlugin();

  try {
    final data = await deviceInfo.deviceInfo;
    // loosely return host name and os version
    switch (data.runtimeType) {
      case AndroidDeviceInfo:
        final tmp = data as AndroidDeviceInfo;
        return [tmp.host, tmp.version.release, 'Android'];

      case WindowsDeviceInfo:
        final tmp = data as WindowsDeviceInfo;
        return [tmp.computerName, tmp.deviceId, 'Windows'];

      case LinuxDeviceInfo:
        final tmp = data as LinuxDeviceInfo;
        return [tmp.prettyName, tmp.id, 'Linux'];

      case IosDeviceInfo:
        final tmp = data as IosDeviceInfo;
        return [tmp.name, tmp.systemVersion, 'IOS'];

      case MacOsDeviceInfo:
        final tmp = data as MacOsDeviceInfo;
        return [tmp.hostName, tmp.osRelease, 'MacOS'];

      case WebBrowserInfo:
        final tmp = data as WebBrowserInfo;
        return [
          tmp.browserName.name,
          tmp.appVersion ?? 'RandId-${generateRandomId(10)}',
          'Browser',
        ];
    }
  } catch (e) {
    logError('Failed to get device info', error: e);
  }
  return [
    'RandDev-${generateRandomId(5)}',
    'RandId-${generateRandomId(10)}',
    'Unknown Device',
  ];
}

String generateRandomId(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
    length,
    (_) => chars.codeUnitAt(random.nextInt(chars.length)),
  ));
}
