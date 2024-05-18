import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

/// Obtains a database connection for running drift in a Dart VM.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
        final cacheBase = (await getTemporaryDirectory()).path;
        // We can't access /tmp on Android, which sqlite3 would try by default.
        // Explicitly tell it about the correct temporary directory.
        sqlite3.tempDirectory = cacheBase;
      }

      return NativeDatabase.createBackgroundConnection(
        await databaseFile,
        logStatements: kDebugMode,
      );
    }),
  );
}

Future<File> get databaseFile async {
  // We use `path_provider` to find a suitable path to store our data in.
  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = p.join(appDir.path, 'jellybean.db');
  return File(dbPath);
}

Future<void> deleteDatabaseFile() async {
  final file = await databaseFile;
  await file.delete();
}
