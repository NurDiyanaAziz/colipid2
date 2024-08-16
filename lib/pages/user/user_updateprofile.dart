import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/body_model.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/dialogs.dart';

class UserUpdateInfo extends StatefulWidget {
  //const AdminAddPatientInfo(String ic, {Key? key}) : super(key: key);

  @override
  _UserUpdateInfoState createState() => _UserUpdateInfoState();
}

enum SingingCharacter { No, Yes }

enum SingingCharacters { Male, Female }

class _UserUpdateInfoState extends State<UserUpdateInfo> {
  int index = 1;
  List items = [
    'Choose',
  ];

  late String names;
  late String weights;
  late String heights;
  late String bmis;
  late String bmistats;

  late SharedPreferences logindata;
  late String ics = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    names = '';
    weights = '';
    heights = '';
    bmis = '';
    bmistats = '';
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
        .get();

    double bmi1 = double.parse((snap.docs[0]['bmi']).toStringAsFixed(2));

    setState(() {
      ics = logindata.getString('ic').toString();
      name.text = snap.docs[0]['fullname'].toString();
      weight.text = snap.docs[0]['weight'].toString();
      height.text = snap.docs[0]['height'].toString();
      phone.text = snap.docs[0]['phone'].toString();
      dob.text = snap.docs[0]['dob'].toString();
      age.text = snap.docs[0]['age'].toString();
      waist.text = snap.docs[0]['waist'].toString();
      hip.text = snap.docs[0]['hip'].toString();

      bmis = bmi1.toString();
      bmistats = snap.docs[0]['bmistatus'].toString();
    });
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
  double bmiss = 0.0;
  String bmistat = '';
  String hipwaistratio = '';

  Widget buildBack() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: 70,
            width: 100,
            child: ElevatedButton(
              onPressed: () async {
                const index = 0;
                final action = await Dialogs.yesAbortDialog(
                    context, 'Confirm discard?', 'Are you sure?');
                if (action == DialogAction.yes) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => UserMainScreen(myObject: index)));
                }
              },
              child: const Text(
                'Back',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
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
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 2))
                    ]),
                height: 60,
                child: Text(
                  ics,
                  style: const TextStyle(fontSize: 20),
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
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              enabled: false,
              controller: name,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
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
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            height: 60,
            child: TextField(
              controller: phone,
              keyboardType: TextInputType.name,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
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
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                controller: dob,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
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
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                enabled: false,
                controller: age,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black87),
                decoration: const InputDecoration(
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
    final ButtonStyle styles = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: Color(0xcc3e97a9));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: 150,
      child: ElevatedButton(
        style: styles,
        onPressed: () async {
          var now = DateTime.now();
          var formatterDate = DateFormat('dd/MM/yyyy');
          var formatterTime = DateFormat('HH:mm');
          String actualDate = formatterDate.format(now);
          String actualTime = formatterTime.format(now);

          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
            QuerySnapshot snap = await FirebaseFirestore.instance
                .collection("users")
                .where("ic", isEqualTo: logindata.getString('ic').toString())
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

            bmiss = weights / (heights * heights);
            if (bmiss < 18.5) {
              bmistat = "Underweight";
            } else if (bmiss >= 18.5 && bmiss <= 24.9) {
              bmistat = "Normal weight";
            } else if (bmiss >= 25.0 && bmiss <= 29.9) {
              bmistat = "Overweight";
            } else if (bmiss >= 30) {
              bmistat = "Obesity";
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
              ic: logindata.getString('ic').toString(),
              date: actualDate,
              time: actualTime,
              bmi: bmiss,
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
              'bmi': bmiss,
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

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => UserMainScreen(myObject: 0)));
          }
        },
        child: const Text(
          'Submit',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildWeightHeight() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
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
              controller: weight,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black87),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.monitor_weight, color: Color(0x663e97a9)),
                  hintText: 'Weight in kg',
                  hintStyle: TextStyle(color: Colors.black38),
                  suffixText: 'kg'),
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
                    controller: height,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon:
                            Icon(Icons.height, color: Color(0x663e97a9)),
                        hintText: 'Height in meter',
                        hintStyle: TextStyle(color: Colors.black38),
                        suffix: Text(
                          'm',
                        )),
                  ),
                )))
      ],
    );
  }

  Widget buildWaistHip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ],
            ),
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
                  hintStyle: TextStyle(color: Colors.black38),
                  suffix: Text(
                    'cm',
                  )),
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
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 20),
                        hintText: 'Hip in cm',
                        hintStyle: TextStyle(color: Colors.black38),
                        suffix: Text(
                          'cm',
                        )),
                  ),
                )))
      ],
    );
  }

  Widget buildWaistHipLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            alignment: Alignment.centerLeft,
            width: 180,
            child: const Column(children: [
              Text(
                "Waist(cm)",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w600),
              ),
            ]),
          ),
        )),
        Flexible(
            child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: 180,
                  child: const Column(children: [
                    Text(
                      "Hip(cm)",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
                )))
      ],
    );
  }

  void onChangedAllergic(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {});
    }
  }

  Widget buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Gender',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
        const Text(
          'Have allergic?',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
        const Text(
          'How Active Are You',
          style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(15.0),
            width: 200,
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
            height: 80,
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(162, 218, 218, 218),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        title: const Text('Update information'),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
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
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildName(),
                    buildAge(),
                    buildWeightHeight(),
                    const SizedBox(height: 20),
                    buildWaistHipLabel(),
                    buildWaistHip(),
                    const SizedBox(height: 25),
                    buildActiveType(),
                    const SizedBox(height: 15),
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
