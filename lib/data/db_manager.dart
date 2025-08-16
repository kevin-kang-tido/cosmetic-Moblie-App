import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  final String _dbName = "ppua.db";
  static final DBManager instance = DBManager._init();

  static Database? _database;

  DBManager._init();

  // Define SQL types
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String doubleType = 'REAL NOT NULL';

  Future<Database> get database async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );

    return _database!;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS product (
        id $idType,
        name $textType,
        price $doubleType
      );
    ''');
  }

}
