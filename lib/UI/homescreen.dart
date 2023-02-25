import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_todoapp/Controller/Taskcontroller.dart';
import 'package:flutter_todoapp/Models/Taskmodel.dart';
import 'package:flutter_todoapp/Services/Colors.dart';
import 'package:flutter_todoapp/Services/Inputwidget.dart';
import 'package:flutter_todoapp/Services/LocalNotification.dart';
import 'package:flutter_todoapp/Services/button.dart';
import 'package:flutter_todoapp/UI/Addtaskpage.dart';
import 'package:flutter_todoapp/UI/TaskUI.dart';
import 'package:flutter_todoapp/main.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
//import 'package:carousel_slider/carousel_slider.dart';
List tasklist  = [];
class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // ignore: prefer_final_fields, unused_field
  DateTime _selectedDate = DateTime.now();
  // ignore: prefer_typing_uninitialized_variables
  var notification = NotificationClass();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin(); //
  final Taskcontroller _taskcontroller = Get.put(Taskcontroller());
  int _currentIndex = 0;
  final _controller = PageController(viewportFraction: 0.8);
  double _currentPosition = 0.0;
  final pages = [
    const Homescreen(),
    const Addtaskpage(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notification = NotificationClass();
    notification.requestIOSPermissions();
    notification.initializeNotification();
  }

  @override
  void dispose() {
    super.dispose();
  }

//final controller = PageController(viewportFraction: 0.8, keepPage: true);
  @override
  Widget build(BuildContext context) {
    print(_taskcontroller.tasklist.length);
    return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InkWell(
          onTap: () async {
            await Get.to(() => Addtaskpage());
            _taskcontroller.getTaskDB();
          },
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xfffbb448),
            child: Icon(Icons.add),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (() {
                      Get.isDarkMode
                          ? Get.changeTheme(ThemeData.light())
                          : Get.changeTheme(ThemeData.dark());
                      getxStorage.write('thememode', Get.isDarkMode);
                      notification.displayNotification(
                          title: "NEW TITLE", body: "NO BODY fpr ");
                      //notification.scheduledNotification();
                    }),
                    child: Icon(
                      Icons.nightlight_round_outlined,
                      size: 35,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80"),
                        ),
                      ),
                      IconButton(onPressed: (() {}), icon: Icon(Icons.logout))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat.yMMMEd().format(DateTime.now()),
                          style: subheadingstyle,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                      ],
                    ),
                  ),
                  // Custombutton(
                  //   ontap: (() async {
                  //     await Get.to(() => Addtaskpage());
                  //     _taskcontroller.getTaskDB();
                  //   }),
                  //   customheight: 40,
                  //   customwidth: 100,
                  //   buttonName: Text("Add Task"),
                  // )
                ],
              ),
            ),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Today", style: headingstyle),
                SizedBox(
                  height: 10,
                ),
                DatePicker(
                  DateTime.now(),
                  height: 100,
                  width: 80,
                  selectionColor: Color.fromARGB(255, 21, 80, 180),
                  initialSelectedDate: DateTime.now(),
                  onDateChange: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  // monthTextStyle: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  // ),
                  // dateTextStyle: TextStyle(fontSize: 20),
                  // dayTextStyle: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  // ),
                ),
              ],
            )),
            SizedBox(
              height: 50,
            ),
            showtask()
          ],
        ));
  }

  bottomsheet(context, Task task) {
    Get.bottomSheet(Container(
      padding: EdgeInsets.only(top: 5),
      height: task.iscompleted == 1
          ? MediaQuery.of(context).size.height * 0.24
          : MediaQuery.of(context).size.height * 0.32,
      color: Get.isDarkMode ? Colors.grey : Colors.white,
      child: Column(
        children: [
          // Container(
          //   height: 10,
          //   width: 120,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10), color: Colors.purple),
          // ),
          task.iscompleted == 1
              ? Container()
              : _bottomshettbutton(
                  label: "Task Completed",
                  onTap: () {
                    _taskcontroller.taskcompleted(task.id!);
                    _taskcontroller.getTaskDB();
                    Get.back();
                  }),
          //  SizedBox(height: 25,),
          _bottomshettbutton(
              label: "Delete Completed",
              onTap: () {
                _taskcontroller.deletetask(task);
                _taskcontroller.getTaskDB();
                Get.back();
              }),
        ],
      ),
    ));
  }

  _bottomshettbutton(
      {String? label, @required Function()? onTap, bool isclose = false}) {
    {
      return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 55,
            width: 350,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: isclose == true ? Colors.red : Colors.grey,
                  //color: isclose==true?Color():clr,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(label.toString(),
                    style: TextStyle(color: Colors.black))),
          ));
    }
  }

  showtask() {
    return Expanded(child: Obx(() {
      return Column(
        children: [
          SizedBox(
            height: 250,
            
          
            child: PageView.builder(
                controller: _controller,
                itemCount: _taskcontroller.tasklist.length,
                itemBuilder: (ctx, index) {
                  Task task = _taskcontroller.tasklist[index];

                  if (task.repeat == "daily") {
                    DateTime dateTime =
                        DateFormat.jm().parse(task.starttime.toString());
                    var time = DateFormat("HH:mm").format(dateTime);
                    print(time);
                    notification.scheduledNotification(
                        int.parse(time.toString().split(":")[0]),
                        int.parse(time.toString().split(":")[1]),
                        task);
                    return GestureDetector(
                      onTap: () {
                        bottomsheet(context, task);
                      },
                      child: AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                              child: FadeInAnimation(
                                  child: Row(
                            children: [
                              Container(
                                  height: 250,
                                  width: 300,
                                  child: TaskTile(task))
                            ],
                          )))),
                    );
                  }

                  if (task.date == DateFormat.yMd().format(_selectedDate)) {
                    DateTime dateTime =
                        DateFormat.jm().parse(task.starttime);
                    var time = DateFormat("HH:mm").format(dateTime);
                    print(time);
                    notification.scheduledNotification(
                        int.parse(time.toString().split(":")[0]),
                        int.parse(time.toString().split(":")[1]),
                        task);
                    return GestureDetector(
                      onTap: () {
                        bottomsheet(context, task);
                      },
                      child: AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                              child: FadeInAnimation(child: TaskTile(task)))),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          _taskcontroller.tasklist.length == 0 ||
                  _taskcontroller.tasklist.length == 1
              ? Container()
              : SmoothPageIndicator(
                  controller: _controller, // PageController
                  count: _taskcontroller.tasklist.length,
                  axisDirection: Axis.horizontal,
                  effect: WormEffect(), // your preferred effect
                  onDotClicked: (index) {})
        ],
      );
    }));
  }
}
