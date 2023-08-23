import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_fojin/local_storage/hive_storage.dart';
import 'package:to_do_fojin/models/task_model.dart';
import 'package:uuid/uuid.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  List<TaskModel> tasks = [];

  var uuid = Uuid();

  void readFromTaskBox() async {
    tasks.addAll(HiveStorage.readFromTaskBox());
    emit(TasksInitial());
  }

  void saveNewTaskInTaskBox(String text, String reminderTime) {
    if (text.isNotEmpty) {
      String id = uuid.v1();
      TaskModel task = TaskModel(text: text, id: id, reminderTime: reminderTime);
      HiveStorage.saveNewTaskInTaskBox(id, task);
      tasks.add(task);
    }
    emit(TasksInitial());
  }

  void deleteFromTaskBox(String key) {
    HiveStorage.deleteFromTaskBox(key);
    tasks.removeWhere((element) => element.id == key);
    emit(TasksInitial());
  }
}
