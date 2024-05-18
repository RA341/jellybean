export 'unsupported.dart'
    if (dart.library.ffi) 'native.connection.dart'
    if (dart.library.html) 'web.connection.dart';
