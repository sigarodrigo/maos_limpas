import 'package:maos_limpas/domain/repositories/sector_repository.dart';

class DeleteSectorUseCase {
  final SectorRepository _repository;

  DeleteSectorUseCase(this._repository);

  Future<bool> call(String id) async {
    return await _repository.deleteSector(id);
  }
}