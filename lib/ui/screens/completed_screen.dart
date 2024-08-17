import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/complete_screen_controller.dart';
import 'package:task_manager/ui/widgets/centered_progressIndicator.dart';
import '../widgets/task_item.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<CompleteScreenController>().getNewTask();
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
                  _initialCall();
                },
                child: GetBuilder<CompleteScreenController>(
                    builder: (completeScreenController) {
                  return Visibility(
                    visible:
                        completeScreenController.getNewTaskInProgress == false,
                    replacement: const CenteredProgressIndicator(),
                    child: ListView.builder(
                      itemCount: completeScreenController.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          taskModel:
                              completeScreenController.newTaskList[index],
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
          ],
        ),
      ),
    );
  }
}
