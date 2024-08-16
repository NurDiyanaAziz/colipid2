// ignore_for_file: unused_local_variable, must_be_immutable, prefer_typing_uninitialized_variables


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/meal_model.dart';
import 'package:colipid/pages/user/menudetail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:string_similarity/string_similarity.dart';


class ChooseMeal extends StatefulWidget {
  //const ChooseMeal({Key? key}) : super(key: key);
  String myObject;
  ChooseMeal({required this.myObject});
  @override
  _ChooseMealState createState() => _ChooseMealState();
}

class Meal {
  String label;
  Color color;
  bool isSelected;
  Meal(this.label, this.color, this.isSelected);
}

class _ChooseMealState extends State<ChooseMeal> {
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
  List<String> planName = <String>[];
  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchMeal();

    //PatientLike();
    //final comparison = 'fish'.similarityTo('chicken+fish+rice');
    //print(comparison);
    //testtext = comparison;
  }

  int index = 1;
  final prefer = TextEditingController();

  late String plan = "";
  void fetchUserData() async {
    // do something
    String plantype = widget.myObject.toString();
    setState(() {
      plan = plantype;
    });
  }

  void fetchMeal() async {
    // do something
    String plantype = widget.myObject.toString();
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("mealplan")
        .where("plantype", isEqualTo: plantype)
        .get();

    for (int i = 0; i < snap.size; i++) {
      // ignore: duplicate_ignore
      // ignore: unused_local_variable
      final meals = snap.docs;
      strTag.add(snap.docs[i]['tag'].toString());
      planName.add(snap.docs[i]['plan'].toString());
    }
    strTag.add('null');
  }

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
                  boxShadow: [
                    const BoxShadow(
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

  //List<String> arrtext = ['', '', '', '', '', '', '', '', '', '', ''];
  /*List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: FilterChip(
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: _chipsList[i].color,
          selected: _chipsList[i].isSelected,
          onSelected: (bool value) {
            setState(() {
              _chipsList[i].isSelected = value;
              if (_chipsList[i].isSelected.toString() == 'true') {
                arrtext[i] = _chipsList[i].label.toString();
              } else if (_chipsList[i].isSelected.toString() == 'false') {
                arrtext.removeAt(i);
              }
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }*/

  Future openDialog(String name, String tag) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color.fromARGB(255, 62, 151, 169),
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
                        border: InputBorder.none, hintText: 'Recommended Plan'),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: Card(
                        elevation: 5,
                        child: ListTile(
                          title: Text(name),
                          subtitle: Text(tag),
                          trailing: IconButton(
                              icon: const Icon(Icons.folder),
                              onPressed: () async {
                                QuerySnapshot snap = await FirebaseFirestore
                                    .instance
                                    .collection("mealplan")
                                    .where('plan', isEqualTo: name)
                                    .get();

                                String plantype =
                                    snap.docs[0]['plantype'].toString();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => MenuDetail(
                                              plan: name,
                                              plantype: plantype,
                                            )));
                              }),
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      });

  Stream<List<MealModel>> readMeal() => FirebaseFirestore.instance
      .collection('mealplan')
      .where('plantype', isEqualTo: plan)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => MealModel.fromJson(doc.data())).toList());

  final formKey = GlobalKey<FormState>();
  String text = '';
  var similarity;
  var planname = ['', '', '', '', ''];
  // ignore: unused_field
  static const targetStrings = <String?>[];

  var arr = [];

  //string similirity score (recommendation)
  Widget buildUserPreference() {
    return ElevatedButton(
      onPressed: () async {
        String texts = pref.text.toString();
    
        final bestMatch = StringSimilarity.findBestMatch(texts, strTag);
        int index = bestMatch.bestMatchIndex;
    
        openDialog(planName[index].toString(),
            bestMatch.bestMatch.target.toString());
      },
      child: const Text(
        'GENERATE',
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  //for preference user in button design
  Widget buildPrefBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(),
        width: 400,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OverflowBar(
               children: <Widget>[
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset("images/chicken.png"),
                    iconSize: 40,
                    highlightColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'chicken+';
                    },
                  ),
                  const Text('chicken'),
                  IconButton(
                    icon: Image.asset("images/egg.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'egg+';
                    },
                  ),
                  const Text('egg'),
                  IconButton(
                    icon: Image.asset("images/watermelon.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'watermelon+';
                    },
                  ),
                  const Text('watermelon'),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset("images/fish.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'fish+';
                    },
                  ),
                  const Text('fish'),
                  IconButton(
                    icon: Image.asset("images/apple.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'apple+';
                    },
                  ),
                  const Text('apple'),
                  IconButton(
                    icon: Image.asset("images/shrimp.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'prawn+';
                    },
                  ),
                  const Text('prawn'),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset("images/banana.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'banana+';
                    },
                  ),
                  const Text('banana'),
                  IconButton(
                    icon: Image.asset("images/bread.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'bread+';
                    },
                  ),
                  const Text('bread'),
                  IconButton(
                    icon: Image.asset("images/rice.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'rice+';
                    },
                  ),
                  const Text('rice'),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  IconButton(
                    icon: Image.asset("images/cracker.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'cracker+';
                    },
                  ),
                  const Text('cracker'),
                  IconButton(
                    icon: Image.asset("images/oat.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'oat+';
                    },
                  ),
                  const Text('oat'),
                  IconButton(
                    icon: Image.asset("images/pasta.png"),
                    iconSize: 40,
                    focusColor: Colors.blue,
                    onPressed: () {
                      pref.text += 'pasta+';
                    },
                  ),
                  const Text('pasta'),
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

  Widget buildMeals(MealModel e) => Card(
      margin: const EdgeInsets.all(14),
      elevation: 15,
      child: ListTile(
        title: Text(e.plan),
        subtitle: Text(e.tag),
        trailing: IconButton(
            icon: const Icon(Icons.folder),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MenuDetail(
                                plan: e.plan, plantype: e.plantype)));
            }),
      ));


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
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content:
                                  Text("Patient succesful added to the list")));
                          //Navigator.of(context).pushReplacement(
                          //MaterialPageRoute(
                          //   builder: (context) => ChooseMeal()));
                        }
                      },
                     style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
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

  /*Future openDialogs(MealModel e) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'View Menu Plan Detail'),
                  ),
                  SizedBox(
                    width: 320.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MenuDetail(
                                plan: e.plan, plantype: e.plantype)));
                      },
                      child: Text(
                        "View",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
*/
  @override
  Widget build(BuildContext context) {
    int index = 1;

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
                  bottom: TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 3,
                    unselectedLabelColor: const Color.fromARGB(255, 184, 183, 183),
                    tabs: const [
                      Text(
                        "Menu Plan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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
                    'Meal',
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
                          child: StreamBuilder<List<MealModel>>(
                              stream: readMeal(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text(
                                      'Something went wrong!: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  final users = snapshot.data!;
                                  
                                  return ListView(
                                      children:
                                          users.map(buildMeals).toList());
                                } else {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                     child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          buildPref(),
                          const SizedBox(
                            height: 40,
                            child: Text(
                              "Main Ingredient",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                
                          buildPrefBtn(),
                          //buildPreferCheckBox(),
                
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
