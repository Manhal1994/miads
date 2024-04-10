import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/presntation/add_edit_task/bloc/add_task_bloc.dart';

import '../../core/enum/page_action.dart';

class AddEditTaskPage extends StatefulWidget {
  final PageAction pageAction;
  final TaskModel? taskModel;
  final Function(TaskModel)? onAdd;
  final Function(TaskModel)? onUpdate;

  const AddEditTaskPage(
      {super.key,
      required this.pageAction,
      this.taskModel,
      this.onAdd,
      this.onUpdate});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final todoEditingController = TextEditingController();

  @override
  void initState() {
    if (widget.pageAction == PageAction.edit) {
      todoEditingController.text = widget.taskModel!.todo;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: BlocConsumer<EditTaskBloc, EditTaskState>(
          listener: (context, state) {
            if (state is AddTaskSuccess) {
              if (widget.pageAction == PageAction.add) {
                widget.onAdd!(state.taskModel);
              }
              if (widget.pageAction == PageAction.edit) {
                widget.onUpdate!(state.taskModel);
              }
              Navigator.pop(context);
            } else if (state is AddTaskError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is AddTaskLoading) {
              return FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              );
            } else {
              return FloatingActionButton(
                onPressed: () {
                  if (widget.pageAction == PageAction.add) {
                    BlocProvider.of<EditTaskBloc>(context).add(
                        CreateTask(name: todoEditingController.text.trim()));
                  } else {
                    BlocProvider.of<EditTaskBloc>(context).add(UpdateTask(
                        taskModel: TaskModel(
                            id: widget.taskModel!.id,
                            todo: todoEditingController.text.trim(),
                            completed: widget.taskModel?.completed ?? false,
                            me: widget.taskModel?.me ?? false)));
                  }
                },
                backgroundColor: Colors.lightBlueAccent,
                child: const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
              );
            }
          },
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  widget.pageAction == PageAction.add
                      ? "Add Task"
                      : "Edit Task",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextField(
                  maxLines: 16,
                  controller: todoEditingController,
                  decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 0.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 0.5),
                      ),
                      hintText: "Task description"),
                )
              ],
            ),
          ),
        ));
  }
}
