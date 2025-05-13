import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_bloc.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_event.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_state.dart';
import 'package:maos_limpas/presentation/pages/settings/shift/shift_form_page.dart';

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos'),
      ),
      body: BlocConsumer<ShiftBloc, ShiftState>(
        listener: (context, state) {
          if (state is ShiftOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ShiftOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ShiftInitial) {
            context.read<ShiftBloc>().add(LoadShiftsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShiftLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShiftsLoaded) {
            return _buildShiftsList(context, state.shifts);
          } else {
            return _buildShiftsList(context, []);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToShiftForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildShiftsList(BuildContext context, List<Shift> shifts) {
    if (shifts.isEmpty) {
      return const Center(
        child: Text('Nenhum turno cadastrado'),
      );
    }

    return ListView.builder(
      itemCount: shifts.length,
      itemBuilder: (context, index) {
        final shift = shifts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(shift.name),
            subtitle: shift.startTime != null && shift.endTime != null
                ? Text('${shift.startTime} - ${shift.endTime}')
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateToShiftForm(context, shift),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmation(context, shift),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToShiftForm(BuildContext context, [Shift? shift]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShiftFormPage(shift: shift),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Shift shift) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja realmente excluir o turno "${shift.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ShiftBloc>().add(DeleteShiftEvent(id: shift.id));
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}