import 'package:flutter/material.dart';
import 'package:workout_app/screens/workout_timer_screen.dart';

import './screens/home_screen.dart';
import './screens/new_workout.dart';
import './screens/workout_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF510EC3),
        accentColor: Color(0xFF823FCC),
        primaryColorDark: Color(0xFFD9ABF6),
        primaryColorLight: Color(0xFFE0CEFF),
        backgroundColor: Color(0xFFF7F7F7),
        scaffoldBackgroundColor: Color(0xFFF7F7F7),
        errorColor: Color(0xFFF85454),
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Color(0xFF510EC3),
            // color: Colors.black,
          ),
          headline2: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          headline3: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w600,
            color: Color(0xFF510EC3),
          ),
          headline4: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.normal,
            color: Color(0xFF510EC3),
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
        WorkoutDetailScreen.routeName: (ctx) => WorkoutDetailScreen(),
        WorkoutTimerScreen.routeName: (ctx) => WorkoutTimerScreen(),
        NewWorkout.routeName: (ctx) => NewWorkout(),
      },
    );
  }
}
