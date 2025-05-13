import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'maos_limpas.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    // Usuários
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT UNIQUE NOT NULL,
        password_hash TEXT NOT NULL,
        role TEXT NOT NULL,
        active INTEGER DEFAULT 1,
        last_sync TIMESTAMP
      )
    ''');

    // Setores
    await db.execute('''
      CREATE TABLE sectors (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        active INTEGER DEFAULT 1,
        sync_status INTEGER DEFAULT 0
      )
    ''');

    // Turnos
    await db.execute('''
      CREATE TABLE shifts (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        start_time TEXT,
        end_time TEXT,
        active INTEGER DEFAULT 1,
        sync_status INTEGER DEFAULT 0
      )
    ''');

    // Cargos
    await db.execute('''
      CREATE TABLE positions (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT,
        active INTEGER DEFAULT 1,
        sync_status INTEGER DEFAULT 0
      )
    ''');

    // Auditorias
    await db.execute('''
      CREATE TABLE audits (
        id TEXT PRIMARY KEY,
        date TIMESTAMP NOT NULL,
        user_id TEXT NOT NULL,
        sector_id TEXT NOT NULL,
        shift_id TEXT NOT NULL,
        notes TEXT,
        sync_status INTEGER DEFAULT 0,
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (sector_id) REFERENCES sectors (id),
        FOREIGN KEY (shift_id) REFERENCES shifts (id)
      )
    ''');

    // Oportunidades
    await db.execute('''
      CREATE TABLE opportunities (
        id TEXT PRIMARY KEY,
        audit_id TEXT NOT NULL,
        arrow_position TEXT NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        position_id TEXT NOT NULL,
        sync_status INTEGER DEFAULT 0,
        FOREIGN KEY (audit_id) REFERENCES audits (id),
        FOREIGN KEY (position_id) REFERENCES positions (id)
      )
    ''');
  }
}