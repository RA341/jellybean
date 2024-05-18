import 'package:flutter/material.dart';
import 'package:jellybean/services/jellyfin_auth.dart';


Future<String> getDeviceInfoString() async {
  final clientData = await collectClientData();

  final deviceData =
      'MediaBrowser Client="${clientData.client}", Device="${clientData.device}", DeviceId="${clientData.deviceId}", Version="${clientData.version}"';
  return deviceData;
}
