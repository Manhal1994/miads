import 'package:flutter/material.dart';
import 'package:maids/data/models/task.dart';

class TaskItem extends StatelessWidget {
  final Function() onTap;
  final Function() onDelete;
  final TaskModel taskModel;

  const TaskItem(
      {super.key,
      required this.onTap,
      required this.onDelete,
      required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Row(
                      children: [
                        Checkbox(value: false, onChanged: (_) {}),
                        Expanded(
                            child: Text(
                          taskModel.todo,
                          maxLines: 2,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        )),
                      ],
                    )),
                    IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete_outline_rounded))
                  ]),
            ),
          ),
        ));
  }
}
