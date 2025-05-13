import 'package:maos_limpas/data/datasources/local/position_local_datasource.dart';
import 'package:maos_limpas/data/models/position_model.dart';
import 'package:maos_limpas/domain/entities/position.dart';
import 'package:maos_limpas/domain/repositories/position_repository.dart';

class PositionRepositoryImpl implements PositionRepository {
  final PositionLocalDataSource _localDataSource;

  PositionRepositoryImpl({required PositionLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<List<Position>> getPositions() async {
    final positionModels = await _localDataSource.getPositions();
    return positionModels;
  }

  @override
  Future<Position?> getPositionById(String id) async {
    return await _localDataSource.getPositionById(id);
  }

  @override
  Future<String> createPosition(Position position) async {
    final positionModel = PositionModel(
      id: '',
      name: position.name,
      description: position.description,
      active: position.active,
    );
    return await _localDataSource.insertPosition(positionModel);
  }

  @override
  Future<bool> updatePosition(Position position) async {
    final positionModel = PositionModel(
      id: position.id,
      name: position.name,
      description: position.description,
      active: position.active,
    );
    final rowsAffected = await _localDataSource.updatePosition(positionModel);
    return rowsAffected > 0;
  }

  @override
  Future<bool> deletePosition(String id) async {
    final rowsAffected = await _localDataSource.deletePosition(id);
    return rowsAffected > 0;
  }
}