import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class updateTAC extends StatelessWidget {
  double size;
  
  final Color color;
  var myObject = 0;

  updateTAC(
      {Key? key, this.size = 16, required this.myObject, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      myObject.toString(),
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
