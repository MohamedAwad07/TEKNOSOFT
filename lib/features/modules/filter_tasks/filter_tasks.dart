import 'package:flutter/material.dart';
import 'package:todo_app/features/modules/list_Screen/list_screen.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';

class FilterTasks extends StatelessWidget {
  const FilterTasks({super.key, required this.name, required this.targetList});
  final String name;
  final List<Map> targetList;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  const ListsScreen()));
            }, icon:  const Icon(Icons.arrow_back_rounded),
          ),
          backgroundColor: Colors.black45,
          elevation: 0.2,
          title: Padding(
            padding: const EdgeInsetsDirectional.only(
              end: 30,
            ),
            child: Center(
              child: Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        body: noTasksBuilder(taskView: priorityList , isIgnoring: true),
      ),
    );
  }
}
