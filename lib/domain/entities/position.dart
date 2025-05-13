class Position {
  final String id;
  final String name;
  final String? description;
  final bool active;

  Position({
    required this.id,
    required this.name,
    this.description,
    this.active = true,
  });
}