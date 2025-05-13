import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maos_limpas/domain/entities/shift.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_bloc.dart';
import 'package:maos_limpas/presentation/bloc/shift/shift_event.dart';

class ShiftFormPage extends StatefulWidget {
  final Shift? shift;

  const ShiftFormPage({Key? key, this.shift}) : super(key: key);

  @override
  State<ShiftFormPage> createState() => _ShiftFormPageState();
}

class _ShiftFormPageState extends State<ShiftFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();

  bool get _isEditing => widget.shift != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nameController.text = widget.shift!.name;
      _startTimeController.text = widget.shift!.startTime ?? '';
      _endTimeController.text = widget.shift!.endTime ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Turno' : 'Novo Turno'),
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
                    return 'Por favor, informe o nome do turno';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startTimeController,
                decoration: const InputDecoration(
                  labelText: 'Horário de Início',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => _selectTime(context, _startTimeController),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _endTimeController,
                decoration: const InputDecoration(
                  labelText: 'Horário de Término',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.access_time),
                ),
                readOnly: true,
                onTap: () => _selectTime(context, _endTimeController),
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

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_isEditing) {
        final updatedShift = Shift(
          id: widget.shift!.id,
          name: _nameController.text,
          startTime: _startTimeController.text.isEmpty
              ? null
              : _startTimeController.text,
          endTime:
              _endTimeController.text.isEmpty ? null : _endTimeController.text,
          active: widget.shift!.active,
        );
        context.read<ShiftBloc>().add(UpdateShiftEvent(shift: updatedShift));
      } else {
        context.read<ShiftBloc>().add(
              CreateShiftEvent(
                name: _nameController.text,
                startTime: _startTimeController.text.isEmpty
                    ? null
                    : _startTimeController.text,
                endTime: _endTimeController.text.isEmpty
                    ? null
                    : _endTimeController.text,
              ),
            );
      }
      Navigator.pop(context);
    }
  }
}