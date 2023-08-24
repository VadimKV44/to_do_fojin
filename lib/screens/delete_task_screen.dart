import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_fojin/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_fojin/consts/colors.dart';
import 'package:to_do_fojin/consts/strings.dart';
import 'package:to_do_fojin/consts/styles.dart';
import 'package:to_do_fojin/widgets/custom_button_widget.dart';

class DeleteTaskScreen extends StatelessWidget {
  const DeleteTaskScreen({
    super.key,
    required this.taskText,
    required this.taskId,
  });

  final String taskText;
  final String taskId;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TasksCubit, TasksState>(
      listener: (context, state) {
        if (state is TasksInitial) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: MainColors.kWhiteColor1,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: MainColors.kWhiteColor1,
          title: Text(
            'Задача $taskId',
            style: MainStyles.kBlackColor1W700(26.0),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  taskText,
                  style: MainStyles.kBlackColor1W500(30.0),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButtonWidget(
                    onTap: () {
                      BlocProvider.of<TasksCubit>(context).deleteFromTaskBox(taskId);
                    },
                    text: Strings.deleteTask,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
