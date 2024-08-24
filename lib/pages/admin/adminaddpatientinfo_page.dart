import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  // ignore: unused_field
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
  String dropdownValue = 'Sedentary-(little or no exercise)';

  final name = TextEditingController();
  final phone = TextEditingController();
  final ic = TextEditingController();
  final height = TextEditingController();
  final dob = TextEditingController();
  final weight = TextEditingController();
  final waist = TextEditingController();
  final hip = TextEditingController();
  final age = TextEditingController();
  final detailAllergy = TextEditingController();
  double bmi = 0.0;
  double heightM = 0.0;
  String bmistat = '';
  String? hipwaistratio = '';
  String? planReco = '';
  late bool _validate = false;
  bool _showTextField = false;

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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
        Container(
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
              widget.myObject.toString(),
              style: const TextStyle(fontSize: 20),
            ))
      ],
    );
  }

  Widget buildName() {
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
            controller: name,
            keyboardType: TextInputType.name,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.people, color: Color(0x663e97a9)),
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        ),
      ],
    );
  }

  Widget buildPhone() {
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
            controller: phone,
            keyboardType: TextInputType.number,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.phone_android, color: Color(0x663e97a9)),
                hintText: 'Phone',
                hintStyle: TextStyle(color: Colors.black38)),
            maxLength: 11,
          ),
        ),
      ],
    );
  }

  Widget buildDateBirth() {
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
            controller: dob,
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.black87, fontSize: 20),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(Icons.calendar_month, color: Color(0x663e97a9)),
              hintText: 'Date of Birth',
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        )
      ],
    );
  }

  Widget buildAge() {
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
            controller: age,
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.black87, fontSize: 18),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon:
                    Icon(Icons.calendar_month, color: Color(0x663e97a9)),
                hintText: 'Age',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            _validate = waist.text.isEmpty;
          });
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
            String gend = snap.docs[0]['gender'].toString();
            //String gend = _characters.toString().substring(18);
            String aller = _character.toString().substring(17);
            String detailAllergys = detailAllergy.text;

            heightM = heights / 100;
            bmi = weights / (heightM * heightM);
            if (bmi < 18.5) {
              bmistat = "underweight";
            } else if (bmi >= 18.5 && bmi <= 24.9) {
              bmistat = "normal";
            } else if (bmi >= 25.0 && bmi <= 29.9) {
              bmistat = "overweight";
            } else if (bmi >= 30) {
              bmistat = "obese";
            }

            double whratio = waists / hips;
            if (gend == "Male") {
              if (whratio < 0.9) {
                hipwaistratio = "Low risk";
              } else if (whratio >= 0.9 && whratio <= 1.0) {
                hipwaistratio = "Moderate risk";
              } else if (whratio > 1.0) {
                hipwaistratio = "High risk";
              }
            } else if (gend == "Female") {
              if (whratio < 0.80) {
                hipwaistratio = "Low risk";
              } else if (whratio >= 0.80 && whratio <= 0.85) {
                hipwaistratio = "Moderate risk";
              } else if (whratio > 0.85) {
                hipwaistratio = "High risk";
              }
            }

            //plan Recommendation based on bmi and active type

            String activeSelected = active.split('-')[0];
            if ((bmistat == "obese" || bmistat == "overweight") &&
                activeSelected == "Very Active") {
              planReco = "2000kcal";
            } else if ((bmistat == "obese" || bmistat == "overweight") &&
                (activeSelected == "Lightly Active" ||
                    activeSelected == "Moderately Active" ||
                    activeSelected == "Sedentary")) {
              planReco = "1800kcal";
            } else if (bmistat == "normal") {
              planReco = "1800kcal";
            } else if (bmistat == "underweight") {
              planReco = "1500kcal";
            }

            final bodyprofile = BodyModel(
              ic: ics,
              date: actualDate,
              time: actualTime,
              bmi: bmi,
              bmiStatus: bmistat,
              weight: weights,
              height: heightM,
              hip: hips,
              waist: waists,
              ratio: whratio,
              ratiostat: hipwaistratio,
              planReco: planReco,
            );
            inputBody(bodyprofile);

            final docUser =
                FirebaseFirestore.instance.collection('users').doc(id);

            docUser.update({
              'active': activeSelected,
              'dob': dob.text,
              'allergic': aller,
              'detailAllergy': detailAllergys,
              'bmi': bmi,
              'bmistatus': bmistat,
              'age': ages,
              'height': heightM,
              'weight': weights,
              'waist': waists,
              'hip': hips,
              'ratio': whratio,
              'ratiostat': hipwaistratio,
              'planReco': planReco,
              'lastUpdate': actualDate,
              'lastUpdateTime': actualTime
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
        child: const Text(
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
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
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
                    onTapOutside: (PointerDownEvent event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: const TextStyle(color: Colors.black87),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                        prefixIcon:
                            Icon(Icons.height, color: Color(0x663e97a9)),
                        hintText: 'Height in cm',
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
              onTapOutside: (PointerDownEvent event) {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(top: 14, left: 20),
                hintText: 'Waist in cm',
                hintStyle: const TextStyle(color: Colors.black38),
                errorText: _validate ? "Value Can't Be Empty" : null,
              ),
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
                    onTapOutside: (PointerDownEvent event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    style: const TextStyle(color: Colors.black87),
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
          'Have any allergy?',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        ),
        const SizedBox(height: 10),
        ListTile(
          title: const Text(
            'No',
            style: TextStyle(
              fontSize: 20.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.No,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                _showTextField = false;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Yes',
            style: TextStyle(
              fontSize: 20.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          leading: Radio<SingingCharacter>(
            value: SingingCharacter.Yes,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
                _showTextField = true;
              });
            },
          ),
        ),
        if (_showTextField)
          TextField(
            controller: detailAllergy,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 255, 255, 255),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
              ),
              labelText: 'Please specify the allergy',
              labelStyle: TextStyle(color: Colors.black, fontSize: 20),
              hintStyle: const TextStyle(
                color: Colors.black, // Set the hint text color to black
              ),
            ),
            style: const TextStyle(
                color: Colors.black, fontSize: 20 // Set text color to black
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
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
        ),
        const SizedBox(height: 10),
        Container(
            padding: const EdgeInsets.all(15.0),
            width: double.infinity,
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
            height: 90,
            child: DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              isExpanded: true,
              elevation: 2,
              style: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                  letterSpacing: 1,
                  overflow: TextOverflow.visible),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Sedentary-(little or no exercise)',
                'Lightly Active-(light exercise/sports 1-3 days/week)',
                'Moderately Active-(moderate exercise/sports 3-5 days/week)',
                'Very Active-(hard exercise/sports 6-7 days a week)'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    overflow: TextOverflow
                        .visible, // Ensures the text will be truncated if it overflows
                    softWrap:
                        true, // Prevents text from wrapping to the next line
                    style: TextStyle(
                      color: value == dropdownValue
                          ? const Color.fromARGB(255, 134, 98,
                              86) // Highlight selected value with blue color
                          : Colors.black, // Normal color for non-selected items
                      fontWeight: value == dropdownValue
                          ? FontWeight.bold // Bold the selected item
                          : FontWeight
                              .normal, // Normal weight for non-selected items
                    ),
                  ),
                );
              }).toList(),
            ))
      ],
    );
  }

  Widget buildTitle(String text) {
    return Align(
      alignment: Alignment.center,
      child: AutoSizeText(
        text,
        minFontSize: 20,
        maxFontSize: 25,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  final screens = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 161, 149),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        title: const Text('Patient Information'),
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
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTitle("IC"),
                    buildID(),
                    const SizedBox(height: 15),
                    buildTitle("Name"),
                    buildName(),
                    const SizedBox(height: 15),
                    buildTitle("Phone Number"),
                    buildPhone(),
                    const SizedBox(height: 15),
                    buildTitle("Date of Birth"),
                    buildDateBirth(),
                    const SizedBox(height: 15),
                    buildTitle("Age"),
                    buildAge(),
                    const SizedBox(height: 15),
                    buildTitle("Weight(kg) and Height(cm)"),
                    buildWeightHeight(),
                    const SizedBox(height: 15),
                    buildTitle("Waist and Hip"),
                    buildWaistHip(),
                    const SizedBox(height: 20),
                    buildActiveType(),
                    const SizedBox(height: 15),
                    buildAllergic(),
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
