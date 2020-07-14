import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/exercise.dart';
import './screens/new_workout.dart';
import './screens/home_screen.dart';
import './providers/exercise_provider.dart';
import './screens/workout_timer_screen.dart';
import './screens/workout_preview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ExerciseProvider(),
      child: MaterialApp(
        title: 'Workout app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF631CD3),
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
            bodyText1: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        //home: HomeScreen(),
        routes: {
          '/': (ctx) => HomeScreen(),
          WorkoutPreviewScreen.routeName: (ctx) => WorkoutPreviewScreen(),
          WorkoutTimerScreen.routeName: (ctx) => WorkoutTimerScreen(
              selectedExercise:
                  ModalRoute.of(ctx).settings.arguments as Exercise),
          NewWorkout.routeName: (ctx) => NewWorkout(),
        },
      ),
    );
  }
}
