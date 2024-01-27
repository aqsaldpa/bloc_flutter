import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter/bloc/add_task/add_task_bloc.dart';
import 'package:study_flutter/bloc/get_task/get_task_bloc.dart';
import 'package:study_flutter/data/datasources/task_remote_datasources.dart';
import 'package:study_flutter/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetTaskBloc(TaskRemoteDataSource())),
        BlocProvider(create: (context) => AddTaskBloc(TaskRemoteDataSource())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePageScreen(),
      ),
    );
  }
}
