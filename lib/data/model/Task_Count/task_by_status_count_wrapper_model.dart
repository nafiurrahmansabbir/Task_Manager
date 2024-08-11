import 'package:task_manager/data/model/Task_Count/task_count_by_status_model.dart';

class TaskCountByStatusWrapperModel {
  String? status;
  List<TaskCountByStatusModel>? taskCountByStatusList;

  TaskCountByStatusWrapperModel({this.status, this.taskCountByStatusList});

  TaskCountByStatusWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountByStatusList = <TaskCountByStatusModel>[];
      json['data'].forEach((v) {
        taskCountByStatusList!.add(new TaskCountByStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.taskCountByStatusList != null) {
      data['data'] = this.taskCountByStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

