import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/user/chooseexercise.dart';
import 'package:colipid/pages/user/viewexercise.dart';
import 'package:colipid/pages/user/viewmealtaken.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../custom_animation.dart';
import 'choosemeal_page.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int index = 2;
  late String name;
  late String weight;
  late String height;
  late String bmi;
  late String bmistat;
  late String whratiostat;
  late String planReco;

  late SharedPreferences logindata;

  late String ic;
  @override
  void initState() {
    // TODO: implement initState
    //configLoading();
    super.initState();

    name = '';
    weight = '';
    height = '';
    bmi = '';
    bmistat = '';
    whratiostat = '';
    planReco = '';

    initial();
    initialProfile();
    initialPercent();
    //initialPlanMeal();
  }

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();
  }

  late String total = "";
  late String totalDur = "";
  late String percents = "";
  late double percentss = 0.0;
  late String perc = ""; //percent inside circle

  initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      name = logindata.getString('name').toString();
    });
  }

  initialPlanMeal() async {
    logindata = await SharedPreferences.getInstance();
    QuerySnapshot snaps = await FirebaseFirestore.instance
        .collection("bodyreport")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
        .orderBy("date", descending: true)
        .get();

    setState(() {
      planReco = snaps.docs[0]['ic'].toString();
    });
  }

  initialProfile() async {
    logindata = await SharedPreferences.getInstance();
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("fullname", isEqualTo: logindata.getString('name').toString())
        .get();

    setState(() {
      weight = snap.docs[0]['weight'].toString();
      height = snap.docs[0]['height'].toString();
      bmi = snap.docs[0]['bmi'].toStringAsFixed(2);
      bmistat = snap.docs[0]['bmistatus'].toString();
      whratiostat = snap.docs[0]['ratiostat'].toString();
      planReco = snap.docs[0]['planReco'].toString();
    });
  }

  void initialPercent() async {
    logindata = await SharedPreferences.getInstance();

    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String actualDate = formatterDate.format(now);

    QuerySnapshot snaps = await FirebaseFirestore.instance
        .collection("exercisereport")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
        .where("date", isEqualTo: actualDate)
        .get();

    double cal = 0;
    double dur = 0;
    int size = snaps.size;
    String temp = '';
    String tempDur = '0.0';
    double tempCalcPercent = 0.0;
    double tempCalcPer = 0.0;
    double percents1 = 0.0;
    String calPer = '';
    double tempdurr = 0.0;
    for (int i = 0; i < size; i++) {
      cal += snaps.docs[i]['cal'];
      temp = cal.toStringAsFixed(2);
      dur += snaps.docs[i]['duration'];
      tempDur = dur.toStringAsFixed(0);
    }

    tempdurr = double.parse(tempDur);
    //check if user done their min 30 min exercise
    if (tempdurr < 45.0) {
      tempCalcPercent = double.parse(tempDur) / 60;
      percents1 = double.parse(tempCalcPercent.toStringAsFixed(1));

      tempCalcPer = tempCalcPercent * 100;
      calPer = tempCalcPer.toStringAsFixed(1);
    } else if (tempdurr >= 45.0) {
      percents1 = 1.0;
      calPer = '100.0';
    }

    //suggest food set based on bmi value

    setState(() {
      ic = logindata.getString('ic').toString();

      total = temp;
      totalDur = tempDur;
      percents = percents1.toStringAsFixed(1);
      percentss = double.parse(percents);
      perc = calPer;
    });
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

  Future openDialogMenu() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            width: 300.0,
            height: 300, // Set the desired width
            padding: const EdgeInsets.all(16.0), // Add some padding for spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTitle("Recommended plan meal "),
                if (planReco == "1500kcal") ...[
                  SizedBox(
                    width: 300.0,
                    child: TextButton.icon(
                      icon: Image.asset(
                        "images/1.png",
                        scale: 2,
                      ),
                      label: const Text(
                        "1500KCAL",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      onPressed: () {
                        String word = "1500kcal";
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => ChooseMeal(
                              myObject: word,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
                if (planReco == "1800kcal") ...[
                  SizedBox(
                    width: 300.0,
                    child: TextButton.icon(
                      icon: Image.asset(
                        "images/2.png",
                        scale: 2,
                      ),
                      label: const Text(
                        "1800KCAL",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      onPressed: () {
                        // call method
                        String word = "1800kcal";
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ChooseMeal(
                                  myObject: word,
                                )));
                      },
                    ),
                  ),
                ],
                if (planReco == "2000kcal") ...[
                  SizedBox(
                    width: 300.0,
                    child: TextButton.icon(
                      icon: Image.asset(
                        "images/3.png",
                        scale: 2,
                      ),
                      label: const Text(
                        "2000KCAL",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      onPressed: () {
                        // call method
                        String word = "2000kcal";
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => ChooseMeal(
                                  myObject: word,
                                )));
                      },
                    ),
                  ),
                ],
                SizedBox(
                  width: 300.0,
                  child: TextButton.icon(
                    icon: Image.asset(
                      "images/meal.png",
                      scale: 2,
                    ),
                    label: const Text(
                      "View Meal Taken",
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    onPressed: () {
                      // call method
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => userViewMealTaken()));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });

  Future openDialogExercise() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Exercise',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200.0,
                    height: 100,
                    child: TextButton.icon(
                      icon: Image.asset(
                        "images/exercise.png",
                        scale: 2,
                      ),
                      label: const Text(
                        "Add Exercise",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      onPressed: () {
                        // call method
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const ChooseExercise()));
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200.0,
                    height: 100,
                    child: TextButton.icon(
                      icon: Image.asset(
                        "images/report1.png",
                        scale: 2,
                      ),
                      label: const Text(
                        "View Exercise",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      onPressed: () {
                        // call method
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => userViewExercise()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.center,
          child: Image.asset(
            'images/ic_launcher.png',
            scale: 4,
          ),
        ),
        backgroundColor: const Color.fromARGB(0, 46, 41, 41),
        elevation: 0,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        height: 25,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Hi $name,',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Welcome ',
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 119, 170, 182),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Weight :  $weight kg',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Height : $height m',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'BMI : $bmi',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'BMI Status : $bmistat',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Waist-Hip Ratio (WHR) : $whratiostat',
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InkWell(
                              child: const Align(
                                alignment: Alignment.topRight,
                                child: Text(
                                  '',
                                  style: TextStyle(
                                      letterSpacing: 1.5,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              onTap: () {
                                //
                              },
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        //
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xFFA1ADE9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 250,
                            width: 170,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Meal',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Image.asset(
                                        'images/food.png',
                                      ),
                                    ),
                                  ],
                                ),
                                const Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Set meals to choose',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            openDialogMenu();
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xFFFB8B8B),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 250,
                            width: 170,
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Exercise ',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'images/circle.png',
                                        scale: 0.8,
                                      ),
                                    ),
                                    CircularPercentIndicator(
                                      startAngle: 0.4,
                                      radius: 60.0,
                                      lineWidth: 13.0,
                                      animation: true,
                                      percent: percentss,
                                      center: Text(
                                        "$perc%",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      progressColor: Colors.purple,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Total: $total cal',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Duration: $totalDur min',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            openDialogExercise();
                          },
                        ),
                      ],
                    ),
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
