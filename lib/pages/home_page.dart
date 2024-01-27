import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter/bloc/get_task/get_task_bloc.dart';
import 'package:study_flutter/pages/add_task_page.dart';
import 'package:study_flutter/pages/detail_task_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetTaskBloc>().add(DoGetAllTaskEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        automaticallyImplyLeading: false,
        title: const Text(
          "Task List",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
      ),
      body: BlocBuilder<GetTaskBloc, GetTaskState>(
        builder: (context, state) {
          if (state is GetTaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetTaskFailure) {
            return Center(
              child: Text(state.messsage),
            );
          } else if (state is GetTaskInitial) {
            return const Center(
              child: Text("No data"),
            );
          } else {
            final task = (state as GetTaskSuccess).tasks;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              itemCount: task.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailTaskPage(task: task[index]);
                    }));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(task[index].attributes.title),
                      leading: Text(task[index].attributes.description),
                      trailing: const Icon(Icons.check_circle),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTaskPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
