import 'package:firebasenew/screeen/firebase_authent.dart';
import 'package:firebasenew/screeen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> formkey=GlobalKey();

  String ? name;
  String ? email;
  String ? pass;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text("REGISTER PAGE",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.red),),
            SizedBox(height: 50,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Name",
                labelText: "Name",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            validator: (name){
                if(name !.isEmpty)
                  {
                    return "Enter some value";
                  }
                else
                  {
                    return null;
                  }
            },
              onSaved: (ename){
                name = ename;
              },
            ),
            SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                hintText: "Username",
                labelText: "Username",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              validator: (email){
                if(email!.isEmpty)
                {
                  return "Enter some value";
                }
                else
                {
                  return null;
                }
              },
              onSaved: (eemail){
                email = eemail;
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
                if(pass!.isEmpty)
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
                  FireHelper().signUp(mail: email!, password: pass!).then((value){
                    if(value==null)
                      {
                        Get.to(Login());
                      }
                    else
                      {
                        Get.snackbar("Error", value);
                      }
                  });
                }

            }, child: Text("REGISTER"))
          ],
        ),
      ),
    );
  }
}
