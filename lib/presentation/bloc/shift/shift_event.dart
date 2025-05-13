import 'package:equatable/equatable.dart';
import 'package:maos_limpas/domain/entities/shift.dart';

abstract class ShiftEvent extends Equatable {
  const ShiftEvent();

  @override
  List<Object?> get props => [];
}

class LoadShiftsEvent extends ShiftEvent {}

class CreateShiftEvent extends ShiftEvent {
  final String name;
  final String? startTime;
  final String? endTime;

  const CreateShiftEvent({
    required this.name,
    this.startTime,
    this.endTime,
  });

  @override
  List<Object?> get props => [name, startTime, endTime];
}

class UpdateShiftEvent extends ShiftEvent {
  final Shift shift;

  const UpdateShiftEvent({required this.shift});

  @override
  List<Object?> get props => [shift];
}

class DeleteShiftEvent extends ShiftEvent {
  final String id;

  const DeleteShiftEvent({required this.id});

  @override
  List<Object?> get props => [id];
}