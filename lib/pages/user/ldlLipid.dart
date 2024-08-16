// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';




// ignore: must_be_immutable
class ldlLipid extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  ldlLipid({this.myObject});
  @override
  _ldlLipidState createState() => _ldlLipidState();
}
class _ldlLipidState extends State<ldlLipid> {
  
  late String tc;
  late String year;
  TooltipBehavior? _tooltip;
 

 @override
  void initState() {
    super.initState();
    initial();
  }

  late SharedPreferences logindata;
 

  
  final List<ChartData> chartData = [
         
        ];




  void initial() async {
    logindata = await SharedPreferences.getInstance();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("lipidreport")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
     
        .get();

    //double bmi1 = double.parse((snap.docs[0]['bmi']).toStringAsFixed(2));

    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String actualDate = formatterDate.format(now);

  

    double cal = 0;
    double dur=0;
    int size = snap.size;
    int year;
    double tc;
    double temp = 0.0;
    String tempYear='';
    double tempCalcPercent=0.0;
    double tempCalcPer=0.0;
    double percents1 =0.0;
    String calPer='';
    for (int i = 0; i < size; i++) {
      temp = snap.docs[i]['ldl'];
      tempYear = snap.docs[i]['date'];
      tc = temp;
      year = int.parse(tempYear.substring(6));


      chartData.add(ChartData(year,tc));
      
    }
    chartData.sort((a, b) => a.x.compareTo(b.x));
      _tooltip = TooltipBehavior(enable: true);

    setState(() {
  
      
    });
  }
@override
  Widget build(BuildContext context) {
    return Container(
       padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        borderRadius:BorderRadius.all(Radius.circular(25) ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.3, 1],
          colors: [Color.fromARGB(255, 255, 0, 98),Color.fromARGB(255, 209, 255, 102),]
        ),
      ),
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           const Text(
            "Low Density Lipoprotein"+'\n(Bad Cholesterol)',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.bold
            ),
          ),
           const SizedBox(height: 10),
          Center(
                child: Container(
               
                    child:  SfCartesianChart(
                      backgroundColor: Colors.white,
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 10, interval: 0.5),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<ChartData, int>>[
              ColumnSeries<ChartData, int>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  name: 'LDL',
                  color: const Color.fromRGBO(8, 142, 255, 1),
                   dataLabelSettings: const DataLabelSettings(isVisible: true,textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)))
            ])
                )
            ),
             const SizedBox(height: 10),
         
          Container(
          
            decoration:const BoxDecoration(
                                      color: Color.fromARGB(255, 214, 214, 214),
                                      ),
                  padding: const EdgeInsets.all(15),
                    child:  Column(
                              children:  [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    '*Information*',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: <Widget>[
                   const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Low Risk',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                   LinearPercentIndicator(
                    width: 150.0,
                  
                    center: const Text('< 2.6',style: TextStyle(fontSize: 15),),
                    lineHeight: 20.0,
                    percent: 0.2,
                    progressColor: const Color.fromARGB(255, 54, 244, 86),
                  ),
                  const SizedBox(
                                  height: 10,
                                ),
                                 const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Intermediate Risk',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                 LinearPercentIndicator(
                  
                    center: const Text('> 2.6 && < 4.1',style: TextStyle(fontSize: 15),),
                   width: 150.0,
                    lineHeight: 20.0,
                    percent: 0.5,
                    progressColor: Colors.orange,
                  ),
                   const SizedBox(
                                  height: 10,
                                ),
                                 const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'High Risk',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black),
                                  ),
                                ),
                   LinearPercentIndicator(
                     center: const Text('> 4.1',style: TextStyle(fontSize: 15),),
                    width: 150.0,
                    lineHeight: 20.0,
                    percent: 0.9,
                    progressColor: const Color.fromARGB(255, 243, 33, 33),
                  )
                ],
              ),
            ),
                                ),
                                
                               
                               
                                
                              ],
                            ),
                )
        ],
      ),
      
    );
  }
}
 class ChartData {
        ChartData(this.x, this.y);
        final int x;
        final double y;
    }