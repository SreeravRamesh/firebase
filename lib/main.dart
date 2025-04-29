import 'package:firebase_core/firebase_core.dart';
import 'package:firebasenew/Cinemax_App/SPLASH/movie_wishlist_SPLASH.dart';
import 'package:firebasenew/Cinemax_App/THEME/THEME_DATA/theme_dataa.dart';
import 'package:firebasenew/firebase_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(    theme: CustomTheme.lightTheme,
    darkTheme: CustomTheme.darkTheme,
    themeMode: ThemeMode.system,
    debugShowCheckedModeBanner: false,
    home: const WishListSplash(),

  ));
}