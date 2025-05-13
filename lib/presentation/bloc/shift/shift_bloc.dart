import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/domain/usecases/shift/create_shift_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/delete_shift_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/get_shifts_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/update_shift_usecase.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_event.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_state.dart';

class ShiftBloc extends Bloc<ShiftEvent, ShiftState> {
  final GetShiftsUseCase _getShiftsUseCase;
  final CreateShiftUseCase _createShiftUseCase;
  final UpdateShiftUseCase _updateShiftUseCase;
  final DeleteShiftUseCase _deleteShiftUseCase;

  ShiftBloc({
    required GetShiftsUseCase getShiftsUseCase,
    required CreateShiftUseCase createShiftUseCase,
    required UpdateShiftUseCase updateShiftUseCase,
    required DeleteShiftUseCase deleteShiftUseCase,
  })  : _getShiftsUseCase = getShiftsUseCase,
        _createShiftUseCase = createShiftUseCase,
        _updateShiftUseCase = updateShiftUseCase,
        _deleteShiftUseCase = deleteShiftUseCase,
        super(ShiftInitial()) {
    on<LoadShiftsEvent>(_onLoadShifts);
    on<CreateShiftEvent>(_onCreateShift);
    on<UpdateShiftEvent>(_onUpdateShift);
    on<DeleteShiftEvent>(_onDeleteShift);
  }

  Future<void> _onLoadShifts(
    LoadShiftsEvent event,
    Emitter<ShiftState> emit,
  ) async {
    emit(ShiftLoading());
    try {
      final shifts = await _getShiftsUseCase();
      emit(ShiftsLoaded(shifts: shifts));
    } catch (e) {
      emit(ShiftOperationFailure(
          message: 'Falha ao carregar turnos: ${e.toString()}'));
    }
  }

  Future<void> _onCreateShift(
    CreateShiftEvent event,
    Emitter<ShiftState> emit,
  ) async {
    emit(ShiftLoading());
    try {
      final shift = Shift(
        id: '',
        name: event.name,
        startTime: event.startTime,
        endTime: event.endTime,
      );
      await _createShiftUseCase(shift);
      emit(const ShiftOperationSuccess(message: 'Turno criado com sucesso!'));
      add(LoadShiftsEvent());
    } catch (e) {
      emit(ShiftOperationFailure(
          message: 'Falha ao criar turno: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateShift(
    UpdateShiftEvent event,
    Emitter<ShiftState> emit,
  ) async {
    emit(ShiftLoading());
    try {
      final success = await _updateShiftUseCase(event.shift);
      if (success) {
        emit(const ShiftOperationSuccess(
            message: 'Turno atualizado com sucesso!'));
        add(LoadShiftsEvent());
      } else {
        emit(const ShiftOperationFailure(
            message: 'Falha ao atualizar turno: Nenhuma alteração realizada.'));
      }
    } catch (e) {
      emit(ShiftOperationFailure(
          message: 'Falha ao atualizar turno: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteShift(
    DeleteShiftEvent event,
    Emitter<ShiftState> emit,
  ) async {
    emit(ShiftLoading());
    try {
      final success = await _deleteShiftUseCase(event.id);
      if (success) {
        emit(const ShiftOperationSuccess(
            message: 'Turno excluído com sucesso!'));
        add(LoadShiftsEvent());
      } else {
        emit(const ShiftOperationFailure(
            message: 'Falha ao excluir turno: Nenhuma alteração realizada.'));
      }
    } catch (e) {
      emit(ShiftOperationFailure(
          message: 'Falha ao excluir turno: ${e.toString()}'));
    }
  }
}