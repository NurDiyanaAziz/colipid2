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
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class viewProfile extends StatefulWidget {
  //const AdminViewReportPatient({Key? key}) : super(key: key);
  var myObject;
  viewProfile({this.myObject});
  @override
  _viewProfileState createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile> {
  int index = 1;
  late String name;
  late String weight;
  late String height;
  late String bmi;
  late String bmistat;
  late String whratiostat;
  late String ic;
   late String total = "";
  late String totalDur="";
  late String percents="";
  late double percentss=0.0;
  late String perc=""; 


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

List cardList=[
    tcLipid(),
    hdlLipid(),
    ldlLipid(),
    triglyLipid()
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
                height: MediaQuery.of(context).size.height-160,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 12),
                autoPlayAnimationDuration: const Duration(milliseconds: 3000),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                  });
                },
              ),
              items: cardList.map((card){
                return Builder(
                  builder:(BuildContext context){
                    return Container(
                       
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                       
                        child: card,
                      ),
                    );
                  }
                );
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

          void initial() async {
    logindata = await SharedPreferences.getInstance();
    name = logindata.getString('name').toString();

    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("ic", isEqualTo: logindata.getString('ic').toString())
        .get();

    double bmi1 = double.parse((snap.docs[0]['bmi']).toStringAsFixed(2));

    var now = DateTime.now();
    var formatterDate = DateFormat('dd/MM/yyyy');
    String actualDate = formatterDate.format(now);

    QuerySnapshot snaps = await FirebaseFirestore.instance
        .collection("exercisereport")
        .where("date", isEqualTo: actualDate)
        .get();

    double cal = 0;
    double dur=0;
    int size = snaps.size;
    String temp = '';
    String tempDur='0.0';
    double tempCalcPercent=0.0;
    double tempCalcPer=0.0;
    double percents1 =0.0;
    String calPer='';
    double tempdurr=0.0;
    for (int i = 0; i < size; i++) {
      cal += snaps.docs[i]['cal'];
      temp = cal.toStringAsFixed(2);
      dur += snaps.docs[i]['duration'];
      tempDur = dur.toStringAsFixed(0);
    }

tempdurr=double.parse(tempDur);
     //check if user done their min 30 min exercise
    if(tempdurr <45.0){
      tempCalcPercent = double.parse(tempDur)/60;
      percents1 = double.parse(tempCalcPercent.toStringAsFixed(1));
      
      
      tempCalcPer = tempCalcPercent*100;
      calPer=tempCalcPer.toStringAsFixed(1);
      

    }else if(tempdurr>=45.0){
      percents1 = 1.0;
      calPer = '100.0';
    }


    //suggest food set based on bmi value
    
   

    

    setState(() {
      ic = logindata.getString('ic').toString();
      
      weight = snap.docs[0]['weight'].toString();
      height = snap.docs[0]['height'].toString();
      bmi = bmi1.toString();
      bmistat = snap.docs[0]['bmistatus'].toString();
      total = temp;
      totalDur = tempDur;
      percents = percents1.toStringAsFixed(1);
      percentss = double.parse(percents);
      perc=calPer;
      whratiostat = snap.docs[0]['ratiostat'].toString();
     
      
    });
  }

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
                        final index = 0;
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
               padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 30),
             
             child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                     const Align(
                                  alignment: Alignment.topLeft,
                                      child: Text(
                      'Report',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                                  ),
                   
                    const SizedBox(height: 20),
                     const Align(
                                  alignment: Alignment.topLeft,
                                      child: Text(
                        'Lipid Report',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                                  ),
                        const SizedBox(height: 20),    
                        buildReportUsers()      
            
                    
                   
                  ],
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
