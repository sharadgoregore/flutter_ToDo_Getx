import 'dart:convert';

import 'package:flutter_todoapp/DB_Helper.dart';
import 'package:flutter_todoapp/Models/Taskmodel.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:http/http.dart' as http;

class Taskcontroller extends GetxController {
  var tasklist = <Task>[].obs;
  @override
  void onReady() {
    getTaskDB();
    // TODO: implement onReady
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insertintoDatabase(task);
  }

  getTaskDB() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    print(tasks);

//    var d = await (tasks as List).map((e) => Task.fromJson(e)).toList();
//  print(d);
    tasklist.assignAll(tasks.map((data) => Task.fromMap(data)));
  }

  void deletetask(Task task) {
    DBHelper.deletefromDB(task);
  }

  void taskcompleted(int id) {
    DBHelper.updateDBtask(id);
  }

  Future registerUser(String username, email, password, image) async {
    final response = await http.post(
      Uri.parse('http://localhost:5009/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password.toString(),
        'image': image.toString()
      }),
    );

    if (response.statusCode == 201) {
      print(response.statusCode.toString());
      // If the server did return a 201 CREATED response,
      // then parse the JSON.

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future loginUser(String username, password) async {
    final response = await http.post(
      Uri.parse('http://localhost:5009/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password.toString(),
      }),
    );
    try {
      if (response.statusCode == 201 || response.statusCode == 200) {
        print(response.body);
        print(
            " Login Sucessfully ======== > ${response.statusCode.toString()}");
               Get.toNamed("homescreen");
        // If the server did return a 201 CREATED response,
        // then parse the JSON.

      }
    } catch (e) {
      print(e);
    }
  }


}
