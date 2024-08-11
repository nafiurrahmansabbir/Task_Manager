import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import 'custom_tost_massage.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.taskModel,
    required this.onUpdateTask,
  });

  final TaskModel taskModel;
  final VoidCallback onUpdateTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;
  bool _editInProgress = false;
  String dropdownValue = '';
  List<String> statusList = ['New', 'Progress', 'Completed', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.taskModel.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ''),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ''),
            Text(
              'Date: ${widget.taskModel.createdDate}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModel.status ?? 'New'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                ),
                ButtonBar(
                  children: [
                    Visibility(
                      visible: _deleteInProgress == false,
                      replacement: const CenteredProgressIndicator(),
                      child: IconButton(
                        onPressed: () {
                          _deleteTask();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                    Visibility(
                      visible: _editInProgress == false,
                      replacement: const CenteredProgressIndicator(),
                      child: _buildEditButton(),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.edit),
      onSelected: (String selectedValue) {
        dropdownValue = selectedValue;
        _updateTask(dropdownValue);
      },
      itemBuilder: (BuildContext context) {
        return statusList.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: ListTile(
              title: Text(value),
              trailing: dropdownValue == value ? const Icon(Icons.done) : null,
            ),
          );
        }).toList();
      },
    );
  }

  Future<void> _deleteTask() async {
    _deleteInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response =
    await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        ErrorTost('Get task count by status failed! Try again');
      }
    }
    _deleteInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _updateTask(String status) async {
    _editInProgress = true;
    if (mounted) {
      setState(() {});
    }
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.updateTaskStatus(widget.taskModel.sId!, status));

    if (response.isSuccess) {
      widget.onUpdateTask();
    } else {
      if (mounted) {
        ErrorTost('Update task status failed! Try again');

      }
    }
    _editInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}

// class TaskItem extends StatefulWidget {
//   const TaskItem({
//     super.key,
//     required this.taskModel,
//     required this.onUpdateTask,
//   });
//
//   final TaskModel taskModel;
//   final VoidCallback onUpdateTask;
//
//   @override
//   State<TaskItem> createState() => _TaskItemState();
// }
//
// class _TaskItemState extends State<TaskItem> {
//   bool _deleteProgressIndicator = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       elevation: 0,
//       child: ListTile(
//         title: Text(widget.taskModel.title ?? ''),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.taskModel.description ?? '',
//             ),
//             Text(
//               '\nDate : ${widget.taskModel.createdDate}',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Chip(
//                   label: Text(widget.taskModel.status ?? 'New'),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//                 ),
//                 ButtonBar(
//                   children: [
//                     IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.edit,
//                           color: Colors.green,
//                         )),
//                     Visibility(
//                       visible: _deleteProgressIndicator==false,
//                       replacement: CenteredProgressIndicator(),
//                       child: IconButton(
//                           onPressed: () {
//                             // DeletedAlertDialoge(context);
//                             _deleteTask();
//                           },
//                           icon: Icon(
//                             Icons.delete,
//                             color: Colors.red.shade600,
//                           )),
//                     ),
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _deleteTask() async {
//     _deleteProgressIndicator = true;
//     if (mounted) {
//       setState(() {});
//     }
//     NetworkResponse response =
//         await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));
//
//     if (response.isSuccess) {
//       widget.onUpdateTask();
//     } else {
//       if (mounted) {
//         ErrorTost('Get New Task Failed!');
//       }
//     }
//     _deleteProgressIndicator = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
