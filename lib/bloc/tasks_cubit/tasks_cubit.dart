import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  List<String> tasksList = [];

  void createTask(String text) {
    if (text.isNotEmpty) {
      tasksList.add(text);
      emit(TasksInitial());
    }
  }

  void deleteTask(String text) {
    tasksList.removeWhere((item) => item == text);
    emit(TasksInitial());
  }
}
