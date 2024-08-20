import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'adminpatientmenu_page.dart';

// ignore: must_be_immutable
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
            // ignore: unused_local_variable
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
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            enabled: false,
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
      ],
    );
  }

  Widget buildTime() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            enabled: false,
            controller: times,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.punch_clock, color: Color(0x663e97a9)),
                hintText: 'Time',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget buildDrName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            enabled: false,
            controller: drname,
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:
                    Icon(Icons.person_pin_circle, color: Color(0x663e97a9)),
                hintText: 'Doctor name',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget buildHdl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: hdl,
            keyboardType: TextInputType.number,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: const Icon(Icons.bloodtype, color: Color(0x663e97a9)),
              hintText: 'HDL',
              hintStyle: const TextStyle(color: Colors.black38),
              suffixIcon: IconButton(
                onPressed: hdl.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTotalC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: tc,
            keyboardType: TextInputType.number,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: const Icon(Icons.bloodtype, color: Color(0x663e97a9)),
              hintText: 'Total Cholesterol',
              hintStyle: const TextStyle(color: Colors.black38),
              suffixIcon: IconButton(
                onPressed: tc.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLdl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: ldl,
            keyboardType: TextInputType.number,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: const Icon(Icons.bloodtype, color: Color(0x663e97a9)),
              hintText: 'LDL',
              hintStyle: const TextStyle(color: Colors.black38),
              suffixIcon: IconButton(
                onPressed: tc.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTrigly() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            controller: trigly,
            keyboardType: TextInputType.number,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14),
              prefixIcon: const Icon(Icons.bloodtype, color: Color(0x663e97a9)),
              hintText: 'Triglycerides',
              hintStyle: const TextStyle(color: Colors.black38),
              suffixIcon: IconButton(
                onPressed: tc.clear,
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildComment() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 200,
          child: TextField(
            controller: comment,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.message, color: Color(0x663e97a9)),
                hintText: 'Comment',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget buildTitle(String text) {
    return Align(
      alignment: Alignment.topLeft,
      child: AutoSizeText(
        text,
        minFontSize: 20,
        maxFontSize: 25,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      width: double.infinity,
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

            // ignore: unused_local_variable
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
        child: const Text(
          'Submit',
          style: TextStyle(
              color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 161, 149),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        title: const Text('Patient Lipid Profile'),
        leading: InkWell(
          onTap: () async {
            final action = await Dialogs.yesAbortDialog(
                context, 'Confirm Discard?', 'Are you sure?');
            if (action == DialogAction.yes) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AdminUpdatePatient(myObject: icc)));
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 5),
                    buildTitle('Date'),
                    buildDate(),
                    const SizedBox(height: 15),
                    buildTitle('Time'),
                    buildTime(),
                    const SizedBox(height: 15),
                    buildTitle('Doctor In-Charge'),
                    buildDrName(),
                    const SizedBox(height: 15),
                    buildTitle('Total Cholesterol'),
                    buildTotalC(),
                    const SizedBox(height: 15),
                    buildTitle('HDL (high-density lipoprotein)'),
                    buildHdl(),
                    const SizedBox(height: 15),
                    buildTitle('LDL (low-density lipoprotein)'),
                    buildLdl(),
                    const SizedBox(height: 15),
                    buildTitle('Triglycerides'),
                    buildTrigly(),
                    const SizedBox(height: 15),
                    buildTitle('Comment'),
                    buildComment(),
                    const SizedBox(height: 15),
                    buildSubmitBtn(),
                    const SizedBox(height: 5),
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
