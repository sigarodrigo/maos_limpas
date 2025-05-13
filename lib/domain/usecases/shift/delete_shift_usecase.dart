import 'package:maos_limpas/domain/repositories/shift_repository.dart';

class DeleteShiftUseCase {
  final ShiftRepository _repository;

  DeleteShiftUseCase(this._repository);

  Future<bool> call(String id) async {
    return await _repository.deleteShift(id);
  }
}