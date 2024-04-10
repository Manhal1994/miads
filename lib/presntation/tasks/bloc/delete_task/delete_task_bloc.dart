import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:maids/data/models/task.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/delete_task_use_case.dart';

part 'delete_task_event.dart';
part 'delete_task_state.dart';

class DeleteTaskBloc extends Bloc<DeleteTaskEvent, DeleteTaskState> {
  final DeleteTaskUseCase _deleteTaskUseCase;

  DeleteTaskBloc(this._deleteTaskUseCase) : super(DeleteTaskInitial()) {
    on<DeleteTaskEvent>((event, emit) async{
      if(event is DeleteTask){
        try {
          emit(DeleteTaskLoading());
          await _deleteTaskUseCase.call(event.taskModel);
          emit(DeleteTaskSuccess());
        }
        catch(e,t){
          debugPrint(e.toString());
          debugPrintStack(stackTrace: t);
        }
      }
    });
  }
}
