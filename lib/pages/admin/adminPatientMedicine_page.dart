import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adminpatientmenu_page.dart';

// ignore: must_be_immutable
class AdminPatientMedicine extends StatefulWidget {
  //const AdminPatientMedicine({Key? key}) : super(key: key);
  var myObject;
  AdminPatientMedicine({this.myObject});
  @override
  _AdminPatientMedicineState createState() => _AdminPatientMedicineState();
}

class _AdminPatientMedicineState extends State<AdminPatientMedicine> {
  int index = 1;
  bool isSwitched = false;
  String dropdownValue = 'Choose Med';
  @override
  void initState() {
    super.initState();
    fetchUser();
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminUpdatePatient(myObject: icc)));
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

  Widget buildSwitchBtn() {
    return Container(
      alignment: Alignment.topLeft,
      child: CupertinoSwitch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;

            print(isSwitched);
          });
        },
        activeColor: Colors.green,
      ),
    );
  }

  Widget buildMedType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Type of Medicine',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(15.0),
            width: 360,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 70,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(
                  color: Color.fromARGB(255, 92, 57, 4), fontSize: 18),
              underline: Container(
                height: 2,
                color: const Color.fromARGB(255, 128, 101, 14),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Choose Med',
                '-High-Intensity Statin Therapy-',
                'Atorvastatin 40-80 mg',
                'Rosuvastatin 20-40 mg',
                '-Moderate-Intensity Statin Therapy-',
                'Atorvastatin 10-20 mg',
                'Rosuvastatin 5-10 mg',
                'Simvastatin 20-40 mg',
                'Pravastatin 40-80 mg',
                'Lovastatin 40 mg',
                'Fluvastatin 40 mg bid',
                'Pitavastatin 2-4 mg',
                '-Low-Intensity Statin Therapy-',
                'Simvastatin 10 mg',
                'Pravastatin 10-20 mg',
                'Lovastatin 20 mg',
                'Fluvastatin 20-40 mg',
                'Pitavastatin 1 mg',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ))
      ],
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            String ics = widget.myObject.toString();
            QuerySnapshot snap = await FirebaseFirestore.instance
                .collection("users")
                .where("ic", isEqualTo: ics)
                .get();

            String id = snap.docs[0]['id'].toString();
            String med = dropdownValue.toString();
            String requiremed = isSwitched.toString();

            final docUser =
                FirebaseFirestore.instance.collection('users').doc(id);

            docUser.update({
              'med': requiremed,
              'medname': med,
            });

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
        title: const Text('Patient Medicine'),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTitle("Does patient required statin?"),
                    buildSwitchBtn(),
                    const SizedBox(height: 15),
                    buildMedType(),
                    const SizedBox(height: 15),
                    buildSubmitBtn(),
                    const SizedBox(height: 20),
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
