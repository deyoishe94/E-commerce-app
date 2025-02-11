import 'package:final_pro/Admin/add_product.dart';
import 'package:final_pro/pages/signup1.dart';
import 'package:final_pro/services/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:final_pro/pages/Home.dart';
import 'package:final_pro/pages/Order.dart';
import 'package:final_pro/pages/bottomnav.dart';
import 'package:final_pro/pages/home1.dart';
import 'package:final_pro/pages/login.dart';
import 'package:final_pro/pages/product_detail.dart';
import 'package:final_pro/pages/signup1.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'delegates/my_camera_delegate.dart';
import 'Admin/admin_login.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
 Stripe.publishableKey=publishablekey;
  //setUpCameraDelegate();
  await Firebase.initializeApp(); // Ensure Firebase is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Login(), // Set initial screen
    );
  }
}

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Center(
        child: Text(
          'Signup Screen Placeholder',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
