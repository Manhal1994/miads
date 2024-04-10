import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:maids/domain/enities/task_entity.dart';
import 'package:maids/presntation/add_edit_task/add_edit_task_page.dart';
import 'package:maids/presntation/tasks/bloc/delete_task/delete_task_bloc.dart';
import 'package:maids/presntation/tasks/widgets/task_item.dart';
import '../../core/enum/page_action.dart';
import '../../data/models/task.dart';
import '../add_edit_task/bloc/add_task_bloc.dart';
import 'bloc/get_tasks/get_tasks_bloc.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  int _skip = 0;
  int _page = 0;
  final int limit = 10;
  late final PagingController<int, TaskModel> _pagingController;

  @override
  void initState() {
    _pagingController = PagingController(firstPageKey: 1);
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<GetTasksBloc>(context)
          .add(GetTasks(limit: limit, skip: _skip));
      _skip = _skip + limit;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return  AddEditTaskPage(pageAction: PageAction.add,
                onAdd: (taskModel){
                _pagingController.itemList?.insert(0, taskModel);
                _pagingController.notifyListeners();
              },

              );
            }));
          },
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.all(16.w),
                child: BlocListener<GetTasksBloc, GetTasksState>(
                    listener: (context, state) {
                      if (state is GetTasksSuccess) {
                        if (state.taskEntity.items.isNotEmpty) {
                          _pagingController.appendPage(
                              state.taskEntity.items, _page);
                          _page++;
                        } else {
                          _pagingController.appendLastPage([]);
                        }
                      }
                      if (state is GetTasksError) {
                        _pagingController.error = "";
                      }
                    },
                    child: PagedListView<int, TaskModel>(
                        pagingController: _pagingController,
                        builderDelegate: PagedChildBuilderDelegate<TaskModel>(
                          itemBuilder: (context, item, index) =>
                              BlocListener<DeleteTaskBloc, DeleteTaskState>(
                                listener: (context, state) {
                                  if(state is DeleteTaskSuccess){

                                  }
                                },
                                child: TaskItem(
                                  onCheck: (value){
                                    item.completed = value;
                                    _pagingController.notifyListeners();
                                    BlocProvider.of<EditTaskBloc>(context).add(UpdateTask(
                                        taskModel: TaskModel(
                                            id: item.id,
                                            completed: value,
                                            todo: item.todo,
                                            me: item.me??false)));
                                  },
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                            return AddEditTaskPage(
                                              pageAction: PageAction.edit,
                                              taskModel: item,
                                              onUpdate: (taskModel){
                                                debugPrint(taskModel.completed.toString());
                                                _pagingController.itemList![index] = taskModel;
                                                _pagingController.notifyListeners();
                                              },
                                            );
                                          }));
                                    },
                                    onDelete: () {
                                      BlocProvider.of<DeleteTaskBloc>(context)
                                          .add(DeleteTask(item));
                                      _pagingController.itemList?.removeAt(index);
                                      _pagingController.notifyListeners();
                                    },
                                    taskModel: item),
                              ),
                        ))))));
  }
}
