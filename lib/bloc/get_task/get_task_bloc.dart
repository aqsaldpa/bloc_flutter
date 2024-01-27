import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:study_flutter/data/datasources/task_remote_datasources.dart';
import 'package:study_flutter/data/model/task_response_model.dart';

part 'get_task_event.dart';
part 'get_task_state.dart';

class GetTaskBloc extends Bloc<GetTaskEvent, GetTaskState> {
  final TaskRemoteDataSource taskRemoteDataSource;
  GetTaskBloc(this.taskRemoteDataSource) : super(GetTaskInitial()) {
    on<DoGetAllTaskEvent>(
      (event, emit) async {
        emit(GetTaskLoading());
        await Future.delayed(const Duration(seconds: 2));
        try {
          final model = await taskRemoteDataSource.getTask();
          emit(GetTaskSuccess(model.data));
        } catch (e) {
          emit(GetTaskFailure(e.toString()));
        }
      },
    );
  }
}
