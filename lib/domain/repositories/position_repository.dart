import 'package:maos_limpas/domain/entities/position.dart';

abstract class PositionRepository {
  Future<List<Position>> getPositions();
  Future<Position?> getPositionById(String id);
  Future<String> createPosition(Position position);
  Future<bool> updatePosition(Position position);
  Future<bool> deletePosition(String id);
}