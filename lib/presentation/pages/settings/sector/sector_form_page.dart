import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/sector.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_bloc.dart';
import 'package:maos_limpas/presentation/bloc/sector/sector_event.dart';

class SectorFormPage extends StatefulWidget {
  final Sector? sector;

  const SectorFormPage({Key? key, this.sector}) : super(key: key);

  @override
  State<SectorFormPage> createState() => _SectorFormPageState();
}

class _SectorFormPageState extends State<SectorFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool get _isEditing => widget.sector != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nameController.text = widget.sector!.name;
      _descriptionController.text = widget.sector!.description ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Setor' : 'Novo Setor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, informe o nome do setor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _isEditing ? 'Atualizar' : 'Salvar',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isEditing) {
        final updatedSector = Sector(
          id: widget.sector!.id,
          name: _nameController.text,
          description: _descriptionController.text.isEmpty
              ? null
              : _descriptionController.text,
          active: widget.sector!.active,
        );
        context
            .read<SectorBloc>()
            .add(UpdateSectorEvent(sector: updatedSector));
      } else {
        context.read<SectorBloc>().add(
              CreateSectorEvent(
                name: _nameController.text,
                description: _descriptionController.text.isEmpty
                    ? null
                    : _descriptionController.text,
              ),
            );
      }
      Navigator.pop(context);
    }
  }
}