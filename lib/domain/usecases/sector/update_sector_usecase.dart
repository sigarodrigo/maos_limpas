import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/repositories/sector_repository.dart';

class UpdateSectorUseCase {
  final SectorRepository _repository;

  UpdateSectorUseCase(this._repository);

  Future<bool> call(Sector sector) async {
    return await _repository.updateSector(sector);
  }
}