import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maos_limpas/di/injection_container.dart';
import 'package:maos_limpas/presentation/bloc/audit_setup/audit_setup_bloc.dart';
import 'package:maos_limpas/presentation/bloc/position/position_bloc.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_bloc.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_bloc.dart';
import 'package:maos_limpas/presentation/pages/audit/sector_selection_page.dart';
import 'package:maos_limpas/presentation/pages/home/home_page.dart';
import 'package:maos_limpas/presentation/pages/settings/position/positions_page.dart';
import 'package:maos_limpas/presentation/pages/settings/sector/sectors_page.dart';
import 'package:maos_limpas/presentation/pages/settings/settings_page.dart';
import 'package:maos_limpas/presentation/pages/settings/shift/shifts_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/audit/setup',
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuditSetupBloc>(),
        child: const SectorSelectionPage(),
      ),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
      routes: [
        GoRoute(
          path: 'sectors',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<SectorBloc>(),
            child: const SectorsPage(),
          ),
        ),
        GoRoute(
          path: 'shifts',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<ShiftBloc>(),
            child: const ShiftsPage(),
          ),
        ),
        GoRoute(
          path: 'positions',
          builder: (context, state) => BlocProvider(
            create: (context) => sl<PositionBloc>(),
            child: const PositionsPage(),
          ),
        ),
      ],
    ),
  ],
);