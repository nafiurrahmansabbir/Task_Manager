import 'package:task_manager/data/model/task_model.dart';

class TaskListWrapperModel {
  String? status;
  List<TaskModel>? tasklist;

  TaskListWrapperModel({this.status, this.tasklist});

  TaskListWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      tasklist = <TaskModel>[];
      json['data'].forEach((v) {
        tasklist!.add(TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (tasklist != null) {
      data['data'] = tasklist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


