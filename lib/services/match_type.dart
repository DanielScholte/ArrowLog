import 'package:arrow_log/migrations/match_type.dart';
import 'package:arrow_log/models/match_type/match_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

class MatchTypeService {
  List<MatchType> _matchTypes = [];

  Future<void> loadMatchTypes({Database database}) async {
    if (database == null) {
      database = await _getDatabase();
    }

    final List<Map<String, dynamic>> types = await database.query('match_types');
    _matchTypes = List.generate(types.length, (i) => MatchType.fromDb(types[i]));

    database.close();
  }

  Future<Database> _getDatabase() async {
    return await openDatabaseWithMigration(
      join(await getDatabasesPath(), 'match_types.db'),
      MatchTypeMigrations.config
    );
  }

  Future<void> saveType(MatchType type) async {
    Database database = await _getDatabase();

    await database.insert('match_types', type.toDb(), conflictAlgorithm: ConflictAlgorithm.ignore);

    await loadMatchTypes(database: database);

    return;
  }

  Future<void> deleteType(MatchType type) async {
    Database database = await _getDatabase();

    type.deleted = 1;

    await database.update(
      'match_types',
      type.toDb(),
      where: "id = ?",
      whereArgs: [type.id],
    );

    await loadMatchTypes(database: database);

    return;
  }

  List<MatchType> getAvailableMatchTypes() => _matchTypes
      .where((m) => m.deleted == 0)
      .toList();

  List<MatchType> getMatchTypes() => _matchTypes;

  MatchType getMatchType(int id) => _matchTypes.firstWhere((m) => m.id == id, orElse: () => null);
}