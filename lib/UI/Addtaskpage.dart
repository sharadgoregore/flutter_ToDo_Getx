// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_todoapp/Controller/Taskcontroller.dart';
import 'package:flutter_todoapp/Models/Taskmodel.dart';
import 'package:flutter_todoapp/Services/Colors.dart';
import 'package:flutter_todoapp/Services/Inputwidget.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

// ignore: prefer_typing_uninitialized_variables
final TextEditingController _titlecontroller = TextEditingController();
final TextEditingController _notecontroller = TextEditingController();
final Taskcontroller _taskcontroller = Get.put(Taskcontroller());

class Addtaskpage extends StatefulWidget {
  const Addtaskpage({Key? key}) : super(key: key);

  @override
  State<Addtaskpage> createState() => _AddtaskpageState();
}

class _AddtaskpageState extends State<Addtaskpage> {
  DateTime _selectedDate = DateTime.now();
  String startTime = DateFormat("hh:mm").format(DateTime.now()).toString();
  String endtime = "11:59 PM";
  int selectedremind = 5;
  List<int> remindlist = [5, 10, 15, 20];
  String selectRepeat = 'None';
  String selectType = 'Select Type of Task';
  List<String> repeatlist = ["None", "daily", "Weekly"];
  int selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              title: 'title',
              hint: 'Enter Your title',
              controller: _titlecontroller,
            ),
            InputField(
              title: 'Note',
              hint: 'Enter Your Note',
              controller: _notecontroller,
            ),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(_selectedDate).toString(),
              widget: IconButton(
                  onPressed: () {
                    GetDatefromuser(context);
                  },
                  icon: const Icon(CupertinoIcons.calendar)),
            ),
            Row(
              children: [
                Expanded(
                    child: InputField(
                  hint: startTime.toString(),
                  title: "Start Time",
                  widget: IconButton(
                      onPressed: () {
                        getTimefromUser(istartTime: true);
                      },
                      icon: const Icon(CupertinoIcons.timer)),
                )),
                Expanded(
                    child: InputField(
                  hint: endtime,
                  title: "End Time",
                  widget: IconButton(
                      onPressed: () {
                        getTimefromUser(istartTime: false);
                      },
                      icon: const Icon(CupertinoIcons.timer)),
                )),
              ],
            ),
            InputField(
              hint: "$selectedremind Early minutes",
              title: "Remind",
              widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: remindlist.map<DropdownMenuItem<String>>((int val) {
                    return DropdownMenuItem<String>(
                        value: val.toString(),
                        child: Text(val.toString(),
                            style: TextStyle(color: Colors.black)));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedremind = int.parse(value.toString());
                    });
                  }),
            ),
            InputField(
              hint: "$selectRepeat",
              title: "Repeat",
              widget: DropdownButton(
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: repeatlist.map<DropdownMenuItem<String>>((var val) {
                    return DropdownMenuItem<String>(
                        value: val.toString(),
                        child: Text(
                          val,
                          style: TextStyle(color: Colors.black),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectRepeat = value.toString();
                    });
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Color", style: subheadingstyle),
                        SizedBox(
                          height: 5,
                        ),
                        Wrap(
                            children: List.generate(
                                3,
                                (index) => InkWell(
                                      onTap: (() {
                                        setState(() {
                                          selectedColorIndex = index;
                                        });
                                        print(selectedColorIndex);
                                      }),
                                      child: Padding(
                                        padding: EdgeInsets.all(4),
                                        child: CircleAvatar(
                                          radius: 13,
                                          backgroundColor: index == 0
                                              ? Colors.pink
                                              : index == 1
                                                  ? Colors.blue
                                                  : index == 2
                                                      ? Colors.red
                                                      : null,
                                          child: selectedColorIndex == index
                                              ? Icon(CupertinoIcons.check_mark)
                                              : Container(),
                                        ),
                                      ),
                                    )))
                      ],
                    ),
                  ),
                  TextButton(
                    // color: Colors.amberAccent,
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
                      addTasktoDB();
                      _titlecontroller.clear();
                     _notecontroller.clear();
                     
                      Navigator.pop(context);
                    },
                    child: Text("Create Task"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
// addTasktoDatabase(){
//   newtask : Task(
// note: _notecontroller.text,
// title: _titlecontroller.text,
// date: DateFormat.yMd().format(_selectedDate),
// starttime:startTime,
// endtime: endtime,
// remind: selectedremind,
// repeat: selectRepeat,
// color: selectedColorIndex,
// iscompleted: 0

//   );
// }

  addTasktoDB() async {
    int value = await _taskcontroller.addTask(
        task: Task(
      note: _notecontroller.text == null ? "" : _notecontroller.text,
      title: _titlecontroller.text == null ? "" : _titlecontroller.text,
      date: DateFormat.yMd().format(_selectedDate),
      starttime: startTime,
      endtime: endtime,
      remind: selectedremind,
      repeat: selectRepeat,
      color: selectedColorIndex,
      iscompleted: 0,
//tasktype: selectType
    ));

    print("My is $value");
  }

  createtask() {
    if (_titlecontroller.text.isNotEmpty && _notecontroller.text.isNotEmpty) {
      print("Done");
    } else if (_titlecontroller.text.isEmpty || _notecontroller.text.isEmpty) {
      Get.snackbar("Required Field", "Data need to fill",
          snackPosition: SnackPosition.TOP,
          icon: Icon(Icons.warning),
          backgroundColor: Colors.amberAccent);
    }
  }

  GetDatefromuser(context) async {
    DateTime? newDateTime = await showRoundedDatePicker(
        imageHeader: const NetworkImage(
            "https://images.pexels.com/photos/257360/pexels-photo-257360.jpeg?cs=srgb&dl=pexels-pixabay-257360.jpg&fm=jpg"),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1),
        borderRadius: 16,
        height: 300);
    if (newDateTime != null) {
      setState(() {
        _selectedDate = newDateTime;
      });
    } else {
      print("Something went Wrong");
    }
  }

  getTimefromUser({required bool istartTime}) async {
    var picktime = await _showtimepicker();
    // ignore: use_build_context_synchronously
    String formatedTime = picktime.format(context);
    if (picktime == null) {
      print("Time Did not Select");
    } else if (istartTime == true) {
      setState(() {
        startTime = formatedTime;
      });
    } else if (istartTime == false) {
      setState(() {
        endtime = formatedTime;
      });
    }
  }

  _showtimepicker() {
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(startTime.split(":")[0]),
            minute: int.parse(startTime.split(":")[1].split("")[0])),
        initialEntryMode: TimePickerEntryMode.input);
  }
}
