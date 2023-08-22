import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_fojin/models/task_model.dart';
import 'package:uuid/uuid.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  List<TaskModel> tasks = [];

  var uuid = Uuid();

  void createTask(String text, String reminderTime) {
    if (text.isNotEmpty) {
      tasks.add(
        TaskModel(
          text: text,
          id: uuid.v1(),
          reminderTime: reminderTime,
        ),
      );
      emit(TasksInitial());
    }
  }

  void deleteTask(String id) {
    tasks.removeWhere((item) => item.id == id);
    emit(TasksInitial());
  }
}
