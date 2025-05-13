import 'package:maos_limpas/data/datasources/local/database_helper.dart';
import 'package:maos_limpas/data/models/sector_model.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';

abstract class SectorLocalDataSource {
  Future<List<SectorModel>> getSectors();
  Future<SectorModel?> getSectorById(String id);
  Future<String> insertSector(SectorModel sector);
  Future<int> updateSector(SectorModel sector);
  Future<int> deleteSector(String id);
}

class SectorLocalDataSourceImpl implements SectorLocalDataSource {
  final DatabaseHelper _databaseHelper;
  final Uuid _uuid = const Uuid();

  SectorLocalDataSourceImpl({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  @override
  Future<List<SectorModel>> getSectors() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sectors',
      where: 'active = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return SectorModel.fromJson(maps[i]);
    });
  }

  @override
  Future<SectorModel?> getSectorById(String id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sectors',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return SectorModel.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<String> insertSector(SectorModel sector) async {
    final db = await _databaseHelper.database;
    final String id = sector.id.isEmpty ? _uuid.v4() : sector.id;
    final sectorWithId = sector.copyWith(id: id, syncStatus: 1);
    await db.insert(
      'sectors',
      sectorWithId.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<int> updateSector(SectorModel sector) async {
    final db = await _databaseHelper.database;
    final sectorWithSyncStatus = sector.copyWith(syncStatus: 1);
    return await db.update(
      'sectors',
      sectorWithSyncStatus.toJson(),
      where: 'id = ?',
      whereArgs: [sector.id],
    );
  }

  @override
  Future<int> deleteSector(String id) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'sectors',
      {'active': 0, 'sync_status': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}