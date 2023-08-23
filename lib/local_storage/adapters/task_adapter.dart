import 'package:hive/hive.dart';
import 'package:to_do_fojin/models/task_model.dart';

class TaskAdapter extends TypeAdapter<TaskModel> {
  @override
  final typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final String text = reader.readString();
    final String id = reader.readString();
    final String reminderTime = reader.readString();
    final List<String> images = reader.readStringList();
    return TaskModel(text: text, id: id, reminderTime: reminderTime, images: images);
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer.writeString(obj.text ?? '');
    writer.writeString(obj.id ?? '');
    writer.writeString(obj.reminderTime ?? '');
    writer.writeStringList(obj.images ?? []);
  }
}
