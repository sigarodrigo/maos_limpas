import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/domain/repositories/shift_repository.dart';

class UpdateShiftUseCase {
  final ShiftRepository _repository;

  UpdateShiftUseCase(this._repository);

  Future<bool> call(Shift shift) async {
    return await _repository.updateShift(shift);
  }
}