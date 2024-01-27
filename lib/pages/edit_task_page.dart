// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:study_flutter/data/datasources/task_remote_datasources.dart';
import 'package:study_flutter/data/model/add_task_request_model.dart';
import 'package:study_flutter/data/model/task_response_model.dart';
import 'package:study_flutter/pages/home_page.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({super.key, required this.task});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final titlecontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();

  @override
  void initState() {
    titlecontroller.text = widget.task.attributes.title;
    descriptioncontroller.text = widget.task.attributes.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          "Edit Task",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        children: [
          TextField(
            controller: titlecontroller,
            decoration: const InputDecoration(
                hintText: "Title", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: descriptioncontroller,
            decoration: const InputDecoration(
                hintText: "Description", border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                final newModel = AddTaskRequestModel(
                    data: Data(
                        title: titlecontroller.text,
                        description: descriptioncontroller.text));

                await TaskRemoteDataSource()
                    .updateTask(widget.task.id, newModel);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const HomePageScreen();
                }));
              },
              child: const Text("Edit"))
        ],
      ),
    );
  }
}
