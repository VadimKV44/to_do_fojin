class TaskModel {
  TaskModel({
    required this.text,
    required this.id,
    this.reminderTime,
  });

  final String text;
  final String id;
  final String? reminderTime;
}
