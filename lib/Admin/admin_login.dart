import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/Admin/home_admin.dart';
import 'package:final_pro/pages/home1.dart';
import 'package:final_pro/pages/profile.dart';
import 'package:flutter/material.dart';

import '../widget/support_widget.dart'; // Ensure this is correctly defined

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController userpasswordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              top: 30.0, left: 20.0, right: 20.0, bottom: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/signup1.png"),
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    "Admin Panel",
                    style: AppWidget.semiboldTextFeildStyle() ??
                        const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                  ),
                ),
                const SizedBox(height: 20.0),
                const Text(
                  "User Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: usernamecontroller,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "username"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 15.0),
                const Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 15.0),
                Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    controller: userpasswordcontroller,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Password"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () {
                 loginAdmin();
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
  loginAdmin(){
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot){
      snapshot.docs.forEach((result){
        if(result.data()['username']!=usernamecontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your Id is not correct",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          );
        }
        else if(result.data()['password']!=userpasswordcontroller.text.trim()){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                "Your Password is not correct",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          );
        }
        else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeAdmin()));
        }
      });
    });
}
}
