// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/exercise_model.dart';
import 'package:colipid/pages/exercisetaken_model.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';

class ChooseExercise extends StatefulWidget {
  const ChooseExercise({Key? key}) : super(key: key);

  @override
  _ChooseExerciseState createState() => _ChooseExerciseState();
}

late SharedPreferences logindata;

class Meal {
  String label;
  Color color;
  bool isSelected;
  Meal(this.label, this.color, this.isSelected);
}

class _ChooseExerciseState extends State<ChooseExercise> {
  bool selected = false;

//latest update
  List multipleSelected = [];
  List checkListItems = [
    {
      "id": 0,
      "value": false,
      "title": "Chicken",
    },
    {
      "id": 1,
      "value": false,
      "title": "Fish",
    },
    {
      "id": 2,
      "value": false,
      "title": "Pasta",
    },
    {
      "id": 3,
      "value": false,
      "title": "Oat",
    },
    {
      "id": 4,
      "value": false,
      "title": "Egg",
    },
    {
      "id": 5,
      "value": false,
      "title": "Milk",
    },
    {
      "id": 6,
      "value": false,
      "title": "Rice",
    },
    {
      "id": 7,
      "value": false,
      "title": "Bread",
    },
  ];
  List<String> strTag = <String>[];
  List<String> exerName = <String>[];
  @override
  void initState() {
    super.initState();
    fetchExer();
  }

  void fetchExer() async {
    // do something

    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection("exercise").get();

    for (int i = 0; i < snap.size; i++) {
      final meals = snap.docs;
      strTag.add(snap.docs[i]['tag'].toString());
      exerName.add(snap.docs[i]['name'].toString());
    }
  }

  int index = 1;

  final pref = TextEditingController();
  Widget buildPref() {
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
              height: 40,
              child: TextField(
                //enabled: false,
                controller: pref,
                keyboardType: TextInputType.name,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(5.0),
                  hintStyle: const TextStyle(color: Colors.black38),
                  suffixIcon: IconButton(
                    onPressed: pref.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  final prefer = TextEditingController();

  Widget buildExercise(ExerciseModel e) => Card(
      margin: const EdgeInsets.all(14),
      elevation: 15,
      child: ListTile(
        title: Text(e.name),
        subtitle: Text(e.tag),
        trailing: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              openDialogs(e);
            }),
      ));

  final exer = TextEditingController();
  Widget buildAddDuration() {
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
              height: 40,
              child: TextField(
                controller: exer,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black87),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(5.0),
                  hintText: 'Duration of exercise (min)',
                  hintStyle: const TextStyle(color: Colors.black38),
                  suffixIcon: IconButton(
                    onPressed: exer.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ))
      ],
    );
  }

  bool value = false;
  Map<String, bool> values = {
    'Apple': false,
    'Banana': false,
    'Cherry': false,
    'Mango': false,
    'Orange': false,
  };
  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(tmpArray);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    tmpArray.clear();
  }

  Widget buildPreferCheckBox() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                      checkListItems.length,
                      (index) => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          checkListItems[index]["title"],
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                        value: checkListItems[index]["value"],
                        onChanged: (value) {
                          setState(() {
                            checkListItems[index]["value"] = value;
                            if (multipleSelected
                                .contains(checkListItems[index])) {
                              multipleSelected.remove(checkListItems[index]);
                            } else {
                              multipleSelected.add(checkListItems[index]);
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ]);
    });
  }

  Future openDialog(String name, String tag) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Recommended Exercise'),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: Card(
                        color: const Color.fromARGB(255, 62, 151, 169),
                        elevation: 5,
                        child: ListTile(
                          title: Text(name),
                          subtitle: Text(tag),
                          trailing: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () async {
                                QuerySnapshot snap = await FirebaseFirestore
                                    .instance
                                    .collection("exercise")
                                    .where("name", isEqualTo: name)
                                    .get();

                                final e = ExerciseModel(
                                  name: snap.docs[0]['name'].toString(),
                                  met: snap.docs[0]['mets'],
                                  tag: snap.docs[0]['tag'].toString(),
                                );

                                openDialogs(e);
                              }),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  Stream<List<ExerciseModel>> readExercise() => FirebaseFirestore.instance
      .collection('exercise')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ExerciseModel.fromJson(doc.data()))
          .toList());

  final formKey = new GlobalKey<FormState>();
  String text = '';
  var similarity;
  var planname = ['', '', '', '', ''];

  var arr = [];

  //string similirity score (recommendation)
  Widget buildUserPreference() {
    final ButtonStyle styles = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 20),
        backgroundColor: Color(0xcc3e97a9));

    return ElevatedButton(
      style: styles,
      onPressed: () async {
        String texts = pref.text.toString();

        final bestMatch = StringSimilarity.findBestMatch(texts, strTag);
        int index = bestMatch.bestMatchIndex;

        openDialog(
            exerName[index].toString(), bestMatch.bestMatch.target.toString());
      },
      child: const Text(
        'GENERATE',
        style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  //for preference user in button design

  Widget buildLevelBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(),
        width: 400,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OverflowBar(
              spacing: 20,
              children: <Widget>[
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "images/1.png",
                      scale: 3,
                    ),
                    highlightColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'beginner+';
                    },
                  ),
                  const Text('beginner'),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "images/2.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'intermediate+';
                    },
                  ),
                  const Text('intermediate'),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "images/3.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'advanced+';
                    },
                  ),
                  const Text('advanced'),
                ]),
              ],
            )
          ],
        ));
  }

  Widget buildPrefBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        width: 400,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OverflowBar(
              spacing: 20,
              children: <Widget>[
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "images/walking.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'walking+';
                    },
                  ),
                  const Text('walking'),
                  IconButton(
                    icon: Image.asset(
                      "images/yoga.png",
                      scale: 3,
                    ),
                    highlightColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'yoga+';
                    },
                  ),
                  const Text('yoga'),
                  IconButton(
                    icon: Image.asset(
                      "images/weightlifting.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'weight lifting+';
                    },
                  ),
                  const Text('weight lifting'),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "images/bicycle.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'bicycle+';
                    },
                  ),
                  const Text('bicycle'),
                  IconButton(
                    icon: Image.asset(
                      "images/houseclean.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'house activities+';
                    },
                  ),
                  const Text('cleaning house'),
                  IconButton(
                    icon: Image.asset(
                      "images/jumprope.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'rope jumping+';
                    },
                  ),
                  const Text('rope jumping'),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset(
                      "images/swim.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'swimming+';
                    },
                  ),
                  const Text('swimming'),
                  IconButton(
                    icon: Image.asset(
                      "images/dancing.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'dancing+';
                    },
                  ),
                  const Text('dancing'),
                  IconButton(
                    icon: Image.asset(
                      "images/boxing.png",
                      scale: 3,
                    ),
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'boxing+';
                    },
                  ),
                  const Text('boxing'),
                ]),
              ],
            )
          ],
        ));
  }

  Widget buildPrefs() {
    return ElevatedButton(
      onPressed: () {
        patientLike();
      },
      child: const Text(
        'PATIENT PREFERENCES',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future patientLike() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What kind of ingredient you want in your plan',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: 320.0,
                    child: Form(
                        key: formKey,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 20),
                          decoration: const InputDecoration(
                            prefix: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(''),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(top: 14, left: 1),
                            hintText: 'Insert IC patient',
                            hintStyle: TextStyle(color: Colors.black38),
                          ),
                          maxLength: 12,
                          controller: prefer,
                          validator: (value) =>
                              value!.isEmpty ? 'Field cannot be empty' : null,
                        )),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        final checkIC = prefer.text;
                        //final user = UserModel(ic: checkIC);
                        //checkPatient(user);
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("mealplan")
                            .get();

                        if (snap.size > 0) {
                          //exists
                          final fullname = snap.docs[0]['fullname'].toString();
                          final phone = snap.docs[0]['phone'].toString();
                          final ic = snap.docs[0]['ic'].toString();

                          //final user = PatientListModel(
                          // fullname: fullname, phone: phone, ic: ic);

                          //regPatient(user);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Patient succesful added to the list")));
                          //Navigator.of(context).pushReplacement(
                          //MaterialPageRoute(
                          //   builder: (context) => ChooseMeal()));
                        }
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });

  Future openDialogs(ExerciseModel e) => showDialog(
      context: context,
      builder: (BuildContext context) {
        final ButtonStyle styles = ElevatedButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
            backgroundColor: Color(0xcc3e97a9));
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Add Duration",
                    style: TextStyle(fontSize: 20),
                  ),
                  buildAddDuration(),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      style: styles,
                      onPressed: () async {
                        var now = DateTime.now();
                        var formatterDate = DateFormat('dd/MM/yyyy');
                        var formatterTime = DateFormat('HH:mm');
                        String actualDate = formatterDate.format(now);
                        String actualTime = formatterTime.format(now);

                        const index = 1;
                        final ic;
                        final dur = exer.text;
                        logindata = await SharedPreferences.getInstance();
                        String name = e.name;
                        double durat = double.parse(dur);

                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("users")
                            .where("ic",
                                isEqualTo: logindata.getString('ic').toString())
                            .get();

                        double weight = snap.docs[0]['weight'];

                        //burn calories calculation
                        final total = durat * e.met * weight / 200;

                        final exerprofile = ExerciseTakenModel(
                          ic: logindata.getString('ic').toString(),
                          date: actualDate,
                          time: actualTime,
                          durations: double.parse(dur),
                          name: name,
                          cal: double.parse((total).toStringAsFixed(2)),
                        );
                        inputExercise(exerprofile);

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Exercise succesful added into the list")));
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => UserMainScreen(
                                  myObject: 1,
                                )));
                      },
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  Widget buildBeginnerBtn() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    height: 20,
                    width: 50,
                    child: ElevatedButton(
                      onPressed: () async {},
                      child: Text(
                        'Beginner',
                        style: TextStyle(
                            color: Colors.blue[400],
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.file_open, size: 30),
      const Icon(Icons.home, size: 30),
      const Icon(Icons.person, size: 30),
    ];

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0x663e97a9),
                Color(0x993e97a9),
                Color(0xcc3e97a9),
                Color(0xff3e97a9),
              ],
            )),
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  bottom: const TabBar(
                    labelColor: Color.fromARGB(255, 255, 255, 255),
                    indicatorColor: Color.fromARGB(255, 255, 255, 255),
                    indicatorWeight: 3,
                    unselectedLabelColor: Color.fromARGB(255, 131, 131, 131),
                    tabs: [
                      Text(
                        "Exercise",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Recommendation",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  backgroundColor: const Color.fromARGB(255, 62, 151, 169),
                  title: const Text(
                    'Exercise',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  elevation: 0.0,
                ),
                body: TabBarView(children: [
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 750,
                          child: StreamBuilder<List<ExerciseModel>>(
                              stream: readExercise(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      'Something went wrong!: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final users = snapshot.data!;

                                  return ListView(
                                      children:
                                          users.map(buildExercise).toList());
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        buildPref(),
                        const SizedBox(
                          child: Text(
                            "Level",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        buildLevelBtn(),
                        const SizedBox(height: 15),
                        const SizedBox(
                          child: Text(
                            "Exercise",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        buildPrefBtn(),
                        buildUserPreference(),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

Future inputExercise(ExerciseTakenModel exer) async {
  //reference document
  final exerc = FirebaseFirestore.instance.collection('exercisereport').doc();

  exer.id = exerc.id;
  final json = exer.toJson();
  await exerc.set(json);
}
