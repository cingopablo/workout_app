import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  ScrollController _scrollController;
  bool _isExtended = true;

  void _switchActionBar(value) {
    setState(() {
      _isExtended = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      switch (_scrollController.position.userScrollDirection) {
        // Scrolling up - forward the animation (value goes to 1)
        case ScrollDirection.forward:
          _switchActionBar(true);
          break;
        // Scrolling down - reverse the animation (value goes to 0)
        case ScrollDirection.reverse:
          _switchActionBar(false);
          break;
        // Idle - keep FAB visibility unchanged
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: AnimatedSwitcher(
        duration: Duration(
          milliseconds: 100,
        ),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            child: child,
            scale: animation.drive(CurveTween(curve: Curves.easeOutQuint)),
          );
        },
        child: FloatingActionButton.extended(
          isExtended: _isExtended,
          onPressed: () {
            Navigator.of(context).pushNamed(NewWorkout.routeName);
          },
          elevation: 2,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          label: _isExtended
              ? Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(Icons.save),
                    ),
                    Text("Save"),
                  ],
                )
              : Icon(Icons.save),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
            ListView(
              controller: _scrollController,
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
                        borderRadius: BorderRadius.circular(20),
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
            // CustomButton(
            //   text: 'Save',
            //   withIcon: true,
            //   icon: Icon(
            //     Icons.save,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
