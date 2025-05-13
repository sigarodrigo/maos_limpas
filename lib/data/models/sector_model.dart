import 'package:maos_limpas/domain/entities/sector.dart';

class SectorModel extends Sector {
  final int syncStatus;

  SectorModel({
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

  factory SectorModel.fromJson(Map<String, dynamic> json) {
    return SectorModel(
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

  SectorModel copyWith({
    String? id,
    String? name,
    String? description,
    bool? active,
    int? syncStatus,
  }) {
    return SectorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      active: active ?? this.active,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}