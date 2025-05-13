import 'package:get_it/get_it.dart';
import 'package:maos_limpas/data/datasources/local/database_helper.dart';
import 'package:maos_limpas/data/datasources/local/position_local_datasource.dart';
import 'package:maos_limpas/data/datasources/local/sector_local_datasource.dart';
import 'package:maos_limpas/data/datasources/local/shift_local_datasource.dart';
import 'package:maos_limpas/data/repositories/position_repository_impl.dart';
import 'package:maos_limpas/data/repositories/sector_repository_impl.dart';
import 'package:maos_limpas/data/repositories/shift_repository_impl.dart';
import 'package:maos_limpas/domain/repositories/position_repository.dart';
import 'package:maos_limpas/domain/repositories/sector_repository.dart';
import 'package:maos_limpas/domain/repositories/shift_repository.dart';
import 'package:maos_limpas/domain/usecases/position/create_position_usecase.dart';
import 'package:maos_limpas/domain/usecases/position/delete_position_usecase.dart';
import 'package:maos_limpas/domain/usecases/position/get_positions_usecase.dart';
import 'package:maos_limpas/domain/usecases/position/update_position_usecase.dart';
import 'package:maos_limpas/domain/usecases/sector/create_sector_usecase.dart';
import 'package:maos_limpas/domain/usecases/sector/delete_sector_usecase.dart';
import 'package:maos_limpas/domain/usecases/sector/get_sectors_usecase.dart';
import 'package:maos_limpas/domain/usecases/sector/update_sector_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/create_shift_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/delete_shift_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/get_shifts_usecase.dart';
import 'package:maos_limpas/domain/usecases/shift/update_shift_usecase.dart';
import 'package:maos_limpas/presentation/bloc/audit_setup/audit_setup_bloc.dart';
import 'package:maos_limpas/presentation/bloc/position/position_bloc.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_bloc.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Database
  sl.registerLazySingleton(() => DatabaseHelper());

  // Data sources
  sl.registerLazySingleton<SectorLocalDataSource>(
    () => SectorLocalDataSourceImpl(databaseHelper: sl()),
  );
  sl.registerLazySingleton<ShiftLocalDataSource>(
    () => ShiftLocalDataSourceImpl(databaseHelper: sl()),
  );
  sl.registerLazySingleton<PositionLocalDataSource>(
    () => PositionLocalDataSourceImpl(databaseHelper: sl()),
  );

  // Repositories
  sl.registerLazySingleton<SectorRepository>(
    () => SectorRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<ShiftRepository>(
    () => ShiftRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<PositionRepository>(
    () => PositionRepositoryImpl(localDataSource: sl()),
  );

  // Use cases
  // Sector
  sl.registerLazySingleton(() => GetSectorsUseCase(sl()));
  sl.registerLazySingleton(() => CreateSectorUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSectorUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSectorUseCase(sl()));

  // Shift
  sl.registerLazySingleton(() => GetShiftsUseCase(sl()));
  sl.registerLazySingleton(() => CreateShiftUseCase(sl()));
  sl.registerLazySingleton(() => UpdateShiftUseCase(sl()));
  sl.registerLazySingleton(() => DeleteShiftUseCase(sl()));

  // Position
  sl.registerLazySingleton(() => GetPositionsUseCase(sl()));
  sl.registerLazySingleton(() => CreatePositionUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePositionUseCase(sl()));
  sl.registerLazySingleton(() => DeletePositionUseCase(sl()));

  // BLoCs
  sl.registerFactory(
    () => SectorBloc(
      getSectorsUseCase: sl(),
      createSectorUseCase: sl(),
      updateSectorUseCase: sl(),
      deleteSectorUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ShiftBloc(
      getShiftsUseCase: sl(),
      createShiftUseCase: sl(),
      updateShiftUseCase: sl(),
      deleteShiftUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => PositionBloc(
      getPositionsUseCase: sl(),
      createPositionUseCase: sl(),
      updatePositionUseCase: sl(),
      deletePositionUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => AuditSetupBloc(
      getSectorsUseCase: sl(),
      getShiftsUseCase: sl(),
    ),
  );
}