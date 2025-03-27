import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:firebasenew/firestoreDB/home.dart';
import 'package:firebasenew/firestoreDB/register.dart';
import 'package:flutter/material.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: Llogin(),));
}

class Llogin extends StatefulWidget {
  const Llogin({super.key});

  @override
  State<Llogin> createState() => _LloginState();
}

class _LloginState extends State<Llogin> {

  TextEditingController name=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore =FirebaseFirestore.instance;

  Future<void> login() async{
    try{
      await auth.signInWithEmailAndPassword(
          email: username.text.trim(),
          password: password.text.trim(),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Hhome()));
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Error: ${e.toString()}")),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
        SizedBox(height: 20,),

      Text("LOGIN PAGE",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),

      SizedBox(height: 50,),

      TextFormField(
        controller: username,
        decoration: InputDecoration(
          hintText: "Username",
          labelText: "Username",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),),
      SizedBox(height: 30,),

      TextFormField(
        controller: password,
        decoration: InputDecoration(
          hintText: "Password",
          labelText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),),
          SizedBox(height: 30,),

          ElevatedButton(onPressed: login,
               child: const Text("LOGIN")),

          SizedBox(height: 30,),

          TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Rregister()));},
              child: Text("register here"))


        ],
      ),
    );
  }
}
