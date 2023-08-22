import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_fojin/models/task_model.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  List<TaskModel> tasks = [];

  int taskId = 0;

  void createTask(String text) {
    if (text.isNotEmpty) {
      if (tasks.isEmpty) {
        taskId = 0;
        taskId = taskId + 1;
      } else {
        taskId = taskId + 1;
      }

      tasks.add(
        TaskModel(
          text: text,
          id: taskId,
        ),
      );
      emit(TasksInitial());
    }
  }

  void deleteTask(int id) {
    tasks.removeWhere((item) => item.id == id);
    emit(TasksInitial());
  }
}
