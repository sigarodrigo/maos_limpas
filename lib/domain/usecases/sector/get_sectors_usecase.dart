import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/repositories/sector_repository.dart';

class GetSectorsUseCase {
  final SectorRepository _repository;

  GetSectorsUseCase(this._repository);

  Future<List<Sector>> call() async {
    return await _repository.getSectors();
  }
}