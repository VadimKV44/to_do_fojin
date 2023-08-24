class TaskModel {
  TaskModel({
    this.text,
    this.id,
    this.reminderTime,
    this.images,
  });

  final String? text;
  final String? id;
  final String? reminderTime;
  final List<String>? images;
}