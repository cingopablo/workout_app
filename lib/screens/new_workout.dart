import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_circular_button.dart';
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
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            CustomCircularButton(
              function: () => Navigator.of(context).pop(),
              backgroundColor: Theme.of(context).backgroundColor,
              icon: Icons.close,
              iconColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CustomCircularButton(
                    function: () => Navigator.of(context).pop(),
                    backgroundColor: Theme.of(context).backgroundColor,
                    icon: Icons.close,
                    iconColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            ListView(
              padding: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: 80,
                top: 15,
              ),
              children: <Widget>[
                Text(
                  'New workout',
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
                      child: TimerSelector(
                        isTime: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomButton(
              text: 'Save',
              withIcon: true,
              icon: Icon(
                Icons.save,
                color: Colors.white,
              ),
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
