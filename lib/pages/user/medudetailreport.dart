import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/user/app_large_text.dart';
import 'package:colipid/pages/user/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../mealtaken_model.dart';

// ignore: must_be_immutable
class MenuDetailReport extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  MenuDetailReport({required this.plan});
  final String plan;

  @override
  _MenuDetailReportState createState() => _MenuDetailReportState();
}

class _MenuDetailReportState extends State<MenuDetailReport> {
  int index = 1;

  List text1 = ["Breakfast", "Morning Tea", "Lunch", "Teatime", "Dinner"];

  List images = [
    "morning.png",
    "morning tea.png",
    "lunch.png",
    "teatime.png",
    "dinner.png",
  ];

  List<String> detailbreakfast = [];
  List<String> detailmorningtea = [];
  List<String> detaillunch = [];
  List<String> detailteatime = [];
  List<String> detaildinner = [];
  List<String> allDetail = [];

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  PageController page = PageController(initialPage: 0);
  int pageIndex = 0;

  late String arrayBreakfast;
  late String arrayMorningtea;
  late String arrayLunch;
  late String arrayTeatime;
  late String arrayDinner;
  Future<void> fetchDetail() async {
    // do something
    String planname = widget.plan;

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("mealplan")
        .where("plan", isEqualTo: planname)
        .get();

    arrayBreakfast = snap.docs[0]['breakfast'].toString();
    arrayMorningtea = snap.docs[0]['morningtea'].toString();
    arrayLunch = snap.docs[0]['lunch'].toString();
    arrayTeatime = snap.docs[0]['teatime'].toString();
    arrayDinner = snap.docs[0]['dinner'].toString();
    setState(() {
      detailbreakfast = arrayBreakfast.split('+');
      detailmorningtea = arrayMorningtea.split('+');
      detaillunch = arrayLunch.split('+');
      detailteatime = arrayTeatime.split('+');
      detaildinner = arrayDinner.split('+');
      plannames = planname;
    });
  }

  late SharedPreferences logindata;
  late String plannames = "";

  Widget buildBackChooseBtn() {
    final ButtonStyle styles = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: Color(0xcc3e97a9));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 70,
                width: 100,
                child: ElevatedButton(
                  style: styles,
                  onPressed: () async {
                    // ignore: unused_local_variable
                    final index = 0;
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget buildViewMeal() {
    return Container(child: const Text(''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height - 80,
                child: PageView(
                  controller: page,
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/morning.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 150, left: 20, right: 20),
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: text1[0]),
                                  const SizedBox(height: 15),
                                  for (var i in detailbreakfast)
                                    AppText(text: i.toString()),
                                ],
                              ),
                            ]))),
                    Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/morning tea.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 150, left: 20, right: 20),
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: text1[1]),
                                  const SizedBox(height: 15),
                                  for (var i in detailmorningtea)
                                    AppText(text: i.toString()),
                                ],
                              ),
                            ]))),
                    Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/lunch.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 150, left: 20, right: 20),
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: text1[2]),
                                  const SizedBox(height: 15),
                                  for (var i in detaillunch)
                                    AppText(text: i.toString()),
                                ],
                              ),
                            ]))),
                    Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/teatime.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 150, left: 20, right: 20),
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: text1[3]),
                                  const SizedBox(height: 15),
                                  for (var i in detailteatime)
                                    AppText(text: i.toString()),
                                ],
                              ),
                            ]))),
                    Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/dinner.png'),
                                fit: BoxFit.cover)),
                        child: Container(
                            margin: const EdgeInsets.only(
                                top: 150, left: 20, right: 20),
                            child: Row(children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppLargeText(text: text1[4]),
                                  const SizedBox(height: 15),
                                  for (var i in detaildinner)
                                    AppText(text: i.toString()),
                                ],
                              ),
                            ]))),
                  ],
                ),
              ),

              // buildViewMeal(),

              buildBackChooseBtn(),
            ],
          ),
        ),
      ),
    );
  }
}

Future inputMeal(MealTakenModel meal) async {
  //reference document
  final mealc = FirebaseFirestore.instance.collection('mealtaken').doc();

  meal.id = mealc.id;
  final json = meal.toJson();
  await mealc.set(json);
}
