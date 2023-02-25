import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_todoapp/Controller/Taskcontroller.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Calenderpage extends StatefulWidget {
  const Calenderpage({Key? key}) : super(key: key);

  @override
  State<Calenderpage> createState() => _CalenderpageState();
}

class _CalenderpageState extends State<Calenderpage> {
   final Taskcontroller _taskcontroller = Get.put(Taskcontroller());

  Map<DateTime, List<dynamic>>? _events;
  List<dynamic>? _selectedEvents;
  TextEditingController? _eventController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: TableCalendar(
            //eventLoader: _taskcontroller.tasklist,
            firstDay: DateTime.utc(2010, 10, 20),
            lastDay: DateTime.utc(2040, 10, 20),
            focusedDay: DateTime.now(),
          ),
        ),
      ),
    );
  }
}
