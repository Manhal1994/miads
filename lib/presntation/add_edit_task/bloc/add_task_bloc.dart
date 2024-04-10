import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:maids/core/error/app_error.dart';
import 'package:maids/core/error/validator.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecases/create_task_use_case.dart';
import '../../../domain/usecases/update_task_use_case.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;


  EditTaskBloc(this._createTaskUseCase, this._updateTaskUseCase) : super(AddTaskInitial()) {
    on<EditTaskEvent>((event, emit) async{
      if(event is CreateTask){
        emit(AddTaskLoading());
        try {
          if(AddTaskValidator(todo: event.name).validate()) {
            final res = await _createTaskUseCase.call(todo: event.name);
            emit(AddTaskSuccess(TaskModel(todo: res.todo!, id: res.id, me: true)));
          }
          else {
            throw AppError(message: "Task desceiption schould contain 3 characters at lease");
          }

        }
        on AppError catch (e,t) {
          debugPrintStack(stackTrace: t);
          debugPrint(e.toString());
          emit(AddTaskError(e.message));
        }
      }
      if(event is UpdateTask){
        emit(AddTaskLoading());
        try {
          if(AddTaskValidator(todo: event.taskModel.todo).validate()) {
            final res = await _updateTaskUseCase.call(
                taskModel: event.taskModel);
            emit(AddTaskSuccess(TaskModel(id: event.taskModel.id, todo: res.todo!)));
          }
          else {
            throw AppError(message: "Task desceiption schould contain 3 characters at lease");

          }
        }
        on AppError catch(e,t) {
          debugPrintStack(stackTrace: t);
          debugPrint(e.toString());
          emit(AddTaskError(e.message));
        }
      }
    });
  }
}
