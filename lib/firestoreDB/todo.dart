import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(GetMaterialApp(home: Todoui(),));
}
class Todoui extends StatefulWidget {
  const Todoui({super.key});

  @override
  State<Todoui> createState() => _TodouiState();
}

class _TodouiState extends State<Todoui> {

  late CollectionReference usercollection;

  final cname=TextEditingController();
  final cemail=TextEditingController();


  bool isloading=true;

  @override
  void initState(){
    usercollection = FirebaseFirestore.instance.collection("note");
    super.initState();
  }

  void loaddata()async{

    setState(() {
      isloading=false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: readUser(),
          builder: (context,snapshot){
            if(snapshot.hasError)
              {
                return Center(child: Text("Error${snapshot.error}"),);
              }
            if(snapshot.connectionState == ConnectionState.waiting)
              {
                return const Center(child: CircularProgressIndicator());
              }
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
                itemBuilder: (context,index){
                final user = users[index];
                final userid = user.id;
                  final userName = user["name"];
                  final userEmail = user["email"];

                  return ListTile(
                    title: Text('$userName',
                      style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20 ),),
                    subtitle: Text('$userEmail',
                      style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20 ),),
                    trailing: Wrap(
                      children: [
                        IconButton(onPressed: (){
                          uname.text=userName;
                          uemail.text=userEmail;
                          editUserData(userid);
                        }, icon: Icon(Icons.edit)),
                        IconButton(onPressed: (){
                          deleteUser(userid);
                        }, icon: Icon(Icons.delete))
                      ],
                    ),
                  );
                });
          }),

      floatingActionButton: FloatingActionButton(onPressed: ()=>adduser(),child: Icon(Icons.add)),
    );
  }
void adduser(){
  showDialog(context: context, builder: (context){
    return AlertDialog(
      title: Text("add user."),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10,),
          TextField(
            controller: cname,
            decoration: const InputDecoration(
                border: OutlineInputBorder(),hintText: "Name"
            ),

          ),
          const SizedBox(height: 10,),
          TextField(
            controller: cemail,
            decoration:  const InputDecoration(
                border: OutlineInputBorder(),hintText: "Email"
            ),
          ),
        ],
      ) ,
      actions: [
        ElevatedButton(onPressed: ()=>addUSertoDB(cname.text,cemail.text),
            child: const Text("Create User"))
      ],
    );
  }
  );
}
  Future<void> addUSertoDB(String name, String email) async{
    return usercollection.add({'name':name,'email':email}).then((value){
      print("User Added Successfully");
      cname.clear();
      cemail.clear();
      Navigator.of(context).pop();
    }).catchError((error){
      print("Failed to add data $error");
    });
  }

  Stream<QuerySnapshot> readUser(){
    return usercollection.snapshots();
  }

  final uname=TextEditingController();
  final uemail=TextEditingController();

  void editUserData(String id)async {
    showModalBottomSheet(isScrollControlled: true,
        context: context, builder: (context)=>Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+100,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 20,),
              TextField(
                controller:uname,
                decoration: InputDecoration(border: OutlineInputBorder(),hintText: "name"),
              ),
              SizedBox(height: 10,),

              TextField(
                controller: uemail,
                decoration: InputDecoration(border: OutlineInputBorder(),hintText: "email"),
              ),
              SizedBox(height: 30,),

              ElevatedButton(onPressed: ()=>updateUser(id, uname.text, uemail.text),
                  child: Text( "Update"))
            ],
          ),
        )
    );
  }

  Future<void> updateUser(String userid, String uname, String uemail)async{
    var upadatedvalues ={"name":uname, "email": uemail};
    return usercollection.doc(userid).update(upadatedvalues).then((value){
      Navigator.of(context).pop();
      print("User data updated successfully");
    }).catchError((error){
      print("user deletion failed $error");
    });
  }

  Future<void> deleteUser(var id) async{
    return usercollection.doc(id).delete().then((value){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User deleted successfully")));
    }).catchError((error){
      print("user deletion faled $error");
    });
  }

}