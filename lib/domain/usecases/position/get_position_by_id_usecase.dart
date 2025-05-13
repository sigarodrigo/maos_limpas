import 'package:maos_limpas/domain/entities/position.dart';
import 'package:maos_limpas/domain/repositories/position_repository.dart';

class GetPositionByIdUseCase {
  final PositionRepository _repository;

  GetPositionByIdUseCase(this._repository);

  Future<Position?> call(String id) async {
    return await _repository.getPositionById(id);
  }
}