import 'package:flutter/material.dart';
import 'package:workout_app/widgets/custom_button.dart';

import '../widgets/custom_floating_button.dart';
import '../widgets/timer_selector.dart';
import '../widgets/card_with_title.dart';

class NewWorkout extends StatefulWidget {
  static const routeName = '/new_workout';

  @override
  _NewWorkoutState createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomFloatingButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).primaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ListView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 100,
                bottom: 50,
              ),
              children: <Widget>[
                Text(
                  'Add your workout',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Workout name',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2.5, 2.5),
                            blurRadius: 8,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          BoxShadow(
                            offset: Offset(-2.5, -3.5),
                            blurRadius: 8,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          //hintText: 'Enter a search term',
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                        ),
                      ),
                    ),
                    CardWithTitle(
                      height: 230.0,
                      cardTitle: 'Exercise time',
                      child: TimerSelector(),
                    ),
                    CardWithTitle(
                      height: 230.0,
                      cardTitle: 'Resting time',
                      child: TimerSelector(),
                    ),
                    CardWithTitle(
                      height: 230.0,
                      cardTitle: 'Number of sets',
                      child: Text('hola'),
                    ),
                  ],
                ),
              ],
            ),
            CustomButton(
              text: 'Save',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
