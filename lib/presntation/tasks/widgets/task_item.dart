import 'package:flutter/material.dart';
import 'package:maids/data/models/task.dart';

class TaskItem extends StatefulWidget {
  final Function() onTap;
  final Function() onDelete;
  final Function(bool) onCheck;
  final TaskModel taskModel;

  const TaskItem(
      {super.key,
      required this.onCheck,
      required this.taskModel,
      required this.onDelete,
      required this.onTap});

  @override
  TaskItemState createState() => TaskItemState();
}

class TaskItemState extends State<TaskItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            child: SizedBox(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Checkbox(
                            value: widget.taskModel.completed?? false,
                            onChanged: (value) {
                              widget.onCheck(value ?? false);
                            }),
                        Expanded(
                            child: Text(
                          widget.taskModel.todo,
                          maxLines: 2,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        )),
                      ],
                    )),
                    IconButton(
                        onPressed: widget.onDelete,
                        icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent,))
                  ]),
            ),
          ),
        ));
  }
}
