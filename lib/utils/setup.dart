import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:jellybean/services/settings_service.dart';
import 'package:logger/logger.dart';

import 'package:jellybean/database/connection/unsupported.dart';
import 'package:jellybean/database/database.dart';

GetIt getIt = GetIt.instance;
final get = getIt.get;

/// Get it unregister
final unreg = getIt.unregister;

/// Get it register
final reg = getIt.registerSingleton;

final db = get<AppDatabase>();
final settings = get<SettingsService>();

final log = get<Logger>();
final logDebug = log.d;
final logError = log.e;
final logInfo = log.i;
final logFatal = log.f;

Future<void> setUpAppSingletons() async {
  final log = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 3,
      lineLength: 80,
    ),
  );
  reg<Logger>(log, dispose: (logger) async => logger.close());

  // db
  final database = AppDatabase();
  reg<AppDatabase>(
    database,
    dispose: (param) async {
      if (kDebugMode) {}
      await param.close();
    },
  );

  // settings
  final settings = SettingsService();
  await settings.init();
  reg<SettingsService>(
    settings,
    dispose: (param) async {
      if (kDebugMode) {
        await param.clearSettings();
      }
    },
  );

  // await setupInitialDbData();
}

void unregisterSingletons() {
  unreg<AppDatabase>();
  unreg<SettingsService>();
  unreg<Logger>();
}

Future<void> setupInitialDbData() async {}
