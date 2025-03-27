import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/QUIZ_APP/home.dart';
import 'package:firebasenew/QUIZ_APP/register.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:flutter/material.dart';

void main()
async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: QuizLogin(),));
}

class QuizLogin extends StatefulWidget {
  const QuizLogin({super.key});

  @override
  State<QuizLogin> createState() => _QuizLoginState();
}

class _QuizLoginState extends State<QuizLogin> {

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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuizHome(email: '',)));
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
      body: Container(color: Colors.blue[100],
        child: Column(
          children: [
            SizedBox(height: 20,),

            Text("QUIZ APP",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue),),

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

            ElevatedButton(onPressed:
              login,
                child: const Text("LOGIN")),

            SizedBox(height: 30,),

            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>QuizRegister()));},
                child: Text("Not a user ? Register here"))


          ],
        ),
      ),
    );
  }
}
