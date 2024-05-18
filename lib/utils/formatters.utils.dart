enum AddressType { ip, hostName, none }

bool isIP(String text) {
  final ipRegex = RegExp(
      r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$');
  return ipRegex.hasMatch(text);
}

bool isHostname(String text) {
  final hostnameRegex = RegExp(
      r'^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$');
  return hostnameRegex.hasMatch(text);
}

AddressType detectUrlType(String text) {
  if (isIP(text)) {
    return AddressType.ip;
  } else if (isHostname(text)) {
    return AddressType.hostName;
  } else {
    return AddressType.none;
  }
}
