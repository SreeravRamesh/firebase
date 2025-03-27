import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/QUIZ_APP/login.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(home: Splashscreen(),));
}

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 5),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizLogin()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [
        Colors.blue,
        Colors.blueAccent,
        Colors.lightBlueAccent
      ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
      )),
          height: double.infinity,
          width:  double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage("Assets/images/quizlogo.png"),height: 100,width: 100,),
              SizedBox(height: 10,),
              Text("QUIZ APP",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
            ],
          )
      ),
    );
  }
}
