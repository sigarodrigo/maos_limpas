import 'package:maos_limpas/domain/entities/position.dart';

class PositionModel extends Position {
  final int syncStatus;

  PositionModel({
    required String id,
    required String name,
    String? description,
    bool active = true,
    this.syncStatus = 0,
  }) : super(
          id: id,
          name: name,
          description: description,
          active: active,
        );

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      active: json['active'] == 1,
      syncStatus: json['sync_status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'active': active ? 1 : 0,
      'sync_status': syncStatus,
    };
  }

  PositionModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? active,
    int? syncStatus,
  }) {
    return PositionModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      active: active ?? this.active,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}