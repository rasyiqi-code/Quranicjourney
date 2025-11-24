import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class FunfactDatabase {
  static FunfactDatabase? _instance;
  Database? _database;

  FunfactDatabase._();

  factory FunfactDatabase() {
    _instance ??= FunfactDatabase._();
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = path.join(directory.path, 'funfacts.db');

    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE daily_funfacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT UNIQUE NOT NULL,
        category TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        source TEXT,
        reference TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Index untuk query cepat
    await db.execute('CREATE INDEX idx_date ON daily_funfacts(date)');
  }

  // Insert funfact
  Future<int> insertFunfact({
    required String date,
    required String category,
    required String title,
    required String content,
    String? source,
    String? reference,
  }) async {
    final db = await database;
    return await db.insert(
      'daily_funfacts',
      {
        'date': date,
        'category': category,
        'title': title,
        'content': content,
        'source': source,
        'reference': reference,
        'created_at': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get funfact by date
  Future<Map<String, dynamic>?> getFunfactByDate(String date) async {
    final db = await database;
    final result = await db.query(
      'daily_funfacts',
      where: 'date = ?',
      whereArgs: [date],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Get random funfact (untuk fallback)
  Future<Map<String, dynamic>?> getRandomFunfact() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT * FROM daily_funfacts ORDER BY RANDOM() LIMIT 1',
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Get all funfacts (max 30, ordered by date DESC)
  Future<List<Map<String, dynamic>>> getAllFunfacts() async {
    final db = await database;
    return await db.query(
      'daily_funfacts',
      orderBy: 'date DESC',
      limit: 30,
    );
  }

  // Get count of funfacts
  Future<int> getFunfactCount() async {
    final db = await database;
    final result = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM daily_funfacts'),
    );
    return result ?? 0;
  }

  // Delete oldest funfact jika sudah lebih dari 30
  Future<void> maintainMax30Funfacts() async {
    final db = await database;
    final count = await getFunfactCount();

    if (count > 30) {
      // Hapus yang tertua (date ASC)
      await db.rawDelete(
        'DELETE FROM daily_funfacts WHERE id IN '
        '(SELECT id FROM daily_funfacts ORDER BY date ASC LIMIT ?)',
        [count - 30],
      );
    }
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }
}
