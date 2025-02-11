import 'package:final_pro/pages/bottomnav.dart';
import 'package:final_pro/pages/home1.dart';
import 'package:final_pro/pages/signup1.dart';
import 'package:final_pro/pages/signup1.dart';
import 'package:final_pro/widget/support_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/support_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email="",password="";

  TextEditingController mailcontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();
  final _formkey= GlobalKey<FormState>();
  userLogin()async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Bottomnav(),),);

    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("No User Found ",style: TextStyle(fontSize: 20.0,),),),);
      }
      else if(e.code=="wrong-password"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Wrong Password",style: TextStyle(fontSize: 20.0,),),),);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin:
          EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/login1.png"),
                Center(
                    child: Text(
                      "Sign In",
                      style: AppWidget.semiboldTextFeildStyle(),
                    )),

                SizedBox(
                  height: 20.0,
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
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Enter Your Email';
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
                    controller: passwordcontroller,
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return '  Enter Your Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                GestureDetector(
                  onTap: (){
                    if(_formkey.currentState!.validate()){
                      setState(() {
                        email=mailcontroller.text;
                        password=passwordcontroller.text;
                      });
                    }
                    userLogin();
                  },

                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text("Login",
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
                      "Don't have  an account?",
                      style: AppWidget.LightTextFeildStyle(),
                    ),
                    GestureDetector(
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signupp(),),);
                      },
                      child: Text(

                        " Sign Up",
                        style: TextStyle(
                            color: Colors.cyan,
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