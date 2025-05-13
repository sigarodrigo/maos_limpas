import 'package:equatable/equatable.dart';
import 'package:maos_limpas/domain/entities/position.dart';

abstract class PositionEvent extends Equatable {
  const PositionEvent();

  @override
  List<Object?> get props => [];
}

class LoadPositionsEvent extends PositionEvent {}

class CreatePositionEvent extends PositionEvent {
  final String name;
  final String? description;

  const CreatePositionEvent({
    required this.name,
    this.description,
  });

  @override
  List<Object?> get props => [name, description];
}

class UpdatePositionEvent extends PositionEvent {
  final Position position;

  const UpdatePositionEvent({required this.position});

  @override
  List<Object?> get props => [position];
}

class DeletePositionEvent extends PositionEvent {
  final String id;

  const DeletePositionEvent({required this.id});

  @override
  List<Object?> get props => [id];
}