import 'package:Fixed_wages/master.dart';
import 'package:Fixed_wages/pages/fire.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Fixed_wages/pages/map_page.dart';
import'package:Fixed_wages/pages/start.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Fixed_wages/pages/fire.dart';
import 'package:Fixed_wages/pages/livefire.dart';
import 'package:Fixed_wages/pages/labourjobs.dart';
import 'package:Fixed_wages/pages/geologicallocation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions
      (apiKey: 'AIzaSyDYv9mq1y9ODzXKXv2Casptgs-H1UKZ3as',
        appId: '1:424165333674:android:ad49fa8f67ac7d67ecced3',
        messagingSenderId: '424165333674',
        projectId: 'aissms-4898d')

  );

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NewApp(),
      //Master(),
    );
  }
}
