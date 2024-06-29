import 'package:flutter/material.dart';

import '../widgets/task_item.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return TaskItem();
          },
        ),
      ),
    );
  }
}
