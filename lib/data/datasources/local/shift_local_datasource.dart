import 'package:maos_limpas/data/datasources/local/database_helper.dart';
import 'package:maos_limpas/data/models/shift_model.dart';
import 'package:uuid/uuid.dart';
import 'package:sqflite/sqflite.dart';

abstract class ShiftLocalDataSource {
  Future<List<ShiftModel>> getShifts();
  Future<ShiftModel?> getShiftById(String id);
  Future<String> insertShift(ShiftModel shift);
  Future<int> updateShift(ShiftModel shift);
  Future<int> deleteShift(String id);
}

class ShiftLocalDataSourceImpl implements ShiftLocalDataSource {
  final DatabaseHelper _databaseHelper;
  final Uuid _uuid = const Uuid();

  ShiftLocalDataSourceImpl({required DatabaseHelper databaseHelper})
      : _databaseHelper = databaseHelper;

  @override
  Future<List<ShiftModel>> getShifts() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'shifts',
      where: 'active = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (i) {
      return ShiftModel.fromJson(maps[i]);
    });
  }

  @override
  Future<ShiftModel?> getShiftById(String id) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'shifts',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ShiftModel.fromJson(maps.first);
    }
    return null;
  }

  @override
  Future<String> insertShift(ShiftModel shift) async {
    final db = await _databaseHelper.database;
    final String id = shift.id.isEmpty ? _uuid.v4() : shift.id;
    final shiftWithId = shift.copyWith(id: id, syncStatus: 1);
    await db.insert(
      'shifts',
      shiftWithId.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  @override
  Future<int> updateShift(ShiftModel shift) async {
    final db = await _databaseHelper.database;
    final shiftWithSyncStatus = shift.copyWith(syncStatus: 1);
    return await db.update(
      'shifts',
      shiftWithSyncStatus.toJson(),
      where: 'id = ?',
      whereArgs: [shift.id],
    );
  }

  @override
  Future<int> deleteShift(String id) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'shifts',
      {'active': 0, 'sync_status': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}