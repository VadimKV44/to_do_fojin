import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:to_do_fojin/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_fojin/consts/colors.dart';
import 'package:to_do_fojin/consts/strings.dart';
import 'package:to_do_fojin/consts/styles.dart';
import 'package:to_do_fojin/services/notification_service.dart';
import 'package:to_do_fojin/widgets/custom_text_field_widget.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _taskController = TextEditingController();

  DateTime? dateTime;

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            BlocProvider.of<TasksCubit>(context).images.clear();
            return true;
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
              backgroundColor: MainColors.kWhiteColor1,
              appBar: AppBar(
                elevation: 2,
                backgroundColor: MainColors.kWhiteColor1,
                title: Text(
                  Strings.creatingTask,
                  style: MainStyles.kBlackColor1W700(26.0),
                ),
                centerTitle: true,
                leading: InkWell(
                  onTap: () async {
                    dateTime = await showOmniDateTimePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1600).subtract(const Duration(days: 3652)),
                      lastDate: DateTime.now().add(
                        const Duration(days: 3652),
                      ),
                      is24HourMode: false,
                      isShowSeconds: false,
                      minutesInterval: 1,
                      secondsInterval: 1,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      constraints: const BoxConstraints(maxWidth: 350, maxHeight: 650),
                      transitionBuilder: (context, anim1, anim2, child) {
                        return FadeTransition(
                          opacity: anim1.drive(
                            Tween(begin: 0, end: 1),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                    );
                    setState(() {});
                  },
                  child: const Icon(
                    Icons.access_alarm_outlined,
                    color: MainColors.kBlackColor1,
                    size: 30.0,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                      onTap: () {
                        if (dateTime != null) {
                          NotificationService().showNotification(title: 'Напоминание', body: _taskController.text, scheduledDate: dateTime!);
                        }
                        BlocProvider.of<TasksCubit>(context).saveNewTaskInTaskBox(
                          _taskController.text,
                          dateTime != null ? DateFormat('kk:mm yyyy.MM.dd').format(dateTime!).toString() : '',
                        );
                        BlocProvider.of<TasksCubit>(context).images.clear();
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.save,
                        color: Colors.black,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
                  child: Column(
                    children: [
                      dateTime != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Text(
                                Strings.reminder + DateFormat('kk:mm yyyy.MM.dd').format(dateTime!).toString(),
                                style: MainStyles.kBlackColor1W500(20.0),
                              ),
                            )
                          : const SizedBox(),
                      CustomTextFieldWidget(
                        controller: _taskController,
                      ),
                      const SizedBox(height: 20.0),
                      BlocProvider.of<TasksCubit>(context).images.length < 5
                          ? Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<TasksCubit>(context).takeAPicture();
                                    },
                                    child: const Icon(Icons.camera_alt, size: 30.0),
                                  ),
                                  const SizedBox(width: 20.0),
                                  InkWell(
                                    onTap: () {
                                      BlocProvider.of<TasksCubit>(context).selectImageFromGallery();
                                    },
                                    child: const Icon(Icons.photo_library, size: 30.0),
                                  ),
                                ],
                              ),
                          )
                          : const SizedBox(),
                      BlocProvider.of<TasksCubit>(context).images.isNotEmpty
                          ? Expanded(
                              child: GridView.builder(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                                itemCount: BlocProvider.of<TasksCubit>(context).images.length,
                                itemBuilder: (context, index) {
                                  List<XFile> images = BlocProvider.of<TasksCubit>(context).images;
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.file(
                                        File(images[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
