import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_todoapp/UI/Addtaskpage.dart';
import 'package:flutter_todoapp/UI/Calender_event.dart';
import 'package:flutter_todoapp/UI/homescreen.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarPage();
}

class _NavigationBarPage extends State<NavigationBarPage> {
  int _currentIndex = 0;
  PageController? _pageController;
  final pages = [
    const Homescreen(),
    const Calenderpage(),
    const Addtaskpage(),
    const Addtaskpage(),
  ];
  @override
  void initState() {
    _pageController = PageController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        curve: Curves.bounceInOut,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Home'), icon: Icon(Icons.home)),
          BottomNavyBarItem(
              title: Text('Calender'), icon: Icon(Icons.edit_calendar_rounded)),
          BottomNavyBarItem(
              title: Text('Item Three'), icon: Icon(Icons.chat_bubble)),
          BottomNavyBarItem(title: Text('Profile'), icon: Icon(Icons.person)),
        ],
      ),
      body: pages[_currentIndex],
    );
  }
}
