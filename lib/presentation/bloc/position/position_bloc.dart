import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/position.dart';
import 'package:maos_limpas/domain/usecases/position/create_position_usecase.dart';
import 'package:maos_limpas/domain/usecases/position/delete_position_usecase.dart';
import 'package:maos_limpas/domain/usecases/position/get_positions_usecase.dart';
import 'package:maos_limpas/domain/usecases/position/update_position_usecase.dart';
import 'package:maos_limpas/presentation/bloc/position/position_event.dart';
import 'package:maos_limpas/presentation/bloc/position/position_state.dart';

class PositionBloc extends Bloc<PositionEvent, PositionState> {
  final GetPositionsUseCase _getPositionsUseCase;
  final CreatePositionUseCase _createPositionUseCase;
  final UpdatePositionUseCase _updatePositionUseCase;
  final DeletePositionUseCase _deletePositionUseCase;

  PositionBloc({
    required GetPositionsUseCase getPositionsUseCase,
    required CreatePositionUseCase createPositionUseCase,
    required UpdatePositionUseCase updatePositionUseCase,
    required DeletePositionUseCase deletePositionUseCase,
  })  : _getPositionsUseCase = getPositionsUseCase,
        _createPositionUseCase = createPositionUseCase,
        _updatePositionUseCase = updatePositionUseCase,
        _deletePositionUseCase = deletePositionUseCase,
        super(PositionInitial()) {
    on<LoadPositionsEvent>(_onLoadPositions);
    on<CreatePositionEvent>(_onCreatePosition);
    on<UpdatePositionEvent>(_onUpdatePosition);
    on<DeletePositionEvent>(_onDeletePosition);
  }

  Future<void> _onLoadPositions(
    LoadPositionsEvent event,
    Emitter<PositionState> emit,
  ) async {
    emit(PositionLoading());
    try {
      final positions = await _getPositionsUseCase();
      emit(PositionsLoaded(positions: positions));
    } catch (e) {
      emit(PositionOperationFailure(
          message: 'Falha ao carregar cargos: ${e.toString()}'));
    }
  }

  Future<void> _onCreatePosition(
    CreatePositionEvent event,
    Emitter<PositionState> emit,
  ) async {
    emit(PositionLoading());
    try {
      final position = Position(
        id: '',
        name: event.name,
        description: event.description,
      );
      await _createPositionUseCase(position);
      emit(const PositionOperationSuccess(message: 'Cargo criado com sucesso!'));
      add(LoadPositionsEvent());
    } catch (e) {
      emit(PositionOperationFailure(
          message: 'Falha ao criar cargo: ${e.toString()}'));
    }
  }

  Future<void> _onUpdatePosition(
    UpdatePositionEvent event,
    Emitter<PositionState> emit,
  ) async {
    emit(PositionLoading());
    try {
      final success = await _updatePositionUseCase(event.position);
      if (success) {
        emit(const PositionOperationSuccess(
            message: 'Cargo atualizado com sucesso!'));
        add(LoadPositionsEvent());
      } else {
        emit(const PositionOperationFailure(
            message: 'Falha ao atualizar cargo: Nenhuma alteração realizada.'));
      }
    } catch (e) {
      emit(PositionOperationFailure(
          message: 'Falha ao atualizar cargo: ${e.toString()}'));
    }
  }

  Future<void> _onDeletePosition(
    DeletePositionEvent event,
    Emitter<PositionState> emit,
  ) async {
    emit(PositionLoading());
    try {
      final success = await _deletePositionUseCase(event.id);
      if (success) {
        emit(const PositionOperationSuccess(
            message: 'Cargo excluído com sucesso!'));
        add(LoadPositionsEvent());
      } else {
        emit(const PositionOperationFailure(
            message: 'Falha ao excluir cargo: Nenhuma alteração realizada.'));
      }
    } catch (e) {
      emit(PositionOperationFailure(
          message: 'Falha ao excluir cargo: ${e.toString()}'));
    }
  }
}