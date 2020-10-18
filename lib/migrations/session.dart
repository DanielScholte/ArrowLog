import 'package:sqflite_migration/sqflite_migration.dart';

class SessionMigrations {
  static final List<String> _initializationScripts = [
    '''
      CREATE TABLE sessions(
        id INTEGER PRIMARY KEY,
        name TEXT,
        date TEXT,
        scores TEXT,
        completed INTEGER,
        match_type_id INTEGER
      )
    '''
  ];

  static final List<String> _migrationScripts = [

  ];

  static final MigrationConfig config = MigrationConfig(
    initializationScript: _initializationScripts,
    migrationScripts: _migrationScripts,
  );
}