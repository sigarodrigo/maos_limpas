import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/usecases/sector/get_sectors_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/get_shifts_usecase.dart';
import 'package:maos_limpas/presentation/bloc/audit_setup/audit_setup_event.dart';
import 'package:maos_limpas/presentation/bloc/audit_setup/audit_setup_state.dart';
import 'package:uuid/uuid.dart';

class AuditSetupBloc extends Bloc<AuditSetupEvent, AuditSetupState> {
  final GetSectorsUseCase _getSectorsUseCase;
  final GetShiftsUseCase _getShiftsUseCase;
  final Uuid _uuid = const Uuid();

  AuditSetupBloc({
    required GetSectorsUseCase getSectorsUseCase,
    required GetShiftsUseCase getShiftsUseCase,
  })  : _getSectorsUseCase = getSectorsUseCase,
        _getShiftsUseCase = getShiftsUseCase,
        super(AuditSetupInitial()) {
    on<LoadSectorsAndShiftsEvent>(_onLoadSectorsAndShifts);
    on<SelectSectorEvent>(_onSelectSector);
    on<SelectShiftEvent>(_onSelectShift);
    on<StartAuditEvent>(_onStartAudit);
  }

  Future<void> _onLoadSectorsAndShifts(
    LoadSectorsAndShiftsEvent event,
    Emitter<AuditSetupState> emit,
  ) async {
    emit(AuditSetupLoading());
    try {
      final sectors = await _getSectorsUseCase();
      final shifts = await _getShiftsUseCase();
      
      if (sectors.isEmpty) {
        emit(const AuditSetupFailure(
            message: 'Não há setores cadastrados. Por favor, cadastre pelo menos um setor.'));
        return;
      }
      
      if (shifts.isEmpty) {
        emit(const AuditSetupFailure(
            message: 'Não há turnos cadastrados. Por favor, cadastre pelo menos um turno.'));
        return;
      }
      
      emit(AuditSetupLoaded(sectors: sectors, shifts: shifts));
    } catch (e) {
      emit(AuditSetupFailure(
          message: 'Falha ao carregar dados: ${e.toString()}'));
    }
  }

  void _onSelectSector(
    SelectSectorEvent event,
    Emitter<AuditSetupState> emit,
  ) {
    final currentState = state;
    if (currentState is AuditSetupLoaded) {
      emit(currentState.copyWith(selectedSectorId: event.sectorId));
    }
  }

  void _onSelectShift(
    SelectShiftEvent event,
    Emitter<AuditSetupState> emit,
  ) {
    final currentState = state;
    if (currentState is AuditSetupLoaded) {
      emit(currentState.copyWith(selectedShiftId: event.shiftId));
    }
  }

  Future<void> _onStartAudit(
    StartAuditEvent event,
    Emitter<AuditSetupState> emit,
  ) async {
    try {
      // Aqui seria o lugar para criar uma nova auditoria no banco de dados
      // Por enquanto, apenas geramos um ID
      final auditId = _uuid.v4();
      
      emit(AuditSetupSuccess(
        auditId: auditId,
        sectorId: event.sectorId,
        shiftId: event.shiftId,
      ));
    } catch (e) {
      emit(AuditSetupFailure(
          message: 'Falha ao iniciar auditoria: ${e.toString()}'));
    }
  }
}