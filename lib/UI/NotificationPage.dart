import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  final String label;
  NotificationPage({required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios)),
        title: Text(label.toString().split("|")[0]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.purple,
            ),
            height: 400,
            width: 400,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(label.toString().split("|")[1]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
