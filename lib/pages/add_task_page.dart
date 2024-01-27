import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_flutter/bloc/add_task/add_task_bloc.dart';
import 'package:study_flutter/bloc/get_task/get_task_bloc.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Add Task",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.brown,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'description',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<AddTaskBloc, AddTaskState>(
            listener: ((context, state) {
              if (state is AddTaskSuccess) {
                context.read<GetTaskBloc>().add(DoGetAllTaskEvent());
                Navigator.pop(context);
              }
              if (state is AddTaskFailure) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            }),
            builder: ((context, state) {
              if (state is AddTaskLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ElevatedButton(
                  onPressed: () {
                    context.read<AddTaskBloc>().add(DoAddTaskEvent(
                        titleController.text, descriptionController.text));
                  },
                  child: Text("Add"));
            }),
          )
        ],
      ),
    );
  }
}
