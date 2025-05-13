import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_bloc.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_event.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_state.dart';
import 'package:maos_limpas/presentation/pages/settings/sector/sector_form_page.dart';

class SectorsPage extends StatelessWidget {
  const SectorsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setores'),
      ),
      body: BlocConsumer<SectorBloc, SectorState>(
        listener: (context, state) {
          if (state is SectorOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is SectorOperationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SectorInitial) {
            context.read<SectorBloc>().add(LoadSectorsEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is SectorLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SectorsLoaded) {
            return _buildSectorsList(context, state.sectors);
          } else {
            return _buildSectorsList(context, []);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToSectorForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSectorsList(BuildContext context, List<Sector> sectors) {
    if (sectors.isEmpty) {
      return const Center(
        child: Text('Nenhum setor cadastrado'),
      );
    }

    return ListView.builder(
      itemCount: sectors.length,
      itemBuilder: (context, index) {
        final sector = sectors[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(sector.name),
            subtitle: sector.description != null
                ? Text(sector.description!)
                : null,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _navigateToSectorForm(context, sector),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _showDeleteConfirmation(context, sector),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToSectorForm(BuildContext context, [Sector? sector]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SectorFormPage(sector: sector),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Sector sector) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja realmente excluir o setor "${sector.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<SectorBloc>()
                  .add(DeleteSectorEvent(id: sector.id));
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}