import 'package:sqflite_migration/sqflite_migration.dart';

class MatchTypeMigrations {
  static final List<String> _initializationScripts = [
    '''
      CREATE TABLE match_types(
        id INTEGER PRIMARY KEY,
        name TEXT,
        distance INTEGER,
        arrows INTEGER,
        rounds INTEGER,
        target_face_id INTEGER,
        deleted INTEGER
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