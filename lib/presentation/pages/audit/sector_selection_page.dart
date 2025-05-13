import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/presentation/bloc/audit_setup/audit_setup_bloc.dart';
import 'package:maos_limpas/presentation/bloc/audit_setup/audit_setup_event.dart';
import 'package:maos_limpas/presentation/bloc/audit_setup/audit_setup_state.dart';

class SectorSelectionPage extends StatelessWidget {
  const SectorSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecionar Setor e Turno'),
      ),
      body: BlocConsumer<AuditSetupBloc, AuditSetupState>(
        listener: (context, state) {
          if (state is AuditSetupFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuditSetupSuccess) {
            // Navegar para a tela de auditoria
            Navigator.pushReplacementNamed(
              context,
              '/audit',
              arguments: {
                'auditId': state.auditId,
                'sectorId': state.sectorId,
                'shiftId': state.shiftId,
              },
            );
          }
        },
        builder: (context, state) {
          if (state is AuditSetupInitial) {
            context.read<AuditSetupBloc>().add(LoadSectorsAndShiftsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuditSetupLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuditSetupLoaded) {
            return _buildSelectionForm(context, state);
          } else {
            return const Center(
              child: Text('Falha ao carregar dados. Tente novamente.'),
            );
          }
        },
      ),
    );
  }

  Widget _buildSelectionForm(BuildContext context, AuditSetupLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selecione o Setor',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectorDropdown(context, state),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selecione o Turno',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildShiftDropdown(context, state),
                ],
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: state.selectedSectorId != null &&
                    state.selectedShiftId != null
                ? () {
                    context.read<AuditSetupBloc>().add(
                          StartAuditEvent(
                            sectorId: state.selectedSectorId!,
                            shiftId: state.selectedShiftId!,
                          ),
                        );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              disabledBackgroundColor: Colors.grey.shade300,
            ),
            child: const Text(
              'Iniciar Auditoria',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectorDropdown(BuildContext context, AuditSetupLoaded state) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      value: state.selectedSectorId,
      hint: const Text('Selecione um setor'),
      isExpanded: true,
      items: state.sectors.map((Sector sector) {
        return DropdownMenuItem<String>(
          value: sector.id,
          child: Text(sector.name),
        );
      }).toList(),
      onChanged: (String? sectorId) {
        if (sectorId != null) {
          context
              .read<AuditSetupBloc>()
              .add(SelectSectorEvent(sectorId: sectorId));
        }
      },
    );
  }

  Widget _buildShiftDropdown(BuildContext context, AuditSetupLoaded state) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      value: state.selectedShiftId,
      hint: const Text('Selecione um turno'),
      isExpanded: true,
      items: state.shifts.map((Shift shift) {
        return DropdownMenuItem<String>(
          value: shift.id,
          child: Text(shift.name),
        );
      }).toList(),
      onChanged: (String? shiftId) {
        if (shiftId != null) {
          context
              .read<AuditSetupBloc>()
              .add(SelectShiftEvent(shiftId: shiftId));
        }
      },
    );
  }
}