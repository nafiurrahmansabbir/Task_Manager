import 'package:flutter/material.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper_model.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/centered_progressIndicator.dart';
import '../widgets/custom_tost_massage.dart';
import '../widgets/task_item.dart';



class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  bool _getNewTaskInProgress = true;
  List<TaskModel> newTaskList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [

            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTask();
                },
                child: Visibility(
                  visible: _getNewTaskInProgress == false,
                  replacement: const CenteredProgressIndicator(),
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index],
                        onUpdateTask: () {
                          _getNewTask();
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }



  Future<void> _getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
      NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelledTasks);
      if (response.isSuccess) {
        TaskListWrapperModel taskListWrapperModel =
        TaskListWrapperModel.fromJson(response.responseData);
        newTaskList = taskListWrapperModel.tasklist ?? [];
      } else {
        if (mounted) {
          ErrorTost('Get New Task Failed!');
        }
      }
    }
    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}



// class CancelledScreen extends StatefulWidget {
//   const CancelledScreen({super.key});
//
//   @override
//   State<CancelledScreen> createState() => _CancelledScreenState();
// }
//
// class _CancelledScreenState extends State<CancelledScreen> {
//   bool _getCanceleTaskInProgress = true;
//   List<TaskModel> newTaskList = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(5.0),
//         child: Column(
//           children: [
//             RefreshIndicator(
//               onRefresh: () async {
//                 _getNewTask();
//               },
//               child: Visibility(
//                 visible: _getCanceleTaskInProgress == false,
//                 replacement: const CenteredProgressIndicator(),
//                 child: ListView.builder(
//                   itemCount: newTaskList.length,
//                   itemBuilder: (context, index) {
//                     return TaskItem(
//                       taskModel: newTaskList[index],
//                       onUpdateTask: () {
//                         _getNewTask();
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> _getNewTask() async {
//     _getCanceleTaskInProgress = true;
//     if (mounted) {
//       setState(() {});
//       NetworkResponse response =
//           await NetworkCaller.getRequest(Urls.cancelledTasks);
//       if (response.isSuccess) {
//         TaskListWrapperModel taskListWrapperModel =
//             TaskListWrapperModel.fromJson(response.responseData);
//         newTaskList = taskListWrapperModel.tasklist ?? [];
//       } else {
//         if (mounted) {
//           ErrorTost('Get New Task Failed!');
//         }
//       }
//     }
//     _getCanceleTaskInProgress = false;
//     if (mounted) {
//       setState(() {});
//     }
//   }
// }
