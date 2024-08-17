import 'package:get/get.dart';
import 'package:task_manager/ui/widgets/custom_tost_massage.dart';
import '../../data/model/network_response.dart';
import '../../data/model/task_list_wrapper_model.dart';
import '../../data/model/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utilities/urls.dart';

class NewTaskController extends GetxController{
  bool _getNewTaskInProgress = true;
  bool get getNewTaskInProgress=> _getNewTaskInProgress;
  List<TaskModel> _tasklList=[];
  List<TaskModel> get newtaskList=> _tasklList;
  String _errorMassage='';
  String get errorMassage=>_errorMassage;


  Future<bool> getNewTask() async {
    bool isSucces=false;
    _getNewTaskInProgress = true;
    update();
      NetworkResponse response = await NetworkCaller.getRequest(Urls.newTasks);
      if (response.isSuccess) {
        TaskListWrapperModel taskListWrapperModel =
        TaskListWrapperModel.fromJson(response.responseData);
        _tasklList = taskListWrapperModel.tasklist ?? [];
      } else {
        ErrorTost(response.errorMassege ?? 'Get failed try again');
      }
      _getNewTaskInProgress=false;
      update();

      return isSucces;
    }
}