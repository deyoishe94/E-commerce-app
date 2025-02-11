import 'package:final_pro/pages/bottomnav.dart';
import 'package:final_pro/pages/login.dart';
import 'package:final_pro/services/database.dart';
import 'package:final_pro/services/shared_pref.dart';
import 'package:final_pro/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import '../services/database.dart';
import '../services/shared_pref.dart';
import '../widget/support_widget.dart';
import 'bottomnav.dart';
import 'login.dart';

class Signupp extends StatefulWidget {
  const Signupp({super.key});

  @override
  State<Signupp> createState() => _SignupState();
}

class _SignupState extends State<Signupp> {
  String? name, email, password;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();
  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (password != null && name != null && email != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registerd Successfully!",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        );
        String Id = randomAlphaNumeric(10);
        await SharedPreferenceHelper().saveUserEmail(mailcontroller.text);
        await SharedPreferenceHelper().saveUserId(Id);
        await SharedPreferenceHelper().saveUserName(namecontroller.text);
        await SharedPreferenceHelper().saveUserImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fletsenhance.io%2F&psig=AOvVaw3kiZwWMopEHpHxssZ1jtlt&ust=1737361144620000&source=images&cd=vfe&opi=89978449&ved=0CBcQjhxqFwoTCMi34uGsgYsDFQAAAAAdAAAAABAE");
        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Id": Id,
          "Image":"https://www.google.com/url?sa=i&url=https%3A%2F%2Fletsenhance.io%2F&psig=AOvVaw3kiZwWMopEHpHxssZ1jtlt&ust=1737361144620000&source=images&cd=vfe&opi=89978449&ved=0CBcQjhxqFwoTCMi34uGsgYsDFQAAAAAdAAAAABAE",

        };
        await DatabaseMethods().addUserDetails(userInfoMap, Id);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Bottomnav()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Password Provided is too weak",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          );
        }
        else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin:
          EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/signup1.png"),
                Center(
                    child: Text(
                      "Sign Up",
                      style: AppWidget.semiboldTextFeildStyle(),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Name",
                  style: AppWidget.semiboldTextFeildStyle(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please  Enter Your Name';
                      }
                      return null;
                    },
                    controller: namecontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Name"),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Email",
                  style: AppWidget.semiboldTextFeildStyle(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please  Enter Email';
                      }
                      return null;
                    },
                    controller: mailcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Email"),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Password",
                  style: AppWidget.semiboldTextFeildStyle(),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  padding: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFF4F5F9),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please  Enter Your Password';
                      }
                      return null;
                    },
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        name = namecontroller.text;
                        email = mailcontroller.text;
                        password = passwordcontroller.text;
                      });
                    }
                    registration();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have  an account?",
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      child: Text(
                        " Sign In",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}