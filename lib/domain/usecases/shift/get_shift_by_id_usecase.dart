// lib/domain/usecases/shift/get_shift_by_id_usecase.dart
import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/domain/repositories/shift_repository.dart';

class GetShiftByIdUseCase {
  final ShiftRepository _repository;

  GetShiftByIdUseCase(this._repository);

  Future<Shift?> call(String id) async {
    return await _repository.getShiftById(id);
  }
}