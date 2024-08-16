// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:colipid/pages/user/medudetailreport.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mealtaken_model.dart';

// ignore: must_be_immutable
class userViewMealTaken extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  userViewMealTaken({this.myObject});
  @override
  _userViewMealTakenState createState() => _userViewMealTakenState();
}

class _userViewMealTakenState extends State<userViewMealTaken> {
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
    String ic = logindata.getString('ic').toString();

    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String actualDate = formatterDate.format(now);

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("exercisereport")
        .where("date", isEqualTo: actualDate)
        .get();

    double weight = 0;
    int size = snap.size;
    for (int i = 0; i < size; i++) {
      weight += snap.docs[i]['cal'];
    }

    setState(() {
      total = weight.toString();
    });
  }

  Widget buildReportUsers(MealTakenModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: const Color.fromARGB(255, 136, 193, 201),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                //SizedBox
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    e.date.toString(),
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w400),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Plan Name: ${e.plan}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Calories: ${e.plantype}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Time Added: ${e.time}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xcc3e97a9)),
                    ),
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MenuDetailReport(plan: e.plan)));
                    },
                    child: const Text(
                      'VIEW',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                //SizedBox
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      );

  Stream<List<MealTakenModel>> readMealTakenReport() =>
      FirebaseFirestore.instance
          .collection('mealtaken')
          .where('ic', isEqualTo: icc)
          .where("date", isEqualTo: actualDate)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => MealTakenModel.fromJson(doc.data()))
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
                        final index = 1;
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
    int index = 1;

    final items = <Widget>[
      const Icon(Icons.file_open, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(162, 218, 218, 218),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
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
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Meal Taken Today',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 570,
                      child: StreamBuilder<List<MealTakenModel>>(
                          stream: readMealTakenReport(),
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
