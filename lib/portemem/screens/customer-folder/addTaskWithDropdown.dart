import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constants/apiUrl.dart';
import '../task-folder/my_nomiated_task.dart';

class addTaskWithDropdown extends StatefulWidget {
  const addTaskWithDropdown({Key? key}) : super(key: key);

  @override
  State<addTaskWithDropdown> createState() => _addTaskWithDropdownState();
}

class _addTaskWithDropdownState extends State<addTaskWithDropdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f6f9),
      body: FutureBuilder(
        future: getAllListRespAndNominationTask(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Bir şeyler yanlış gitti.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          List data = snapshot.data.data;

          List _task = data;
          return MyNomitedTaskList(
            task: _task,
          );
        },
      ),
    );
  }

/*  Future getAllListRespAndNominationTask() async {
    try {
      var response = await Dio().post(AppUrl.getTaskNomAndRespList, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }*/

  Future getAllListRespAndNominationTask() async {
    try {
      var response = await Dio().post(AppUrl.taskListDropdown, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}
