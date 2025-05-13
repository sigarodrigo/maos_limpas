import 'package:equatable/equatable.dart';

abstract class AuditSetupEvent extends Equatable {
  const AuditSetupEvent();

  @override
  List<Object?> get props => [];
}

class LoadSectorsAndShiftsEvent extends AuditSetupEvent {}

class SelectSectorEvent extends AuditSetupEvent {
  final String sectorId;

  const SelectSectorEvent({required this.sectorId});

  @override
  List<Object?> get props => [sectorId];
}

class SelectShiftEvent extends AuditSetupEvent {
  final String shiftId;

  const SelectShiftEvent({required this.shiftId});

  @override
  List<Object?> get props => [shiftId];
}

class StartAuditEvent extends AuditSetupEvent {
  final String sectorId;
  final String shiftId;

  const StartAuditEvent({
    required this.sectorId,
    required this.shiftId,
  });

  @override
  List<Object?> get props => [sectorId, shiftId];
}