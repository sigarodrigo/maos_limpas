import 'package:equatable/equatable.dart';
import 'package:maos_limpas/domain/entities/sector.dart';

abstract class SectorState extends Equatable {
  const SectorState();

  @override
  List<Object?> get props => [];
}

class SectorInitial extends SectorState {}

class SectorLoading extends SectorState {}

class SectorsLoaded extends SectorState {
  final List<Sector> sectors;

  const SectorsLoaded({required this.sectors});

  @override
  List<Object?> get props => [sectors];
}

class SectorOperationSuccess extends SectorState {
  final String message;

  const SectorOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SectorOperationFailure extends SectorState {
  final String message;

  const SectorOperationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}