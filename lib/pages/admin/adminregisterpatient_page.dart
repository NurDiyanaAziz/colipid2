import 'package:age_calculator/age_calculator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/dialogs.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:colipid/pages/patientlist_model.dart';
import 'package:colipid/pages/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'adminmain.dart';

// ignore: must_be_immutable
class AdminRegisterPatient extends StatefulWidget {
  //const AdminRegisterPatient({Key? key}) : super(key: key);
  var myObject;
  AdminRegisterPatient({this.myObject});
  @override
  _AdminRegisterPatientState createState() => _AdminRegisterPatientState();
}

enum SingingCharacters { Male, Female }

class _AdminRegisterPatientState extends State<AdminRegisterPatient> {
  int index = 1;
  final name = TextEditingController();
  final phones = TextEditingController();
  final ics = TextEditingController();

  void initState() {
    super.initState();
    fetchUserData();
  }

  SingingCharacters? _characters = SingingCharacters.Male;

  late String g = "";
  late String icc = "";
  void fetchUserData() {
    // do something
    String ic = widget.myObject.toString();
    setState(() {
      icc = ic;
      ics.text = ic;
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

  Widget buildName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Patient Name',
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
          child: TextFormField(
            controller: name,
            keyboardType: TextInputType.name,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 20),
                hintText: 'Insert Patient Name',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        ListTile(
          title: const Text('Male',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 134, 98, 86),
                  fontWeight: FontWeight.w600)),
          leading: Radio<SingingCharacters>(
            value: SingingCharacters.Male,
            groupValue: _characters,
            onChanged: (SingingCharacters? value) {
              setState(() {
                g = value.toString().substring(18);
                _characters = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Female',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color.fromARGB(255, 134, 98, 86),
                  fontWeight: FontWeight.w600)),
          leading: Radio<SingingCharacters>(
            value: SingingCharacters.Female,
            groupValue: _characters,
            onChanged: (SingingCharacters? value) {
              setState(() {
                g = value.toString().substring(18);
                _characters = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildIC() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Patient IC',
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
          child: TextFormField(
            maxLength: 12,
            controller: ics,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 34, left: 20),
                hintText: 'Insert Patient IC',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Phone Number',
          style: TextStyle(
              color: Color.fromARGB(255, 134, 98, 86),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
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
          child: TextFormField(
            maxLength: 11,
            controller: phones,
            keyboardType: TextInputType.phone,
            style: const TextStyle(color: Colors.black87),
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 34, left: 20),
                hintText: 'Insert Patient Phone Number',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 90,
      width: 130,
      child: ElevatedButton(
        onPressed: () async {
          final fullname = name.text;
          final phone = phones.text;
          final ic = ics.text;

          String gend = _characters.toString().substring(18);

          // do something

          var year = ic.substring(0, 2);
          var month = ic.substring(2, 4);
          var day = ic.substring(4, 6);

          //if(year <= )

          // ignore: unused_local_variable
          var dobs = "$day/$month/19$year";
          var fullyear = "19$year";

          DateTime birthday =
              DateTime(int.parse(fullyear), int.parse(month), int.parse(day));
          DateDuration ages;
          ages = AgeCalculator.age(birthday);

          final user = UserModel(
              fullname: fullname,
              phone: phone,
              ic: ic,
              age: ages.toString(),
              gender: gend);
          final existuser =
              PatientListModel(fullname: fullname, phone: phone, ic: ic);
          //final lipid = LipidModel(ic: ic);
          regPatient(user);
          //regLipid(lipid);
          regExistPatient(existuser);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AdminMainScreen()));
        },
        child: Text(
          'Submit ',
          style: TextStyle(
              color: Colors.green[400],
              fontSize: 18,
              fontWeight: FontWeight.bold),
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
        title: const Text('Register New Patient'),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildName(),
                    const SizedBox(height: 20),
                    buildGender(),
                    const SizedBox(height: 20),
                    buildIC(),
                    const SizedBox(height: 20),
                    buildPhoneNumber(),
                    const SizedBox(height: 20),
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

  Future regPatient(UserModel user) async {
    //reference document
    final docPatient = FirebaseFirestore.instance.collection('users').doc();
    user.id = docPatient.id;
    user.usertype = 'patient';
    final json = user.toJson();
    await docPatient.set(json);
  }

  Future regExistPatient(PatientListModel user) async {
    //reference document
    final docPatient =
        FirebaseFirestore.instance.collection('listpatient').doc();
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yy');
    var formatterTime = DateFormat('HH:mm');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);
    user.date = actualDate;
    user.time = actualTime;
    user.id = docPatient.id;
    final json = user.toJson();
    await docPatient.set(json);
  }

  Future regLipid(LipidModel lipid) async {
    //reference document
    final docPatient =
        FirebaseFirestore.instance.collection('lipidreport').doc();
    lipid.id = docPatient.id;
    final json = lipid.toJson();
    await docPatient.set(json);
  }
}
