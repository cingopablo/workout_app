import 'package:flutter/material.dart';
import 'package:workout_app/screens/home_screen.dart';
import 'package:workout_app/screens/user_detail_screen.dart';
import 'package:workout_app/screens/workout_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF510EC3),
        accentColor: Color(0xFFA865D4),
        primaryColorDark: Color(0xFFD9ABF6),
        primaryColorLight: Color(0xFFE0CEFF),
        scaffoldBackgroundColor: Color(0xFFF7F7F7),
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          headline4: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          headline5: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          headline6: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      home: HomeScreen(),
      routes: {
        UserScreen.routeName: (ctx) => UserScreen(),
        WorkoutDetailScreen.routeName: (ctx) => WorkoutDetailScreen(),
      },
    );
  }
}
