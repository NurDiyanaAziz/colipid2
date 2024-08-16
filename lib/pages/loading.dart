import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 183, 224, 236),
      child: Center(
        child: SpinKitPumpingHeart(
          color: Color.fromARGB(255, 202, 40, 89),
          size: 80.0,
        ),
      ),
    );
  }
}