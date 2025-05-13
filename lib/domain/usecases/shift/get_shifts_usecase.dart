import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/domain/repositories/shift_repository.dart';

class GetShiftsUseCase {
  final ShiftRepository _repository;

  GetShiftsUseCase(this._repository);

  Future<List<Shift>> call() async {
    return await _repository.getShifts();
  }
}