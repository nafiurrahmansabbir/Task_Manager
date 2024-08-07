import 'package:flutter/material.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen/main_bottom_nav_screen.dart';
import 'package:task_manager/ui/widgets/background_widget.dart';
import 'package:task_manager/ui/widgets/custom_tost_massage.dart';
import '../../data/model/network_response.dart';
import '../widgets/centered_progressIndicator.dart';
import '../widgets/profile_appBar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _addNewTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profile_appBar(context),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  Text('Add New Task', style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge,),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(hintText: 'Subject'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter subject title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Visibility(
                    visible: _addNewTaskInProgress == false,
                    replacement: const CenteredProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _addNewTask();
                        }
                      },
                      child: const Text('Add'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    _addNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> requestData = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": "New",
    };
    NetworkResponse response = await NetworkCaller.postRequest(
      Urls.createTask,
      body: requestData,
    );
    _addNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      _clearTextFields();

      if (mounted) {
        _refreshHomeScreen();
        SuccesTost('New task added!');
      }
    } else {
      if (mounted) {
        ErrorTost('New task add failed! Try again.');
      }
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  void _refreshHomeScreen() {
    Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => MainBottomNavScreen()),
          (Route<dynamic> route) => false,);
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
