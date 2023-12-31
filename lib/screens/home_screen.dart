import 'package:device_orientation/device_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:to_do_fojin/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_fojin/consts/colors.dart';
import 'package:to_do_fojin/consts/strings.dart';
import 'package:to_do_fojin/consts/styles.dart';
import 'package:to_do_fojin/models/task_model.dart';
import 'package:to_do_fojin/screens/create_task_screen.dart';
import 'package:to_do_fojin/screens/delete_task_screen.dart';
import 'package:to_do_fojin/utils/get_device_type.dart';
import 'package:to_do_fojin/widgets/custom_scaffold_message.dart';
import 'package:to_do_fojin/widgets/task_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Заряд батареи $result %';
    } on PlatformException catch (e) {
      batteryLevel = "Не удалось определить уровень заряда батареи: '${e.message}'";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
    deviceOrientation$.listen((orientation) {
      if (orientation.index != 0) {
        showCustomScaffoldMessage(context);
      }
    });
    BlocProvider.of<TasksCubit>(context).readFromTaskBox();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MainColors.kWhiteColor1,
          appBar: AppBar(
            elevation: 2,
            backgroundColor: MainColors.kWhiteColor1,
            title: Column(
              children: [
                Text(
                  Strings.appForYourTodo,
                  style: MainStyles.kBlackColor1W700(20.0),
                ),
                Text(
                  _batteryLevel,
                  style: TextStyle(color: Colors.green[300], fontWeight: FontWeight.w600, fontSize: 20.0),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateTaskScreen()));
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 40.0,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: BlocProvider.of<TasksCubit>(context).tasks.isNotEmpty
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        flexibleSpace: FlexibleSpaceBar(
                          centerTitle: true,
                          titlePadding: const EdgeInsets.only(top: 1.0, bottom: 10.0),
                          title: Text(
                            Strings.allTasks,
                            style: MainStyles.kBlackColor1W700(40.0),
                          ),
                        ),
                        expandedHeight: 100.0,
                        elevation: 0,
                        backgroundColor: MainColors.kWhiteColor1,
                        centerTitle: true,
                        floating: true,
                        pinned: true,
                      ),
                      SliverToBoxAdapter(
                        child: MasonryGridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          mainAxisSpacing: 0.0,
                          crossAxisSpacing: 10.0,
                          crossAxisCount: getDeviceType() == 'phone' ? 1 : 2,
                          itemCount: BlocProvider.of<TasksCubit>(context).tasks.length,
                          itemBuilder: (context, index) {
                            List<TaskModel> tasksList = BlocProvider.of<TasksCubit>(context).tasks;
                            return TaskItemWidget(
                              text: tasksList[index].text ?? '',
                              reminderTime: tasksList[index].reminderTime ?? '',
                              pathsToPictures: tasksList[index].images ?? [],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeleteTaskScreen(
                                      taskText: tasksList[index].text ?? '',
                                      taskId: tasksList[index].id ?? '',
                                      pathsToPictures: tasksList[index].images ?? [],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      Strings.noTasks,
                      style: MainStyles.kGreyColor1W700(40.0),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
