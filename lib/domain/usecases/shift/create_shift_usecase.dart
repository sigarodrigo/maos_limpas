import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/domain/repositories/shift_repository.dart';

class CreateShiftUseCase {
  final ShiftRepository _repository;

  CreateShiftUseCase(this._repository);

  Future<String> call(Shift shift) async {
    return await _repository.createShift(shift);
  }
}