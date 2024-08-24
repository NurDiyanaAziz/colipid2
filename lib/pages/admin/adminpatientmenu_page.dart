// ignore_for_file: unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adminPatientMedicine_page.dart';
import 'adminaddpatientinfo_page.dart';
import 'adminmain.dart';
import 'adminupdatelipidprofile_page.dart';
import 'adminviewreport_page.dart';
import 'dialogs.dart';

// ignore: must_be_immutable
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
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Discard?', 'Are you sure?');
          if (action == DialogAction.yes) {
            // ignore: duplicate_ignore
            // ignore: unused_local_variable
            String ics = widget.myObject.toString();
            String ic = widget.myObject.toString();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AdminMainScreen()));
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
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminViewReportPatient(myObject: ic)));
        },
        child: const AutoSizeText(
          'View',
          minFontSize: 16,
          maxFontSize: double.infinity,
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildUpdateLipidBtn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminUpdateLipidProfile(myObject: ic)));
        },
        child: const AutoSizeText(
          'Update',
          minFontSize: 16,
          maxFontSize: double.infinity,
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildInputPatientInfoBtn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminAddPatientInfo(myObject: ic)));
        },
        child: const AutoSizeText(
          'Update',
          minFontSize: 16,
          maxFontSize: double.infinity,
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildInputMedPatientBtn() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminPatientMedicine(myObject: ic)));
        },
        child: const AutoSizeText(
          'Update',
          minFontSize: 16,
          maxFontSize: double.infinity,
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const AdminMainScreen()));
          }
        },
        child: const Text(
          'Finish Treatment',
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
      const Icon(Icons.file_open, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 196, 161, 149),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        title: const Text('Patient Menu'),
        leading: InkWell(
          onTap: () async {
            final action = await Dialogs.yesAbortDialog(
                context, 'Confirm Discard?', 'Are you sure?');
            if (action == DialogAction.yes) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AdminMainScreen()));
            }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
      ),
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
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildSubmitBtn(),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 134, 98, 86),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: AutoSizeText(
                                      'Update Patient Profile',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 60.0,
                                        maxWidth: 150.0,
                                        minHeight: 30.0,
                                        maxHeight: 100.0,
                                      ),
                                      //SET max width
                                      child: const AutoSizeText(
                                        'Manage patient latest body information here',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        overflow: TextOverflow.visible,
                                      ))
                                ],
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    fit: BoxFit.scaleDown,
                                    'images/admin4.png',
                                    scale: 3,
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            child: buildInputPatientInfoBtn(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 134, 98, 86),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: AutoSizeText(
                                      'Update Lipid Result',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 60.0,
                                        maxWidth: 150.0,
                                        minHeight: 30.0,
                                        maxHeight: 100.0,
                                      ),
                                      //SET max width
                                      child: const AutoSizeText(
                                        'Manage lipid level of the patient',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        overflow: TextOverflow.visible,
                                      ))
                                ],
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'images/admin2.png',
                                    scale: 3,
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            child: buildUpdateLipidBtn(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 134, 98, 86),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: AutoSizeText(
                                      'Update Medicine',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 60.0,
                                        maxWidth: 150.0,
                                        minHeight: 30.0,
                                        maxHeight: 100.0,
                                      ),
                                      //SET max width
                                      child: const AutoSizeText(
                                        'Manage medicine for patient',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        overflow: TextOverflow.visible,
                                      ))
                                ],
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'images/admin3.png',
                                    scale: 3,
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            child: buildInputMedPatientBtn(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 134, 98, 86),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: AutoSizeText(
                                      'Patient Health Report',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minWidth: 60.0,
                                        maxWidth: 150.0,
                                        minHeight: 30.0,
                                        maxHeight: 100.0,
                                      ),
                                      //SET max width
                                      child: const AutoSizeText(
                                        'View patient lipid level by year',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                        overflow: TextOverflow.visible,
                                      ))
                                ],
                              ),
                              Flexible(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    'images/admin1.png',
                                    scale: 3,
                                  ),
                                ),
                              )
                            ],
                          ),
                          InkWell(
                            child: buildViewReportBtn(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
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
