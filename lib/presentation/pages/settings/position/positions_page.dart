import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/position.dart';
import 'package:maos_limpas/presentation/bloc/position/position_bloc.dart';
import 'package:maos_limpas/presentation/bloc/position/position_event.dart';
import 'package:maos_limpas/presentation/bloc/position/position_state.dart';
import 'package:maos_limpas/presentation/pages/settings/position/position_form_page.dart';

class PositionsPage extends StatelessWidget {
  const PositionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cargos'),
      ),
      body: BlocConsumer<PositionBloc, PositionState>(
        listener: (context, state) {
          if (state is PositionOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is PositionOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is PositionInitial) {
            context.read<PositionBloc>().add(LoadPositionsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is PositionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PositionsLoaded) {
            return _buildPositionsList(context, state.positions);
          } else {
            return _buildPositionsList(context, []);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToPositionForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildPositionsList(BuildContext context, List<Position> positions) {
    if (positions.isEmpty) {
      return const Center(
        child: Text('Nenhum cargo cadastrado'),
      );
    }

    return ListView.builder(
      itemCount: positions.length,
      itemBuilder: (context, index) {
        final position = positions[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(position.name),
            subtitle: position.description != null
                ? Text(position.description!)
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateToPositionForm(context, position),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmation(context, position),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToPositionForm(BuildContext context, [Position? position]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PositionFormPage(position: position),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Position position) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja realmente excluir o cargo "${position.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<PositionBloc>()
                  .add(DeletePositionEvent(id: position.id));
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}