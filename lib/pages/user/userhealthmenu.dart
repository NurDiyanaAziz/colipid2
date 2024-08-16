import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/adminmain.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/user/userViewReport.dart';
import 'package:colipid/pages/user/user_updateprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserHealthMenuScreen extends StatefulWidget {
  const UserHealthMenuScreen({Key? key}) : super(key: key);

  @override
  _UserHealthMenuScreenState createState() => _UserHealthMenuScreenState();
}

class _UserHealthMenuScreenState extends State<UserHealthMenuScreen> {
  late String name;
  late String weight;
  late String height;
  late String bmi;
  late String bmistat;

  late SharedPreferences logindata;
  late String ic;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();

    setState(() {
      ic = logindata.getString('ic').toString();
    });
  }

  Widget buildBackBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          //String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AdminMainScreen()));
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
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: 300,
      child: ElevatedButton(
        onPressed: () async {
          //String ic = widget.myObject.toString();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => userViewReport()));
        },
        child: const Text(
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
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          //String ic = widget.myObject.toString();
          //Navigator.of(context).pushReplacement(MaterialPageRoute(
          // builder: (context) => AdminUpdateLipidProfile(myObject: ic)));
        },
        child: const Text(
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
    return Center(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
          style: const ButtonStyle(),
          onPressed: () async {
            // String ic = widget.myObject.toString();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => UserUpdateInfo()));
          },
          child: const Text(
            'Update Patient Profile',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
          ),
        ),
      ),
    ));
  }

  Widget buildInputMedPatientBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // String ic = widget.myObject.toString();
          //Navigator.of(context).pushReplacement(MaterialPageRoute(
          // builder: (context) => AdminPatientMedicine(myObject: ic)));
        },
        child: const Text(
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
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: 100,
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
          'Submit',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Align(
            alignment: Alignment.center,
            child: Image.asset(
              'images/ic_launcher.png',
              scale: 4,
            ),
          ),
          backgroundColor: const Color.fromARGB(0, 46, 41, 41),
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: LoaderOverlay(
          reverseDuration: const Duration(milliseconds: 250),
          duration: const Duration(milliseconds: 250),
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Container(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Patient Info Menu',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w300),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 59, 139, 231),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 250,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Update Body Profile',
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
                                            'Manage your latest body information here',
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                            overflow: TextOverflow.visible,
                                          ))
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      'images/iconUpdateInfo.png',
                                      scale: 1.15,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF54D159),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'View',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                  ),
                                ),
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserUpdateInfo()),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                              color: Color(0xFFCC3E8A),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 250,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'View Lipid Result',
                                          style: TextStyle(
                                              fontSize: 20,
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
                                            'View your lipid report ',
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.white),
                                            overflow: TextOverflow.visible,
                                          ))
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Image.asset(
                                      'images/iconViewReport.png',
                                      scale: 1.15,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 5),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF54D159),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'View',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  onTap: () async {
                                    logindata =
                                        await SharedPreferences.getInstance();
                                    QuerySnapshot snap = await FirebaseFirestore
                                        .instance
                                        .collection("lipidreport")
                                        .where("ic",
                                            isEqualTo: logindata
                                                .getString('ic')
                                                .toString())
                                        .get();
                                    if (snap.size > 0) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                userViewReport()),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              duration:
                                                  const Duration(seconds: 2),
                                              content: Text(
                                                  "There's no health result yet")));
                                    }
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
