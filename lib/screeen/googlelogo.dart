


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,


  );
  runApp(GetMaterialApp(
    home: GoogleSignInScreen(),
  ));
}
class GoogleSignInScreen extends StatefulWidget {
  const GoogleSignInScreen({Key? key}) : super(key: key);

  @override
  State<GoogleSignInScreen> createState() => _GoogleSignInScreenState();
}

class _GoogleSignInScreenState extends State<GoogleSignInScreen> {
  ValueNotifier userCredential = ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Google SignIn Screen')),
        body: ValueListenableBuilder(
            valueListenable: userCredential,
            builder: (context, value, child) {
              return (userCredential.value == '' ||
                  userCredential.value == null)
                  ? Center(
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    iconSize: 20,
                    icon: Image.asset(
                      'Assets/images/Google-Symbol.png',
                      height: 30,width: 30, ),
                    onPressed: () async {
                      userCredential.value = await signInWithGoogle();
                      if (userCredential.value != null)
                        print(userCredential.value.user!.email);
                    },
                  ),
                ),
              )
                  : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1.5, color: Colors.black54)),
                      child: Image.network(
                          userCredential.value.user!.photoURL.toString()),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(userCredential.value.user!.displayName
                        .toString()),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(userCredential.value.user!.email.toString()),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          bool result = await signOutFromGoogle();
                          if (result) userCredential.value = '';
                        },
                        child: const Text('Logout'))
                  ],
                ),
              );
            }));
  }
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      // TODO
      print('exception->$e');
    }
  }


  Future<bool> signOutFromGoogle() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on Exception catch (_) {
      return false;
    }
  }
}
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebasenew/firebase_options.dart';
// import 'package:firebasenew/screeen/login.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(GetMaterialApp(home: Googlelogo(),));
// }
//
// class Googlelogo extends StatefulWidget {
//   const Googlelogo({super.key});
//
//   @override
//   State<Googlelogo> createState() => _GooglelogoState();
// }
//
// class _GooglelogoState extends State<Googlelogo> {
//
//   ValueNotifier userCredential = ValueNotifier('');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ValueListenableBuilder(
//           valueListenable: userCredential,
//           builder: (context, value, child){
//             return (userCredential.value == '' || userCredential.value == null)
//                 ?
//                 Center(
//                   child: Card(
//                     child: IconButton(onPressed: ()async{
//                       userCredential.value = await signInWithGoogle();
//                       if(userCredential.value != null)
//                         print(userCredential.value.user!.email);
//
//                     }, icon: Image.asset('Assets/images/Google-Symbol.png')),
//                   ),
//                 )
//                 :
//                 Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Container(
//                         clipBehavior:  Clip.antiAlias,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           border: Border.all(width: 1.5,color: Colors.black54)),
//
//                         child: Image.network(
//                           userCredential.value.user!.photoURL.toString()),
//                       ),
//
//                       SizedBox(height: 20,),
//
//                       Text(userCredential.value.user!.displayName.toString()),
//
//                       SizedBox(height: 20,),
//
//                       Text(userCredential.value.user!.email.toString()),
//
//                       SizedBox(height: 30,),
//
//                       ElevatedButton(onPressed: () async{
//                         bool result = await signOutFromGoogle();
//                         if(result) userCredential.value = '';
//                       },
//                           child: Text('Logout'))
//                     ],
//                   ),
//                 );
//           },),
//     );
//   }
//
//   Future<dynamic>signInWithGoogle() async{
//     try{
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );
//
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     }
//     on Exception catch (e)
//     {
//       print('exception->$e');
//     }
//   }
//
//  Future<dynamic> signOutFromGoogle() async{
//     try{
//       await FirebaseAuth.instance.signOut();
//       return true;
//     }
//     on Exception catch (_){
//       return false;
//     }
//  }
// }
