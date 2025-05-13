import 'package:maos_limpas/data/datasources/local/sector_local_datasource.dart';
import 'package:maos_limpas/data/models/sector_model.dart';
import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/repositories/sector_repository.dart';

class SectorRepositoryImpl implements SectorRepository {
  final SectorLocalDataSource _localDataSource;

  SectorRepositoryImpl({required SectorLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<List<Sector>> getSectors() async {
    final sectorModels = await _localDataSource.getSectors();
    return sectorModels;
  }

  @override
  Future<Sector?> getSectorById(String id) async {
    return await _localDataSource.getSectorById(id);
  }

  @override
  Future<String> createSector(Sector sector) async {
    final sectorModel = SectorModel(
      id: '',
      name: sector.name,
      description: sector.description,
      active: sector.active,
    );
    return await _localDataSource.insertSector(sectorModel);
  }

  @override
  Future<bool> updateSector(Sector sector) async {
    final sectorModel = SectorModel(
      id: sector.id,
      name: sector.name,
      description: sector.description,
      active: sector.active,
    );
    final rowsAffected = await _localDataSource.updateSector(sectorModel);
    return rowsAffected > 0;
  }

  @override
  Future<bool> deleteSector(String id) async {
    final rowsAffected = await _localDataSource.deleteSector(id);
    return rowsAffected > 0;
  }
}