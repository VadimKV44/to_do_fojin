import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_fojin/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_fojin/consts/colors.dart';
import 'package:to_do_fojin/local_storage/hive_storage.dart';
import 'package:to_do_fojin/screens/home_screen.dart';
import 'package:to_do_fojin/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (context) => TasksCubit(),
      child: Builder(builder: (context) {
        return FutureBuilder(
          future: HiveStorage.openTaskBox(),
          builder: (context, snapshot) {
            return snapshot.data == true
                ? const MaterialApp(
                    home: HomeScreen(),
                  )
                : Container(
                    color: MainColors.kWhiteColor1,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
          },
        );
      }),
    );
  }
}

//
// BlocProvider.of<TasksCubit>(context).box.isOpen ? const MaterialApp(
// home: HomeScreen(),
// ) : const Center(
// child: CircularProgressIndicator(),
// ),
// );

// Builder(
// builder: (BuildContext context) {
// print(BlocProvider.of<TasksCubit>(context).box.isOpen);
// return BlocProvider.of<TasksCubit>(context).box.isOpen ? const MaterialApp(
// home: HomeScreen(),
// ) : const Center(
// child: CircularProgressIndicator(),
// );
// },
// )
