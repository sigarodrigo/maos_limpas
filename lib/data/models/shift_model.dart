import 'package:maos_limpas/domain/entities/shift.dart';

class ShiftModel extends Shift {
  final int syncStatus;

  ShiftModel({
    required String id,
    required String name,
    String? startTime,
    String? endTime,
    bool active = true,
    this.syncStatus = 0,
  }) : super(
          id: id,
          name: name,
          startTime: startTime,
          endTime: endTime,
          active: active,
        );

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      id: json['id'],
      name: json['name'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      active: json['active'] == 1,
      syncStatus: json['sync_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'start_time': startTime,
      'end_time': endTime,
      'active': active ? 1 : 0,
      'sync_status': syncStatus,
    };
  }

  ShiftModel copyWith({
    String? id,
    String? name,
    String? startTime,
    String? endTime,
    bool? active,
    int? syncStatus,
  }) {
    return ShiftModel(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      active: active ?? this.active,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}