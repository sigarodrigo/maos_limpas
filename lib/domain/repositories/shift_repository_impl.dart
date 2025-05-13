import 'package:maos_limpas/data/datasources/local/shift_local_datasource.dart';
import 'package:maos_limpas/data/models/shift_model.dart';
import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/domain/repositories/shift_repository.dart';

class ShiftRepositoryImpl implements ShiftRepository {
  final ShiftLocalDataSource _localDataSource;

  ShiftRepositoryImpl({required ShiftLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<List<Shift>> getShifts() async {
    final shiftModels = await _localDataSource.getShifts();
    return shiftModels;
  }

  @override
  Future<Shift?> getShiftById(String id) async {
    return await _localDataSource.getShiftById(id);
  }

  @override
  Future<String> createShift(Shift shift) async {
    final shiftModel = ShiftModel(
      id: '',
      name: shift.name,
      startTime: shift.startTime,
      endTime: shift.endTime,
      active: shift.active,
    );
    return await _localDataSource.insertShift(shiftModel);
  }

  @override
  Future<bool> updateShift(Shift shift) async {
    final shiftModel = ShiftModel(
      id: shift.id,
      name: shift.name,
      startTime: shift.startTime,
      endTime: shift.endTime,
      active: shift.active,
    );
    final rowsAffected = await _localDataSource.updateShift(shiftModel);
    return rowsAffected > 0;
  }

  @override
  Future<bool> deleteShift(String id) async {
    final rowsAffected = await _localDataSource.deleteShift(id);
    return rowsAffected > 0;
  }
}