import 'package:flutter/material.dart';
import 'package:task_manager/data/model/Task_Count/task_by_status_count_wrapper_model.dart';
import 'package:task_manager/data/model/network_response.dart';
import 'package:task_manager/data/model/task_list_wrapper_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';
import 'package:task_manager/ui/widgets/custom_tost_massage.dart';
import '../../data/model/Task_Count/task_count_by_status_model.dart';
import '../../data/model/task_model.dart';
import '../utilities/app_colors.dart';
import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';


class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
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
      NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTasks);
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

