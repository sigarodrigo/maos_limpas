import 'package:maos_limpas/domain/entities/position.dart';
import 'package:maos_limpas/domain/repositories/position_repository.dart';

class GetPositionsUseCase {
  final PositionRepository _repository;

  GetPositionsUseCase(this._repository);

  Future<List<Position>> call() async {
    return await _repository.getPositions();
  }
}