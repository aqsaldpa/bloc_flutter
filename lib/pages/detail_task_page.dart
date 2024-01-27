// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:study_flutter/data/datasources/task_remote_datasources.dart';
import 'package:study_flutter/data/model/task_response_model.dart';
import 'package:study_flutter/pages/edit_task_page.dart';
import 'package:study_flutter/pages/home_page.dart';

class DetailTaskPage extends StatefulWidget {
  final Task task;
  const DetailTaskPage({super.key, required this.task});

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          "Detail Task",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        children: [
          Text("Title : ${widget.task.attributes.title}"),
          const SizedBox(height: 10),
          Text("Description : ${widget.task.attributes.description}"),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Confirmation"),
                          content: const Text(
                              "Are you sure want to delete this task ?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("No"),
                            ),
                            TextButton(
                              onPressed: () async {
                                await TaskRemoteDataSource()
                                    .deleteTask(widget.task.id);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const HomePageScreen();
                                }));
                              },
                              child: const Text("Yes"),
                            ),
                          ],
                        );
                      });
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white),
                child: const Text(
                  "Delete",
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return EditTaskPage(
                      task: widget.task,
                    );
                  }));
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white),
                child: const Text(
                  "Edit",
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
