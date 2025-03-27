import 'package:firebasenew/screeen/firebase_authent.dart';
import 'package:firebasenew/screeen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Home extends StatelessWidget {
  final String email;
  Home({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 400,),
          Center(child: Text("WELCOME $email",
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),)),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
           FireHelper().signout().then((v){
             Get.to(Login());
           });
          }, child: Text("LOGOUT")),
        ],
      ),
    );
  }
}
