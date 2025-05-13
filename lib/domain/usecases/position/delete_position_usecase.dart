import 'package:maos_limpas/domain/repositories/position_repository.dart';

class DeletePositionUseCase {
  final PositionRepository _repository;

  DeletePositionUseCase(this._repository);

  Future<bool> call(String id) async {
    return await _repository.deletePosition(id);
  }
}
