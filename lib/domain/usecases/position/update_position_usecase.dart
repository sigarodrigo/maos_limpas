import 'package:maos_limpas/domain/entities/position.dart';
import 'package:maos_limpas/domain/repositories/position_repository.dart';

class UpdatePositionUseCase {
  final PositionRepository _repository;

  UpdatePositionUseCase(this._repository);

  Future<bool> call(Position position) async {
    return await _repository.updatePosition(position);
  }
}