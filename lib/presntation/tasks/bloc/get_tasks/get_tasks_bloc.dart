
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/page_data.dart';
import '../../../../data/models/task.dart';
import '../../../../domain/usecases/get_tasks_use_case.dart';

part 'get_tasks_event.dart';

part 'get_tasks_state.dart';

class GetTasksBloc extends Bloc<GetTasksEvent, GetTasksState> {
  final GetTasksUseCases _getTasksUseCases;

  GetTasksBloc(this._getTasksUseCases) : super(GetTasksInitial()) {
    on<GetTasksEvent>((event, emit) async {
      if (event is GetTasks) {
        try {
          emit(GetTasksLoading());
          final res = await _getTasksUseCases.call(
              limit: event.limit, skip: event.skip);
          emit(GetTasksSuccess(res));
        } catch (e) {
          emit(GetTasksError(message: "Something went wrong"));
        }
      }
    });
  }
}
