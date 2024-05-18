import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:jellybean/database/database.dart';
import 'package:jellybean/utils/setup.dart';

/// Obtains a database connection for running drift on the web.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(
    Future(() async {
      final db = await WasmDatabase.open(
        databaseName: 'jellybean',
        sqlite3Uri: Uri.parse('sqlite3.wasm'),
        driftWorkerUri: Uri.parse('drift_worker.js'),
      );

      if (db.missingFeatures.isNotEmpty) {
        logDebug('Using ${db.chosenImplementation} due to unsupported '
            'browser features: ${db.missingFeatures}');
      }

      return db.resolvedExecutor;
    }),
  );
}
