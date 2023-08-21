import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  List<String> tasks = [];

  void createTask(String text) {
    if (text.isNotEmpty) {
      tasks.add(text);
      emit(TasksInitial());
    }
  }

  void deleteTask(String text) {
    tasks.removeWhere((item) => item == text);
    emit(TasksInitial());
  }
}
