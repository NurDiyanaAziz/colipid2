import 'dart:math';

import 'package:colipid/pages/patientlist_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adminPatientMedicine_page.dart';
import 'adminaddpatientinfo_page.dart';
import 'adminhome_page.dart';
import 'adminmain.dart';
import 'adminprofile_page.dart';
import 'adminupdatelipidprofile_page.dart';
import 'adminviewreport_page.dart';
import 'dialogs.dart';

class AdminUpdatePatient extends StatefulWidget {
  //const AdminUpdatePatient( {Key? key}) : super(key: key);
  var myObject;
  AdminUpdatePatient({this.myObject});

  @override
  _AdminUpdatePatientState createState() => _AdminUpdatePatientState();
}

class _AdminUpdatePatientState extends State<AdminUpdatePatient> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  //final routeData = ModalRoute.of(context).settings.arguments as Map<String, Object>;
  //final thirdKey  =routeData['']

  late String icc = "";
  void fetchUserData() {
    // do something
    String ic = widget.myObject.toString();
    setState(() {
      icc = ic;
    });
  }

  Future<String> fetchUser() async {
    // do something
    final ic = widget.myObject.toString();
    return ic;
  }

  Widget buildBackBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 100,
      child: ElevatedButton(
       
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Discard?', 'Are you sure?');
          if (action == DialogAction.yes) {
            String ics = widget.myObject.toString();
            String ic = widget.myObject.toString();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AdminMainScreen()));
          }
        },
       
        child: Text(
          'Back',
          style: TextStyle(
              color: Colors.blue[400],
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildViewReportBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(

        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminViewReportPatient(myObject: ic)));
        },
      
        child: Text(
          'View Report',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildUpdateLipidBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
      
        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminUpdateLipidProfile(myObject: ic)));
        },
      
        child: Text(
          'Update Patient Lipid Profile',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildInputPatientInfoBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
       
        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminAddPatientInfo(myObject: ic)));
        },
     
        child: Text(
          'Update Patient Profile',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildInputMedPatientBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
       
        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminPatientMedicine(myObject: ic)));
        },
     
        child: Text(
          'Update Patient Medicine',
          style: TextStyle(
              color: Color(0xff3e97a9),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: 100,
      child: ElevatedButton(
      
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AdminMainScreen()));
          }
        },
      
        child: Text(
          'Finish',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

 

  @override
  Widget build(BuildContext context) {
    int index = 1;

    final items = <Widget>[
      Icon(Icons.file_open, size: 30),
      Icon(Icons.home, size: 30),
      Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0x66C4A195),
                  Color(0x99C4A195),
                  Color(0xccC4A195),
                  Color(0xffC4A195),
                ],
              )),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Patient Info Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildBackBtn(),
                    SizedBox(height: 20),
                    buildInputPatientInfoBtn(),
                    SizedBox(height: 5),
                    buildUpdateLipidBtn(),
                    SizedBox(height: 5),
                    buildInputMedPatientBtn(),
                    SizedBox(height: 5),
                    buildViewReportBtn(),
                    SizedBox(height: 20),
                    buildSubmitBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
