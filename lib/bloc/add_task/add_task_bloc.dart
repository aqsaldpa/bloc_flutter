import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_flutter/data/datasources/task_remote_datasources.dart';
import 'package:study_flutter/data/model/add_task_request_model.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final TaskRemoteDataSource taskRemoteDataSource;
  AddTaskBloc(this.taskRemoteDataSource) : super(AddTaskInitial()) {
    on<DoAddTaskEvent>((event, emit) async {
      emit(AddTaskLoading());
      await Future.delayed(const Duration(seconds: 2));
      try {
        await taskRemoteDataSource.addTask(
          AddTaskRequestModel(
            data: Data(title: event.title, description: event.description),
          ),
        );
        emit(AddTaskSuccess());
      } catch (e) {
        emit(AddTaskFailure(e.toString()));
      }
    });
  }
}
