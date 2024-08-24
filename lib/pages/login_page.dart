import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colipid/pages/loading.dart';
import 'package:colipid/pages/user/usermain.dart';
import 'package:colipid/pages/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_session/flutter_session.dart';

import 'admin/adminmain.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  _LoginPageScreenState createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  bool isRememberMe = false;
  final phone = TextEditingController();
  String dialCodeDigit = "+60";
  late SharedPreferences logindata;
  late bool newuser;
  late String usernow;
  bool loading = false;

  String error = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  Stream<List<UserModel>> readUser() => FirebaseFirestore.instance
      .collection('users')
      .where('ic', isEqualTo: logindata.getString('ic').toString())
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);
    usernow = logindata.getString('type').toString();
    print(newuser);
    final index = 1;
    if (newuser == false) {
      if (usernow == 'patient') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => UserMainScreen(
                  myObject: index,
                )));
      } else if (usernow == 'admin') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminMainScreen()));
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phone.dispose();

    super.dispose();
  }

  final formKey = new GlobalKey<FormState>();
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() => loading = true);
      final phoneno = phone.text;
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .where("phone", isEqualTo: phoneno)
          .get();

      if (snap.size == 0) {
        setState(() {
          error = 'could not sign in';
          loading = false;
        });
      } else {
        final user = snap.docs[0]['usertype'].toString();
        final ic = snap.docs[0]['ic'].toString();
        final name = snap.docs[0]['fullname'].toString();
        logindata.setBool('login', false);
        logindata.setString('ic', ic);
        logindata.setString('type', user);
        logindata.setString('name', name);
        final index = 1;
        if (user == 'patient') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => UserMainScreen(
                    myObject: index,
                  )));
        } else if (user == 'admin') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AdminMainScreen()));
        }
      }

      //context.read<AuthService>().login(snap.docs[18]['phone']);
      //FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);
    }
  }

  Widget buildPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const AutoSizeText(
          'Phone Number',
          minFontSize: 18,
          maxFontSize: 25,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: new Form(
              key: formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                style: const TextStyle(color: Colors.black87, fontSize: 18),
                decoration: const InputDecoration(
                  prefix: Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(''),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14, left: 1),
                  hintText: 'Insert Phone Number',
                  hintStyle: TextStyle(color: Colors.black38),
                ),
                maxLength: 11,
                controller: phone,
                validator: (value) =>
                    value!.isEmpty ? 'Field cannot be empty' : null,
              )),
        )
      ],
    );
  }

  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: validateAndSubmit,
        child: const Text(
          'LOGIN',
          style: TextStyle(
              color: Color.fromARGB(255, 62, 151, 169),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: true,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(62, 151, 169, 0.4),
                        Color(0x993e97a9),
                        Color(0xcc3e97a9),
                        Color(0xff3e97a9),
                      ],
                    )),
                    child: SingleChildScrollView(
                      physics: const RangeMaintainingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 50),
                          SizedBox(
                              child: Flexible(
                            child: Image.asset(
                              'images/myLipid.png',
                              scale: 5,
                            ),
                          )),
                          const AutoSizeText(
                            'CoLipid',
                            minFontSize: 20,
                            maxFontSize: 25,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          buildPhoneNumber(),
                          buildLoginBtn(),
                          AutoSizeText(
                            error,
                            textAlign: TextAlign.right,
                            minFontSize: 16,
                            maxFontSize: 25,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 223, 29, 15),
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
