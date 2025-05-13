import 'package:maos_limpas/domain/entities/shift.dart';

abstract class ShiftRepository {
  Future<List<Shift>> getShifts();
  Future<Shift?> getShiftById(String id);
  Future<String> createShift(Shift shift);
  Future<bool> updateShift(Shift shift);
  Future<bool> deleteShift(String id);
}