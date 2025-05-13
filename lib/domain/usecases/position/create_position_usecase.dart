import 'package:maos_limpas/domain/entities/position.dart';
import 'package:maos_limpas/domain/repositories/position_repository.dart';

class CreatePositionUseCase {
  final PositionRepository _repository;

  CreatePositionUseCase(this._repository);

  Future<String> call(Position position) async {
    return await _repository.createPosition(position);
  }
}