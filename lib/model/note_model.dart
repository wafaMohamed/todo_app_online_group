class Todo {
  int? id;
  String name;
  String description;
  DateTime dateTime;

  Todo({
    this.id,
    required this.name,
    required this.description,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
