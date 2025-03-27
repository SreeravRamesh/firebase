import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Hhome extends StatelessWidget {
  const Hhome({super.key});



  @override
  Widget build(BuildContext context) {
    final User? user= FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
          }, icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('user').doc(user?.uid).get(),
            builder: (context,snapshot){
              if(!snapshot.hasData || !snapshot.data!.exists)
                {
                  return const Text("No user data found");
                }
              var userData = snapshot.data!.data() as Map<String,dynamic>;
              return Text("Welcome,${userData['name']??'user'}");
            },
      ),
    )
    );
  }
}
