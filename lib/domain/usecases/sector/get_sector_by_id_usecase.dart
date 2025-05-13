import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/repositories/sector_repository.dart';

class GetSectorByIdUseCase {
  final SectorRepository _repository;

  GetSectorByIdUseCase(this._repository);

  Future<Sector?> call(String id) async {
    return await _repository.getSectorById(id);
  }
}