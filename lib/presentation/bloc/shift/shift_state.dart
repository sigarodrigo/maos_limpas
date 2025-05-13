import 'package:equatable/equatable.dart';
import 'package:maos_limpas/domain/entities/shift.dart';

abstract class ShiftState extends Equatable {
  const ShiftState();

  @override
  List<Object?> get props => [];
}

class ShiftInitial extends ShiftState {}

class ShiftLoading extends ShiftState {}

class ShiftsLoaded extends ShiftState {
  final List<Shift> shifts;

  const ShiftsLoaded({required this.shifts});

  @override
  List<Object?> get props => [shifts];
}

class ShiftOperationSuccess extends ShiftState {
  final String message;

  const ShiftOperationSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class ShiftOperationFailure extends ShiftState {
  final String message;

  const ShiftOperationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}