import 'package:flutter/material.dart';
import 'package:gsheets_project/google_heets_api.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoogleSheetsApi().init();
  //
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(primarySwatch: Colors.teal),
    );
  }
}

//


// https://www.youtube.com/watch?v=SoBpxS46HEA&t=93s
