import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager/ui/controllers/cancelled_screen_controller.dart';
import '../widgets/centered_progressIndicator.dart';
import '../widgets/task_item.dart';

class CancelledScreen extends StatefulWidget {
  const CancelledScreen({super.key});

  @override
  State<CancelledScreen> createState() => _CancelledScreenState();
}

class _CancelledScreenState extends State<CancelledScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialCall();
  }

  void _initialCall() {
    Get.find<CancelledScreenController>().getNewTask();
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
                child: GetBuilder<CancelledScreenController>(
                    builder: (cancelledScreenController) {
                  return Visibility(
                    visible:
                        cancelledScreenController.getNewTaskInProgress == false,
                    replacement: const CenteredProgressIndicator(),
                    child: ListView.builder(
                      itemCount: cancelledScreenController.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskItem(
                          taskModel:
                              cancelledScreenController.newTaskList[index],
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
