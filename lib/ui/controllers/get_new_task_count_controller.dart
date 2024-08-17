import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:task_manager/data/model/Task_Count/task_by_status_count_wrapper_model.dart';
import '../../data/model/Task_Count/task_count_by_status_model.dart';
import '../../data/model/network_response.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';
import '../widgets/custom_tost_massage.dart';

class GetNewTaskCountController extends GetxController {
  bool _getNewTaskCountByStatusInProgress = false;
  bool get getNewTaskCountByStatusInProgress =>
      _getNewTaskCountByStatusInProgress;

  List<TaskCountByStatusModel> _taskCountStatusList = [];
  List<TaskCountByStatusModel> get taskCountStatusList => _taskCountStatusList;

  Future<bool> getNewTaskCountByStatus() async {
    bool isSuccess=false;
    _getNewTaskCountByStatusInProgress = true;
    update();
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.taskStatusCount);
    if (response.isSuccess) {
      TaskCountByStatusWrapperModel taskCountByStatusWrapperModel =
          TaskCountByStatusWrapperModel.fromJson(response.responseData);
      _taskCountStatusList =
          taskCountByStatusWrapperModel.taskCountByStatusList ?? [];
    } else {
      ErrorTost(response.errorMassege ?? 'Get failed try again');
    }
    _getNewTaskCountByStatusInProgress=false;
    update();
    return isSuccess;
  }
}
