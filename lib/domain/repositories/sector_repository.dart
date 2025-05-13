import 'package:maos_limpas/domain/entities/sector.dart';

abstract class SectorRepository {
  Future<List<Sector>> getSectors();
  Future<Sector?> getSectorById(String id);
  Future<String> createSector(Sector sector);
  Future<bool> updateSector(Sector sector);
  Future<bool> deleteSector(String id);
}