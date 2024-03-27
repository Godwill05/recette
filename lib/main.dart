import 'package:flutter/material.dart';
import 'package:recette/screens/home_page.dart';
import 'package:recette/screens/startpage/start_page_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding", )??false;
  runApp( MyApp(onboarding: onboarding,));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  MyApp({super.key,this.onboarding=false});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:onboarding? HomePage() : StartPageView(),
    );
  }
}


