import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/fireNotificatn/notification.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:flutter/material.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MaterialApp(home: Home(),));
  await NotificationService().registerPushNotificationHandler();
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("data"),),
    );
  }
}
