import 'package:flutter/material.dart';

import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          _buildSummaruSection()
        ],
      ),
    );
  }

  Widget _buildSummaruSection() {
    return SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            children: [
              TaskSummaryCard(
                title: 'New Task',
                count: '88',
              ),
              TaskSummaryCard(
                title: 'Complited',
                count: '12',
              ),
              TaskSummaryCard(
                title: 'Incomplited',
                count: '69',
              ),
              TaskSummaryCard(
                title: 'Canceled',
                count: '7',
              ),
            ],
          ),
        );
  }


}

