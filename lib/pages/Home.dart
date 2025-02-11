import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        margin: EdgeInsets.only(top: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("images/headphone.png"),
            SizedBox(height: 40.0,),
            Padding(padding: const EdgeInsets.only(left: 20.0),
           child: Text(
              "Explore\nThe Best\nProducts",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
            )
            ),
            SizedBox(height: 40.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin:EdgeInsets.only(right: 20.0) ,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(60),),
                  child:  Text(
                    "Next",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                ),
                ),           
              ],
            ),
              ],
        ),
      ),
    );
  }
}
