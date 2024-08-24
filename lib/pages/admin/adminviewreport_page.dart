import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/admin/adminHdlLipid.dart';
import 'package:colipid/pages/admin/adminLdlLipid.dart';
import 'package:colipid/pages/admin/adminTcLipid.dart';
import 'package:colipid/pages/admin/adminTriglyLipid.dart';
import 'package:colipid/pages/lipid_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../body_model.dart';
import 'adminpatientmenu_page.dart';

// ignore: must_be_immutable
class AdminViewReportPatient extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  AdminViewReportPatient({this.myObject});
  @override
  _AdminViewReportPatientState createState() => _AdminViewReportPatientState();
}

class _AdminViewReportPatientState extends State<AdminViewReportPatient> {
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

  late String icc = "";

  Future<void> fetchUser() async {
    // do something
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String ic = widget.myObject.toString();
    setState(() async {
      icc = ic;
      await prefs.setString('patData', ic);
    });
  }

  Widget buildBackBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 70,
      width: 100,
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AdminUpdatePatient(myObject: icc)));
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

  Widget buildReportUserss(LipidModel e) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        shadowColor: Colors.black,
        color: const Color.fromARGB(255, 255, 255, 255),
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
                        Container(
                          child: Text(
                            'TC: ${e.tc}',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ), //Textstyle
                          ),
                        ),
                        Text(
                          'HDL: ${e.hdl}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'LDL: ${e.tc}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'Trigly: ${e.trigly}',
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
                        Text(
                          e.tcstatus.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.hdlstatus.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.ldlstatus.toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          e.triglystatus.toString(),
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
                SizedBox(
                  child: Text(
                    'Doctor comment: ${e.comment}',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 29, 9, 83),
                    ), //Textstyle
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 30,
                  child: Text(
                    'Doctor Name: ${e.drname}',
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ), //Textstyle
                  ),
                ), //SizedBox
              ],
            ), //Column
          ), //Padding
        ), //SizedBox
      );

  List cardList = [
    AdminTcLipid(),
    AdminHdlLipid(),
    AdminLdlLipid(),
    AdminTriglyLipid()
  ];
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  Widget buildReportUsers() => CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height - 160,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 12),
          autoPlayAnimationDuration: const Duration(milliseconds: 3000),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 2.0,
          onPageChanged: (index, reason) {
            setState(() {});
          },
        ),
        items: cardList.map((card) {
          return Builder(builder: (BuildContext context) {
            return Container(
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
                          'Weight : ${e.weight}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'Height : ${e.height}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'BMI : ${double.parse(e.bmi.toStringAsFixed(2))}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'Waist : ${e.waist}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'Hip : ${e.hip}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ), //Textstyle
                        ),
                        Text(
                          'W/H Ratio: ${double.parse(e.ratio.toStringAsFixed(2))}',
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

/*  Widget buildLineChart() {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 70,
        width: 100,
        child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            series: <ChartSeries>[
              // Renders line chart
              LineSeries<SalesData, int>(
                  dataSource: chartData,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ]));
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 196, 161, 149),
        elevation: 0.0,
        titleSpacing: 10.0,
        centerTitle: true,
        title: const Text('Patient Lipid Report'),
        leading: InkWell(
          onTap: () async {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AdminUpdatePatient(myObject: icc)));
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),
                  buildReportUsers()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
