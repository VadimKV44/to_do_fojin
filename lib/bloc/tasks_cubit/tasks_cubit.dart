import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:to_do_fojin/local_storage/hive_storage.dart';
import 'package:to_do_fojin/models/task_model.dart';
import 'package:uuid/uuid.dart';
part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitial());

  List<TaskModel> tasks = [];

  var uuid = Uuid();

  final ImagePicker picker = ImagePicker();

  List<XFile> images = [];

  void selectImageFromGallery() async {
    if (images.length < 5) {
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        images.add(image);
      }
      emit(TasksInitial());
    }
  }

  void takePicture() async {
    if (images.length < 5) {
      XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        images.add(image);
      }
      emit(TasksInitial());
    }
  }

  void readFromTaskBox() async {
    tasks.addAll(HiveStorage.readFromTaskBox());
    emit(TasksInitial());
  }

  void saveNewTaskInTaskBox(String text, String reminderTime) {
    List<String> pathsToPictures = [];

    if (text.isNotEmpty || images.isNotEmpty) {
      for (var item in images) {
        pathsToPictures.add(item.path);
      }
      String id = uuid.v1();
      TaskModel task = TaskModel(text: text, id: id, reminderTime: reminderTime, images: pathsToPictures);
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
