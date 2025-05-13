import 'package:equatable/equatable.dart';
import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/entities/shift.dart';

abstract class AuditSetupState extends Equatable {
  const AuditSetupState();

  @override
  List<Object?> get props => [];
}

class AuditSetupInitial extends AuditSetupState {}

class AuditSetupLoading extends AuditSetupState {}

class AuditSetupLoaded extends AuditSetupState {
  final List<Sector> sectors;
  final List<Shift> shifts;
  final String? selectedSectorId;
  final String? selectedShiftId;

  const AuditSetupLoaded({
    required this.sectors,
    required this.shifts,
    this.selectedSectorId,
    this.selectedShiftId,
  });

  AuditSetupLoaded copyWith({
    List<Sector>? sectors,
    List<Shift>? shifts,
    String? selectedSectorId,
    String? selectedShiftId,
  }) {
    return AuditSetupLoaded(
      sectors: sectors ?? this.sectors,
      shifts: shifts ?? this.shifts,
      selectedSectorId: selectedSectorId ?? this.selectedSectorId,
      selectedShiftId: selectedShiftId ?? this.selectedShiftId,
    );
  }

  @override
  List<Object?> get props => [sectors, shifts, selectedSectorId, selectedShiftId];
}

class AuditSetupFailure extends AuditSetupState {
  final String message;

  const AuditSetupFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class AuditSetupSuccess extends AuditSetupState {
  final String auditId;
  final String sectorId;
  final String shiftId;

  const AuditSetupSuccess({
    required this.auditId,
    required this.sectorId,
    required this.shiftId,
  });

  @override
  List<Object?> get props => [auditId, sectorId, shiftId];
}