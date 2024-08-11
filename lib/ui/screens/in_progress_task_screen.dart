import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';

import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper_model.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/custom_tost_massage.dart';
import '../widgets/task_item.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {

  bool _getNewTaskInProgress = true;
  List<TaskModel> ProgressTaskList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ProgressTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: RefreshIndicator(
          onRefresh: ()async{
            _ProgressTask();
          },
          child: Visibility(
            visible: _getNewTaskInProgress==false,
            replacement: CenteredProgressIndicator(),
            child: ListView.builder(
              itemCount: ProgressTaskList.length,
              itemBuilder: (context, index) {
                return TaskItem(taskModel: ProgressTaskList[index], onUpdateTask: (){_ProgressTask();});
              },
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _ProgressTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
      NetworkResponse response = await NetworkCaller.getRequest(Urls.progressTasks);
      if (response.isSuccess) {
        TaskListWrapperModel taskListWrapperModel =
        TaskListWrapperModel.fromJson(response.responseData);
        ProgressTaskList = taskListWrapperModel.tasklist ?? [];
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
