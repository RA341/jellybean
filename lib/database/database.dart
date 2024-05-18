import 'package:drift/drift.dart';

import 'package:jellybean/database/connection/shared.connection.dart' as impl;

part 'database.g.dart';

@DriftDatabase(tables: [])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  @override
  int get schemaVersion => 1;
}
