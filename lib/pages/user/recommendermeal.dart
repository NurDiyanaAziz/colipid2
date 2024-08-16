// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/meal_model.dart';
import 'package:flutter/material.dart';

late String prefs1 = '';
late String prefs2 = '';
late String prefs3 = '';
late String prefs4 = '';

class recommendMeal extends StatefulWidget {
  const recommendMeal({
    Key? key,
  }) : super(key: key);

  // var myObject;
  // recommendMeal(@required String planname, String planname1, String planname2,
  // String planname3,
  // {this.myObject});

  @override
  _recommendMealState createState() => _recommendMealState();
}

class _recommendMealState extends State<recommendMeal> {
  int index = 1;
  String tag = '';
  final List<MealModel> _users = [];
  final String title = "hello";

  @override
  void initState() {
    super.initState();
  }

  // var planname = [];

  Widget buildUser(MealModel e) => Card(
      elevation: 5,
      child: ListTile(
        title: Text(e.plan),
        subtitle: Text(e.tag),
        trailing: IconButton(
            icon: Icon(Icons.folder),
            onPressed: () {
              //openDialog(e);
            }),
      ));

  Stream<List<MealModel>> readMeal(
          String pref1, String pref2, String pref3, String pref4) =>
      FirebaseFirestore.instance
          .collection('mealplan')
          .where('tag', isEqualTo: pref1)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => MealModel.fromJson(doc.data()))
              .toList());

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: Text(''),
    );
  }
}
