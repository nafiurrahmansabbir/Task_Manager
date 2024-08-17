import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/in_progress_task_screen_controller.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';
import '../../data/model/task_model.dart';
import '../widgets/task_item.dart';

class InProgressScreen extends StatefulWidget {
  const InProgressScreen({super.key});

  @override
  State<InProgressScreen> createState() => _InProgressScreenState();
}

class _InProgressScreenState extends State<InProgressScreen> {
  
  List<TaskModel> ProgressTaskList = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCall();
  }
  void _initialCall() {
    Get.find<InProgressTaskScreenController>().getNewTask();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              _initialCall();
            },
            child: GetBuilder<InProgressTaskScreenController>(
                builder: (InProgressTaskScreenController) {
                  return Visibility(
                    visible:
                    InProgressTaskScreenController.getNewTaskInProgress == false,
                    replacement: const CenteredProgressIndicator(),
                    child: ListView.builder(
                      itemCount: InProgressTaskScreenController.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          taskModel:
                          InProgressTaskScreenController.newTaskList[index],
                          onUpdateTask: () {
                            _initialCall();
                          },
                        );
                      },
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
