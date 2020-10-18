import 'package:arrow_log/migrations/session.dart';
import 'package:arrow_log/models/session/session.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

class SessionService {
  List<Session> _sessions = [];

  Future<void> loadSessions() async {
    Database database = await _getDatabase();

    final List<Map<String, dynamic>> types = await database.query(
      'sessions',
    );
    _sessions = List.generate(types.length, (i) => Session.fromDb(types[i]));
    _sessions.sort((a, b) => b.when.compareTo(a.when));

    database.close();
  }

  List<Session> getSessions() => _sessions;

  Future<Session> getSession(int id) async {
    Database database = await _getDatabase();

    final List<Map<String, dynamic>> types = await database.query(
      'sessions',
      where: 'id = ?',
      whereArgs: [id]
    );
    List<Session> sessions = List.generate(types.length, (i) => Session.fromDb(types[i]));

    database.close();

    if (sessions.isNotEmpty) {
      return sessions.first;
    }

    return null;
  }

  Future<Session> getUncompletedSession() async {
    Database database = await _getDatabase();

    final List<Map<String, dynamic>> types = await database.query(
      'sessions',
      where: 'completed = ?',
      whereArgs: [0]
    );
    List<Session> sessions = List.generate(types.length, (i) => Session.fromDb(types[i]));

    database.close();

    if (sessions.isNotEmpty) {
      return sessions.first;
    }

    return null;
  }

  Future<Database> _getDatabase() async {
    return await openDatabaseWithMigration(
      join(await getDatabasesPath(), 'sessions.db'),
      SessionMigrations.config
    );
  }

  Future<void> saveSession(Session session) async {
    Database database = await _getDatabase();

    await database.insert('sessions', session.toDb(), conflictAlgorithm: ConflictAlgorithm.ignore);

    await database.close();

    return;
  }

  Future<void> updateSession(Session session) async {
    Database database = await _getDatabase();

    await database.update(
      'sessions',
      session.toDb(),
      where: 'id = ?',
      whereArgs: [session.id],
    );

    await database.close();

    return;
  }

  Future<void> deleteSession(int id) async {
    Database database = await _getDatabase();

    await database.delete(
      'sessions',
      where: 'id = ?',
      whereArgs: [id],
    );

    await database.close();

    return;
  }
}