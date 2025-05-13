import 'package:equatable/equatable.dart';
import 'package:maos_limpas/domain/entities/position.dart';

abstract class PositionState extends Equatable {
  const PositionState();

  @override
  List<Object?> get props => [];
}

class PositionInitial extends PositionState {}

class PositionLoading extends PositionState {}

class PositionsLoaded extends PositionState {
  final List<Position> positions;

  const PositionsLoaded({required this.positions});

  @override
  List<Object?> get props => [positions];
}

class PositionOperationSuccess extends PositionState {
  final String message;

  const PositionOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class PositionOperationFailure extends PositionState {
  final String message;

  const PositionOperationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}