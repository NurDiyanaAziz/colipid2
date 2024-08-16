import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/body_model.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exercisetaken_model.dart';

// ignore: must_be_immutable
class userViewExercise extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  userViewExercise({this.myObject});
  @override
  _userViewExerciseState createState() => _userViewExerciseState();
}

class _userViewExerciseState extends State<userViewExercise> {
  int index = 1;

  @override
  void initState() {
    super.initState();
    fetchUser();
    fetchTotal();
  }

  late SharedPreferences logindata;
  final tot = TextEditingController();

  late String icc = "";
  late String total = "";
  String actualDate = "";
  Future<void> fetchUser() async {
    // do something
    logindata = await SharedPreferences.getInstance();
    String ic = logindata.getString('ic').toString();
    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String date = formatterDate.format(now);
    setState(() {
      icc = ic;
      actualDate = date;
    });
  }

  Future<void> fetchTotal() async {
    // do something
    logindata = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    String ic = logindata.getString('ic').toString();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("exercisereport")
        .where("date", isEqualTo: actualDate)
        .get();

    double weight = 0;
    int size = snap.size;
    String temp = '';
    for (int i = 0; i < size; i++) {
      weight += snap.docs[i]['cal'];
      temp = weight.toStringAsFixed(2);
    }

    setState(() {
      total = temp;
    });
  }

  Widget buildReportUsers(ExerciseTakenModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: const Color.fromARGB(255, 121, 163, 167),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    e.date.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.w500),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Exercise Name: ${e.name}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Time Added: ${e.time}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Calories Burned: ${e.cal} cal',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Duration of Exercise: ${e.durations} min',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),

                //SizedBox
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      );

  Widget buildBodyReportUsers(BodyModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: const Color.fromARGB(255, 255, 254, 254),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //SizedBox
                Text(
                  e.date.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //Textstyle
                ), //Text
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ), //Textstyle
                ), //Text
                //SizedBox
                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'WEIGHT: ${e.weight}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'HEIGHT: ${e.height}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'BMI: ${double.parse(e.bmi.toStringAsFixed(2))}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'WAIST: ${e.waist}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'HIP: ${e.hip}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'WS/HIP: ${double.parse(e.ratio.toStringAsFixed(2))}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      children: [
                        const Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        const Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.bmiStatus,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        const Text(
                          ' ',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        const Text(
                          '',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.ratiostat.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      );

  Stream<List<ExerciseTakenModel>> readExerciseReport() =>
      FirebaseFirestore.instance
          .collection('exercisereport')
          .where("date", isEqualTo: actualDate)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ExerciseTakenModel.fromJson(doc.data()))
              .toList());

  Widget buildBackBtn() {
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
                        const index = 1;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                UserMainScreen(myObject: index)));
                      },
                      child: Text(
                        'Back',
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
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
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Exercise Report',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Total calories burned: $total cal',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 80,
                      child: StreamBuilder<List<ExerciseTakenModel>>(
                          stream: readExerciseReport(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(
                                  'Something went wrong!: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final users = snapshot.data!;

                              return ListView(
                                  children:
                                      users.map(buildReportUsers).toList());
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          }),
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
