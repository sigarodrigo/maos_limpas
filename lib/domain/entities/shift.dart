class Shift {
  final String id;
  final String name;
  final String? startTime;
  final String? endTime;
  final bool active;

  Shift({
    required this.id,
    required this.name,
    this.startTime,
    this.endTime,
    this.active = true,
  });
}