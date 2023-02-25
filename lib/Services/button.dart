import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Custombutton extends StatelessWidget {
  //const Custombutton({Key? key}) : super(key: key);
  double? customwidth;
  double? customheight;
  var buttonName;
  Function()? ontap;
  Custombutton(
      {this.buttonName, this.customheight, this.customwidth, this.ontap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: customheight,
        width: customwidth,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: buttonName,
        ),
      ),
    );
  }
}
