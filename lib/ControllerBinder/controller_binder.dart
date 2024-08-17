import 'package:get/get.dart';
import 'package:task_manager/ui/controllers/cancelled_screen_controller.dart';
import 'package:task_manager/ui/controllers/get_new_task_count_controller.dart';
import 'package:task_manager/ui/controllers/new_task_controller.dart';
import 'package:task_manager/ui/controllers/sign_in_controller.dart';

import '../ui/controllers/complete_screen_controller.dart';
import '../ui/controllers/in_progress_task_screen_controller.dart';

class ControllerBinder extends Bindings{
  void dependencies(){
    Get.lazyPut(()=>SignInController());
    Get.lazyPut(()=>NewTaskController());
    Get.lazyPut(()=>GetNewTaskCountController());
    Get.lazyPut(()=>CompleteScreenController());
    Get.lazyPut(()=>InProgressTaskScreenController());
    Get.lazyPut(()=>CancelledScreenController());

  }
}