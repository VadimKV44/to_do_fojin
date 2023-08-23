import 'package:hive/hive.dart';
import 'package:to_do_fojin/local_storage/adapters/task_adapter.dart';
import 'package:to_do_fojin/models/task_model.dart';

class HiveStorage {
  static Box<TaskModel> taskBox = Hive.box<TaskModel>('tasksBox');

  static Future<bool> openTaskBox() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }
    taskBox = await Hive.openBox('tasksBox');
    return taskBox.isOpen;
  }

  static Iterable<TaskModel> readFromTaskBox() {
    Iterable<TaskModel> data = taskBox.values;
    return data;
  }

  static void saveNewTaskInTaskBox(String key, TaskModel task) async {
    await taskBox.put(key, task);
  }

  static void deleteFromTaskBox(String key) async {
    await taskBox.delete(key);
  }
}
