import 'package:chapter_13_start/databases/book_database.dart';
import 'package:chapter_13_start/di/get_it.dart';
import 'package:chapter_13_start/screens/home_screen.dart';
import 'package:chapter_13_start/service_locators/service_locator.dart';
import 'package:chapter_13_start/shared_preferences/token_preferences.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseBooks().initDB();
  ServiceLocator.registerService('preferences', TokenPreferences());
  await initAppModule();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    );
  }
}


