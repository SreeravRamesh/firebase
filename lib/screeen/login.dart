import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:firebasenew/screeen/firebase_authent.dart';
import 'package:firebasenew/screeen/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'home.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(home: Login(),));
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  GlobalKey<FormState> formkey=GlobalKey();

  String? email;
  String? pass;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          children: [

            SizedBox(height: 20,),

            Text("LOGIN PAGE",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),

            SizedBox(height: 50,),

            TextFormField(
              decoration: InputDecoration(
              hintText: "Username",
              labelText: "Username",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
              validator: (email){
                if(email !.isEmpty)
                {
                  return "Enter valid email ";
                }
                else
                {
                  return null;
                }
              },
              onSaved: (ename){
                email = ename;
              },
            ),

            SizedBox(height: 30,),

            TextFormField(
              decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
              validator: (pass){
                if(pass !.isEmpty)
                {
                  return "Enter some value";
                }
                else
                {
                  return null;
                }
              },
              onSaved: (epass){
                pass = epass;
              },
            ),

            SizedBox(height: 30,),

            ElevatedButton(onPressed: (){
              if(formkey.currentState!.validate())
              {
                formkey.currentState!.save();
                FireHelper().signIn(mail: email!, password: pass!).then((value){
                  if(value==null)
                  {
                    Get.offAll(()=>Home(email: email!));
                  }
                  else
                  {
                    Get.snackbar("Error", value);
                  }
                });

              }

            }, child: Text("LOGIN")),

            SizedBox(height: 30,),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
            }, child: Text("Not a user ? Register now"))

          ],
        ),
      ),
    );
  }
}
