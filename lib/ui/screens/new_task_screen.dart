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

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = true;
  bool _getNewTaskCountByStatusInProgress = true;
  List<TaskModel> newTaskList = [];
  List<TaskCountByStatusModel> taskCountStatusList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getNewTaskCountByStatus();
    _getNewTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaruSection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTask();
                  _getNewTaskCountByStatus();
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
                          _getNewTaskCountByStatus();
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.themeColor,
        onPressed: _onTapAddButton,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewTaskScreen(),
      ),
    );
  }

  Widget _buildSummaruSection() {
    return Visibility(
        visible: _getNewTaskCountByStatusInProgress == false,
        replacement: SizedBox(height: 100, child: CenteredProgressIndicator()),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: taskCountStatusList.map((e) {
                  return TaskSummaryCard(
                    title: (e.sId ?? 'Unknown').toUpperCase(),
                    count: e.sum.toString(),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }

  Future<void> _getNewTaskCountByStatus() async {
    _getNewTaskCountByStatusInProgress = true;
    if (mounted) {
      setState(() {});
      NetworkResponse response =
          await NetworkCaller.getRequest(Urls.taskStatusCount);
      if (response.isSuccess) {
        TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
            TaskCountByStatusWrapperModel.fromJson(response.responseData);
        taskCountStatusList =
            taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
      } else {
        if (mounted) {
          ErrorTost('Get Task count by status Failed!');
        }
      }
    }
    _getNewTaskCountByStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
      NetworkResponse response = await NetworkCaller.getRequest(Urls.newTasks);
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
