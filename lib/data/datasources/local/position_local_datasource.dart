import 'package:maos_limpas/data/datasources/local/database_helper.dart';
import 'package:maos_limpas/data/models/position_model.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';

abstract class PositionLocalDataSource {
  Future<List<PositionModel>> getPositions();
  Future<PositionModel?> getPositionById(String id);
  Future<String> insertPosition(PositionModel position);
  Future<int> updatePosition(PositionModel position);
  Future<int> deletePosition(String id);
}

class PositionLocalDataSourceImpl implements PositionLocalDataSource {
  final DatabaseHelper _databaseHelper;
  final Uuid _uuid = const Uuid();

  PositionLocalDataSourceImpl({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  @override
  Future<List<PositionModel>> getPositions() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'positions',
      where: 'active = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return PositionModel.fromJson(maps[i]);
    });
  }

  @override
  Future<PositionModel?> getPositionById(String id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'positions',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return PositionModel.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<String> insertPosition(PositionModel position) async {
    final db = await _databaseHelper.database;
    final String id = position.id.isEmpty ? _uuid.v4() : position.id;
    final positionWithId = position.copyWith(id: id, syncStatus: 1);
    await db.insert(
      'positions',
      positionWithId.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<int> updatePosition(PositionModel position) async {
    final db = await _databaseHelper.database;
    final positionWithSyncStatus = position.copyWith(syncStatus: 1);
    return await db.update(
      'positions',
      positionWithSyncStatus.toJson(),
      where: 'id = ?',
      whereArgs: [position.id],
    );
  }

  @override
  Future<int> deletePosition(String id) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'positions',
      {'active': 0, 'sync_status': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}