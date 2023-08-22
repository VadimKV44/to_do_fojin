import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_fojin/bloc/tasks_cubit/tasks_cubit.dart';
import 'package:to_do_fojin/screens/home_screen.dart';
import 'package:to_do_fojin/services/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TasksCubit>(
      create: (context) => TasksCubit(),
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
