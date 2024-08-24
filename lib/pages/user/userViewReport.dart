import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/body_model.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:colipid/pages/user/hdlLipid.dart';
import 'package:colipid/pages/user/ldlLipid.dart';
import 'package:colipid/pages/user/tcLipid.dart';
import 'package:colipid/pages/user/triglyLipid.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types, must_be_immutable
class userViewReport extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  userViewReport({this.myObject});
  @override
  _userViewReportState createState() => _userViewReportState();
}

class _userViewReportState extends State<userViewReport> {
  int index = 1;

  /* late List<charts.Series<LipidModel, String>> _seriesBarData;
  late List<LipidModel> myData;
  _generateData(myData) {
    _seriesBarData.add(charts.Series(
        domainFn: (LipidModel lipid, _) => lipid.date.toString(),
        measureFn: (LipidModel lipid, _) => lipid.tc,
        id: 'LipidModel',
        data: myData,
        labelAccessorFn: (LipidModel row, _) => "${row.date}"));
  }*/

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  late SharedPreferences logindata;

  late String icc = "";
  Future<void> fetchUser() async {
    // do something
    logindata = await SharedPreferences.getInstance();
    String ic = logindata.getString('ic').toString();
    setState(() {
      icc = ic;
    });
  }

  List cardList = [tcLipid(), hdlLipid(), ldlLipid(), triglyLipid()];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget buildReportUsers() => CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 12),
          autoPlayAnimationDuration: const Duration(milliseconds: 3000),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          onPageChanged: (index, reason) {
            setState(() {});
          },
        ),
        items: cardList.map((card) {
          return Builder(builder: (BuildContext context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width,
              child: Card(
                child: card,
              ),
            );
          });
        }).toList(),
      );

  Widget buildBodyReportUsers(BodyModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: const Color.fromARGB(255, 228, 228, 228),
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

  Stream<List<LipidModel>> readLipidReport() => FirebaseFirestore.instance
      .collection('lipidreport')
      .where('ic', isEqualTo: icc)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => LipidModel.fromJson(doc.data())).toList());

  Stream<List<BodyModel>> readBodyReport() => FirebaseFirestore.instance
      .collection('bodyreport')
      .where('ic', isEqualTo: icc)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => BodyModel.fromJson(doc.data())).toList());

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
                        const index = 0;
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 184, 184, 184),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        title: const Text('Report'),
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
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[buildReportUsers()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
