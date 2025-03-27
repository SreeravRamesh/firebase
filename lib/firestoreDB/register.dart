import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Rregister extends StatefulWidget {
  const Rregister({super.key});

  @override
  State<Rregister> createState() => _RregisterState();
}

class _RregisterState extends State<Rregister> {

  final TextEditingController name=TextEditingController();
  final TextEditingController username=TextEditingController();
  final TextEditingController password=TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore =FirebaseFirestore.instance;

  Future<void> register() async{
    try{
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: username.text.trim(),
        password: password.text.trim(),
      );
      await firestore.collection('user').doc(userCredential.user!.uid).set({
            'name':name.text.trim(),
        'email':username.text.trim(),
        'password':password.text.trim(),

        'createdAt':FieldValue.serverTimestamp(),
          });

      ScaffoldMessenger.of(context).showSnackBar(
        const  SnackBar(content: Text("Registration Succcessful")),
      );
      Navigator.pop(context);
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Register Error: ${e.toString()}"))
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),

          Text("REGISTER PAGE",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),

          SizedBox(height: 50,),

          TextFormField(
            controller: name,
            decoration: InputDecoration(
              hintText: "Name",
              labelText: "Name",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),),
          SizedBox(height: 30,),

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
            ),
          ),
          SizedBox(height: 30,),

          ElevatedButton(onPressed: register, child: Text("REGISTER")),
          SizedBox(height: 30,),


        ],
      ),
    );
  }
}
