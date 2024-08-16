import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/tac_model.dart';
import 'package:colipid/pages/user/update_TAC.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../admin/dialogs.dart';

//user update phone number
//system send tac number and number will update the new one


class sendTAC extends StatefulWidget {
  sendTAC({required this.passphone});
  final String passphone;

 

  @override
  _sendTACState createState() => _sendTACState();
}

class _sendTACState extends State<sendTAC> {
  int index = 1;



  final oldphone = TextEditingController();
  final phone = TextEditingController(); 
  final phoneConfirm = TextEditingController();
  late String priphone;

   late SharedPreferences logindata;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   
  
    initial();
  }

   void initial() async {
    
    

    setState(() {
      priphone =widget.passphone;
      
       oldphone.text = priphone;
      
     
    });
  }


 Widget buildOldPhoneNumb() {
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
            height: 60,
            child: TextField(
               enabled: false,
              controller: oldphone,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Color.fromARGB(221, 150, 150, 150), fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.phone_android, color: Color(0x663e97a9)),
                  
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }



  Widget buildPhoneNumb() {
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
            height: 60,
            child: TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.phone_android, color: Color(0x663e97a9)),
                  hintText: 'New phone number',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

 Widget buildPhoneNumbConfirm() {
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
            height: 60,
            child: TextField(
              controller: phoneConfirm,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.black87, fontSize: 20),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon:
                      Icon(Icons.phone_android, color: Color(0x663e97a9)),
                  hintText: 'Confirm phone number',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          ),
        )
      ],
    );
  }

 Widget buildSubmitBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: 100,
      child: ElevatedButton(
  
        onPressed: () async {
         

          final action = await Dialogs.yesAbortDialog(
              context, 'Confirm Submit?', 'Are you sure?');
          if (action == DialogAction.yes) {
           

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => updateTAC(myObject: 0)));
          }
        },
      
        child: const Text(
          'Submit',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
 
  return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Cancel process?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child:  Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
             
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                     const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                      const Align(
                                  alignment: Alignment.topLeft,
                                      child: Text(
                      'Update phone number',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                                  ),
                   
                    const SizedBox(height: 50),
                    buildOldPhoneNumb(),
                     buildPhoneNumb(),
                     buildPhoneNumbConfirm()  ,
                     buildSubmitBtn()

                         
            
                    
                   
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

Future inputPhone(TACmodel lipid) async {
  //reference document
  final bodyP = FirebaseFirestore.instance.collection('bodyreport').doc();

  lipid.phone = bodyP.id;
  final json = lipid.toJson();
  await bodyP.set(json);
}
