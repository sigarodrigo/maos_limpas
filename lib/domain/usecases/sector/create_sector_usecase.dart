import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/repositories/sector_repository.dart';

class CreateSectorUseCase {
  final SectorRepository _repository;

  CreateSectorUseCase(this._repository);

  Future<String> call(Sector sector) async {
    return await _repository.createSector(sector);
  }
}