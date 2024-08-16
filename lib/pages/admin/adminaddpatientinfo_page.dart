import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/patientlist_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';

import '../body_model.dart';
import 'adminpatientmenu_page.dart';
import 'dialogs.dart';

// ignore: must_be_immutable
class AdminAddPatientInfo extends StatefulWidget {
  //const AdminAddPatientInfo(String ic, {Key? key}) : super(key: key);
  var myObject;
  AdminAddPatientInfo({this.myObject});
  @override
  _AdminAddPatientInfoState createState() => _AdminAddPatientInfoState();
}

enum SingingCharacter { No, Yes }

enum SingingCharacters { Male, Female }

class _AdminAddPatientInfoState extends State<AdminAddPatientInfo> {
  int index = 1;
  String _dropdownValue = "";
  List items = [
    'Choose',
  ];
  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchUser();
  }

  SingingCharacters? _characters = SingingCharacters.Male;
  SingingCharacter? _character = SingingCharacter.No;
  String dropdownValue = 'Sedentary';

  final name = TextEditingController();
  final phone = TextEditingController();
  final ic = TextEditingController();
  final height = TextEditingController();
  final dob = TextEditingController();
  final weight = TextEditingController();
  final waist = TextEditingController();
  final hip = TextEditingController();
  final age = TextEditingController();
  double bmi = 0.0;
  String bmistat = '';
  String? hipwaistratio = '';

  void fetchUserData() async {
    // do something
    String ic = widget.myObject.toString();
    var year = ic.substring(0, 2);
    var month = ic.substring(2, 4);
    var day = ic.substring(4, 6);

    //if(year <= )

    var dobs = day + "/" + month + "/" + "19" + year;
    var fullyear = "19" + year;

    DateTime birthday =
        DateTime(int.parse(fullyear), int.parse(month), int.parse(day));
    DateDuration duration;
    duration = AgeCalculator.age(birthday);
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("ic", isEqualTo: ic)
        .get();
    setState(() {
      name.text = snap.docs[0]['fullname'].toString();
      dob.text = dobs.toString();
      age.text = duration.toString();
      phone.text = snap.docs[0]['phone'].toString();

      ;
    });
  }

  /* String _getDOB() async {
    String dobss = "";
    return dobss;
  }*/

  late String icc = "";
  void fetchUser() {
    // do something
    String ic = widget.myObject.toString();
    setState(() {
      icc = ic;
    });
  }

  Widget buildBack() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                final action = await Dialogs.yesAbortDialog(
                    context, 'Confirm Discard?', 'Are you sure?');
                if (action == DialogAction.yes) {
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
          ),
        )),
      ],
    );
  }

  /*void _sendDataBack(BuildContext context) {
    String textToSendBack = textFieldController.text;
    Navigator.pop(context, textToSendBack);
  }*/

  Widget buildID() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                padding: const EdgeInsets.all(15),
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
                child: Text(
                  widget.myObject.toString(),
                  style: TextStyle(fontSize: 20),
                )))
      ],
    );
  }

  Widget buildName() {
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
              controller: name,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.people, color: Color(0x663e97a9)),
                  hintText: 'Name',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildPhone() {
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
              controller: phone,
              keyboardType: TextInputType.name,
              style: TextStyle(color: Colors.black87, fontSize: 20),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.phone_android, color: Color(0x663e97a9)),
                  hintText: 'Phone',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

  Widget buildDateBirth() {
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
                controller: dob,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon:
                        Icon(Icons.calendar_month, color: Color(0x663e97a9)),
                    hintText: 'Date of Birth',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ))
      ],
    );
  }

  Widget buildAge() {
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
                controller: age,
                keyboardType: TextInputType.name,
                style: TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 14),
                    prefixIcon:
                        Icon(Icons.calendar_month, color: Color(0x663e97a9)),
                    hintText: 'Age',
                    hintStyle: TextStyle(color: Colors.black38)),
              ),
            ))
      ],
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          var now = DateTime.now();
          var formatterDate = DateFormat('dd/MM/yyyy');
          var formatterTime = DateFormat('HH:mm');
          String actualDate = formatterDate.format(now);
          String actualTime = formatterTime.format(now);

          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            String ics = widget.myObject.toString();
            QuerySnapshot snap = await FirebaseFirestore.instance
                .collection("users")
                .where("ic", isEqualTo: ics)
                .get();

            String id = snap.docs[0]['id'].toString();
            String ages = age.text;
            double weights = double.parse(weight.text);
            double heights = double.parse(height.text);
            double waists = double.parse(waist.text);
            double hips = double.parse(hip.text);
            String active = dropdownValue.toString();
            String gend = _characters.toString().substring(18);
            String aller = _character.toString().substring(17);

            bmi = weights / (heights * heights);
            if (bmi < 18.5) {
              bmistat = "underweight";
            } else if (bmi >= 18.5 && bmi <= 24.9) {
              bmistat = "healthy weight";
            } else if (bmi >= 25.0 && bmi <= 29.9) {
              bmistat = "overweight";
            } else if (bmi >= 30) {
              bmistat = "obese";
            }

            double whratio = waists / hips;
            if (gend == "Male") {
              if (whratio <= 0.95) {
                hipwaistratio = "Low risk";
              } else if (whratio > 0.95 && whratio <= 1.0) {
                hipwaistratio = "Moderate risk";
              } else if (whratio > 1.0) {
                hipwaistratio = "High risk";
              }
            } else if (gend == "Female") {
              if (whratio <= 0.80) {
                hipwaistratio = "Low risk";
              } else if (whratio > 0.81 && whratio <= 0.85) {
                hipwaistratio = "Moderate risk";
              } else if (whratio > 0.86) {
                hipwaistratio = "High risk";
              }
            }

            final bodyprofile = BodyModel(
              ic: ics,
              date: actualDate,
              time: actualTime,
              bmi: bmi,
              bmiStatus: bmistat,
              weight: weights,
              height: heights,
              hip: hips,
              waist: waists,
              ratio: whratio,
              ratiostat: hipwaistratio,
              gender: gend,
            );
            inputBody(bodyprofile);

            final docUser =
                FirebaseFirestore.instance.collection('users').doc(id);

            docUser.update({
              'active': active,
              'dob': dob.text,
              'allergic': aller,
              'bmi': bmi,
              'gender': gend,
              'bmistatus': bmistat,
              'age': ages,
              'height': heights,
              'weight': weights,
              'waist': waists,
              'hip': hips,
              'ratio': whratio,
              'ratiostat': hipwaistratio,
            });

            /*DocumentReference documentReference =
                FirebaseFirestore.instance.collection('users').document(id);
            Map<String, dynamic> user = {
              'active': active,
              'dob': dob.text,
              'allergic': aller,
              'bmi': bmi,
              'gender': gend,
              'bmistatus': bmistat,
              'age': ages,
              'height': heights,
              'weight': weights,
              'waist': waists,
              'hip': hips,
              'waisthipratio': hipwaistratio,
              'totalhwratio': whratio,
            };*/ // <-- Updated data

            /*documentReference.setData(user).whenComplete(() {
              print("$id updated");
            });*/
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

  Widget buildWeightHeight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
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
            height: 60,
            width: 180,
            child: TextField(
              controller: weight,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.monitor_weight, color: Color(0x663e97a9)),
                  hintText: 'Weight in kg',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )),
        Flexible(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
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
                  height: 60,
                  width: 180,
                  child: TextField(
                    controller: height,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon:
                            Icon(Icons.height, color: Color(0x663e97a9)),
                        hintText: 'Height in meter',
                        hintStyle: TextStyle(color: Colors.black38)),
                  ),
                )))
      ],
    );
  }

  Widget buildWaistHip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
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
            width: 180,
            child: TextField(
              controller: waist,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14, left: 20),
                  hintText: 'Waist in cm',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )),
        Flexible(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
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
                  width: 180,
                  child: TextField(
                    controller: hip,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: 'Hip in cm',
                        hintStyle: TextStyle(color: Colors.black38)),
                  ),
                )))
      ],
    );
  }

  void onChangedAllergic(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
  }

  Widget buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: const Text('Male',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
          leading: Radio<SingingCharacters>(
            value: SingingCharacters.Male,
            groupValue: _characters,
            onChanged: (SingingCharacters? value) {
              setState(() {
                _characters = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
          leading: Radio<SingingCharacters>(
            value: SingingCharacters.Female,
            groupValue: _characters,
            onChanged: (SingingCharacters? value) {
              setState(() {
                _characters = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildAllergic() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Have allergic?',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: const Text(
            'No',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.No,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Yes',
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Yes,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildActiveType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'How Active Are You',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(15.0),
            width: 200,
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
            height: 80,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(
                  color: Color.fromARGB(255, 92, 57, 4), fontSize: 18),
              underline: Container(
                height: 2,
                color: Color.fromARGB(255, 128, 101, 14),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Sedentary', 'Moderately Active', 'Active']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ))
      ],
    );
  }

  final screens = [];

  @override
  Widget build(BuildContext context) {
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
                      'Patient Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    buildBack(),
                    SizedBox(height: 30),
                    buildID(),
                    buildName(),
                    buildPhone(),
                    buildDateBirth(),
                    buildAge(),
                    buildWeightHeight(),
                    buildWaistHip(),
                    SizedBox(height: 20),
                    buildGender(),
                    SizedBox(height: 20),
                    buildAllergic(),
                    SizedBox(height: 15),
                    buildActiveType(),
                    SizedBox(height: 15),
                    buildSubmitBtn()
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

Future inputBody(BodyModel lipid) async {
  //reference document
  final bodyP = FirebaseFirestore.instance.collection('bodyreport').doc();

  lipid.id = bodyP.id;
  final json = lipid.toJson();
  await bodyP.set(json);
}
