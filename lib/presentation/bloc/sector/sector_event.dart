import 'package:equatable/equatable.dart';
import 'package:maos_limpas/domain/entities/sector.dart';

abstract class SectorEvent extends Equatable {
  const SectorEvent();

  @override
  List<Object?> get props => [];
}

class LoadSectorsEvent extends SectorEvent {}

class CreateSectorEvent extends SectorEvent {
  final String name;
  final String? description;

  const CreateSectorEvent({
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [name, description];
}

class UpdateSectorEvent extends SectorEvent {
  final Sector sector;

  const UpdateSectorEvent({required this.sector});

  @override
  List<Object?> get props => [sector];
}

class DeleteSectorEvent extends SectorEvent {
  final String id;

  const DeleteSectorEvent({required this.id});

  @override
  List<Object?> get props => [id];
}