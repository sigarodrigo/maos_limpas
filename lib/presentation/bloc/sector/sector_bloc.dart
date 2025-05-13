import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/usecases/sector/create_sector_usecase.dart';
import 'package:maos_limpas/domain/usecases/sector/delete_sector_usecase.dart';
import 'package:maos_limpas/domain/usecases/sector/get_sectors_usecase.dart';
import 'package:maos_limpas/domain/usecases/sector/update_sector_usecase.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_event.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_state.dart';

class SectorBloc extends Bloc<SectorEvent, SectorState> {
  final GetSectorsUseCase _getSectorsUseCase;
  final CreateSectorUseCase _createSectorUseCase;
  final UpdateSectorUseCase _updateSectorUseCase;
  final DeleteSectorUseCase _deleteSectorUseCase;

  SectorBloc({
    required GetSectorsUseCase getSectorsUseCase,
    required CreateSectorUseCase createSectorUseCase,
    required UpdateSectorUseCase updateSectorUseCase,
    required DeleteSectorUseCase deleteSectorUseCase,
  })  : _getSectorsUseCase = getSectorsUseCase,
        _createSectorUseCase = createSectorUseCase,
        _updateSectorUseCase = updateSectorUseCase,
        _deleteSectorUseCase = deleteSectorUseCase,
        super(SectorInitial()) {
    on<LoadSectorsEvent>(_onLoadSectors);
    on<CreateSectorEvent>(_onCreateSector);
    on<UpdateSectorEvent>(_onUpdateSector);
    on<DeleteSectorEvent>(_onDeleteSector);
  }

  Future<void> _onLoadSectors(
    LoadSectorsEvent event,
    Emitter<SectorState> emit,
  ) async {
    emit(SectorLoading());
    try {
      final sectors = await _getSectorsUseCase();
      emit(SectorsLoaded(sectors: sectors));
    } catch (e) {
      emit(SectorOperationFailure(
          message: 'Falha ao carregar setores: ${e.toString()}'));
    }
  }

  Future<void> _onCreateSector(
    CreateSectorEvent event,
    Emitter<SectorState> emit,
  ) async {
    emit(SectorLoading());
    try {
      final sector = Sector(
        id: '',
        name: event.name,
        description: event.description,
      );
      await _createSectorUseCase(sector);
      emit(const SectorOperationSuccess(message: 'Setor criado com sucesso!'));
      add(LoadSectorsEvent());
    } catch (e) {
      emit(SectorOperationFailure(
          message: 'Falha ao criar setor: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateSector(
    UpdateSectorEvent event,
    Emitter<SectorState> emit,
  ) async {
    emit(SectorLoading());
    try {
      final success = await _updateSectorUseCase(event.sector);
      if (success) {
        emit(const SectorOperationSuccess(
            message: 'Setor atualizado com sucesso!'));
        add(LoadSectorsEvent());
      } else {
        emit(const SectorOperationFailure(
            message: 'Falha ao atualizar setor: Nenhuma alteração realizada.'));
      }
    } catch (e) {
      emit(SectorOperationFailure(
          message: 'Falha ao atualizar setor: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteSector(
    DeleteSectorEvent event,
    Emitter<SectorState> emit,
  ) async {
    emit(SectorLoading());
    try {
      final success = await _deleteSectorUseCase(event.id);
      if (success) {
        emit(const SectorOperationSuccess(
            message: 'Setor excluído com sucesso!'));
        add(LoadSectorsEvent());
      } else {
        emit(const SectorOperationFailure(
            message: 'Falha ao excluir setor: Nenhuma alteração realizada.'));
      }
    } catch (e) {
      emit(SectorOperationFailure(
          message: 'Falha ao excluir setor: ${e.toString()}'));
    }
  }
}