import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

final hasValidCertificate = () {
  // we use this here because if a website has a valid certificate, then
  // we need a https jellyfin server address as the browser will not allow mixed protocol requests
  // i.e a http jellyfin instance in a https deployment of the app will not work.
  if (kIsWeb) {
    return html.window.location.protocol == 'https:';
  }

  // if we are running locally or natively we don't need to worry about the above issue
  return false;
}();
