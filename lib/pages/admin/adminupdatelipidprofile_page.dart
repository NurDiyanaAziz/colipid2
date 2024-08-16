import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

import 'adminpatientmenu_page.dart';

class AdminUpdateLipidProfile extends StatefulWidget {
  //const AdminUpdateLipidProfile({Key? key}) : super(key: key);
  var myObject;
  AdminUpdateLipidProfile({this.myObject});

  @override
  _AdminUpdateLipidProfileState createState() =>
      _AdminUpdateLipidProfileState();
}

class _AdminUpdateLipidProfileState extends State<AdminUpdateLipidProfile> {
  int index = 1;
  final drname = TextEditingController();
  final pname = TextEditingController();
  final pic = TextEditingController();
  final dates = TextEditingController();
  final times = TextEditingController();
  final ldl = TextEditingController();
  final hdl = TextEditingController();
  final tc = TextEditingController();
  final trigly = TextEditingController();
  final comment = TextEditingController();

  late SharedPreferences logindata;
  late String icuser;
  @override
  void initState() {
    super.initState();
    icuser = 'test';
    initial();
    fetchUser();
    fetchUserLipidData();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    QuerySnapshot snap1 = await FirebaseFirestore.instance
        .collection("users")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
        .get();
    setState(() {
      icuser = logindata.getString('ic').toString();
      drname.text = "Dr. " + snap1.docs[0]['fullname'].toString();
    });
  }

  void fetchUserLipidData() async {
    // do something
    String ic = widget.myObject.toString();

    QuerySnapshot snaps = await FirebaseFirestore.instance
        .collection("users")
        .where("ic", isEqualTo: ic)
        .get();

    setState(() {
      var now = DateTime.now();
      var formatterDate = DateFormat('dd/MM/yyyy');
      var formatterTime = DateFormat('HH:mm');
      String actualDate = formatterDate.format(now);
      String actualTime = formatterTime.format(now);

      dates.text = actualDate;
      times.text = actualTime;
      pname.text = snaps.docs[0]['fullname'].toString();
    });
  }

  late String icc = "";
  void fetchUser() {
    // do something
    String ic = widget.myObject.toString();
    setState(() {
      icc = ic;
    });
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
            String ics = widget.myObject.toString();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminUpdatePatient(myObject: icc)));
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

  Widget buildPName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: pname,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.perm_identity, color: Color(0x663e97a9)),
                  hintText: 'Patient name',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildIC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: pic,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.perm_identity, color: Color(0x663e97a9)),
                  hintText: 'Patient IC',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: dates,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.calendar_today, color: Color(0x663e97a9)),
                  hintText: 'Date',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: times,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.punch_clock, color: Color(0x663e97a9)),
                  hintText: 'Time',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildDrName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: drname,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.people, color: Color(0x663e97a9)),
                  hintText: 'Doctor name',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildHdl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: hdl,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon:
                    const Icon(Icons.bloodtype, color: Color(0x663e97a9)),
                hintText: 'HDL',
                hintStyle: const TextStyle(color: Colors.black38),
                suffixIcon: IconButton(
                  onPressed: hdl.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTotalC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: tc,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14),
                prefixIcon:
                    const Icon(Icons.bloodtype, color: Color(0x663e97a9)),
                hintText: 'Total Cholesterol',
                hintStyle: const TextStyle(color: Colors.black38),
                suffixIcon: IconButton(
                  onPressed: tc.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildLdl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: ldl,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.bloodtype, color: Color(0x663e97a9)),
                hintText: 'LDL',
                hintStyle: TextStyle(color: Colors.black38),
                suffixIcon: IconButton(
                  onPressed: tc.clear,
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTrigly() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: trigly,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.people, color: Color(0x663e97a9)),
                hintText: 'Trygliceride',
                hintStyle: TextStyle(color: Colors.black38),
                suffixIcon: IconButton(
                  onPressed: tc.clear,
                  icon: Icon(Icons.clear),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 200,
            child: TextField(
              controller: comment,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.people, color: Color(0x663e97a9)),
                  hintText: 'Comment',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          String tcStat = "", triglyStat = "", hdlStat = "", ldlcStat = "";

          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            String ics = widget.myObject.toString();
            QuerySnapshot snap = await FirebaseFirestore.instance
                .collection("users")
                .where("ic", isEqualTo: ics)
                .get();

            String id = snap.docs[0]['id'].toString();
            String name = drname.text;
            double hdls = double.parse(hdl.text);
            double tcs = double.parse(tc.text);
            double ldls = double.parse(ldl.text);
            double tryg = double.parse(trigly.text);
            String comm = comment.text;
            String gend = snap.docs[0]['gender'].toString();

            if (gend == "Male") {
              if (hdls > 1.45) {
                hdlStat = "Low Risk";
              } else if (hdls > 0.90 && hdls < 1.45) {
                hdlStat = "Intermediate Risk";
              } else if (hdls < 0.9) {
                hdlStat = "High Risk";
              }
            } else if (gend == "Female") {
              if (hdls > 1.68) {
                hdlStat = "Low Risk";
              } else if (hdls > 1.15 && hdls < 1.68) {
                hdlStat = "Intermediate Risk";
              } else if (hdls < 1.15) {
                hdlStat = "High Risk";
              }
            }

            if (tcs < 5.2) {
              tcStat = "Low Risk";
            } else if (tcs > 5.20 && tcs <= 6.2) {
              tcStat = "Intermediate Risk";
            } else if (tcs > 6.2) {
              tcStat = "High Risk";
            }

            if (ldls < 2.6) {
              ldlcStat = "Low Risk";
            } else if (ldls > 2.6 && ldls < 4.1) {
              ldlcStat = "Intermediate Risk";
            } else if (ldls > 4.1) {
              ldlcStat = "High Risk";
            }

            if (tryg < 2.26) {
              triglyStat = "Low Risk";
            } else if (tryg > 2.26) {
              triglyStat = "High Risk";
            }

            String dateLipid = dates.text;
            String timeLipid = times.text;

            final lipidprofile = LipidModel(
              ic: ics,
              date: dateLipid,
              time: timeLipid,
              tc: tcs,
              hdl: hdls,
              ldl: ldls,
              trigly: tryg,
              tcstatus: tcStat,
              ldlstatus: ldlcStat,
              hdlstatus: hdlStat,
              triglystatus: triglyStat,
              drname: name,
              comment: comm,
            );

            inputLipid(lipidprofile);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminUpdatePatient(myObject: icc)));
          }
        },
        child: Text(
          'Submit',
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
                      'Patient Lipid Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    buildBackBtn(),
                    SizedBox(height: 5),
                    buildDate(),
                    SizedBox(height: 5),
                    buildTime(),
                    SizedBox(height: 5),
                    buildDrName(),
                    SizedBox(height: 5),
                    buildTotalC(),
                    SizedBox(height: 5),
                    buildHdl(),
                    SizedBox(height: 5),
                    buildLdl(),
                    SizedBox(height: 5),
                    buildTrigly(),
                    SizedBox(height: 5),
                    buildComment(),
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

  Future inputLipid(LipidModel lipid) async {
    //reference document
    final lipidP = FirebaseFirestore.instance.collection('lipidreport').doc();

    lipid.id = lipidP.id;
    final json = lipid.toJson();
    await lipidP.set(json);
  }
}
