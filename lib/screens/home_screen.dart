import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../screens/new_workout.dart';
import '../providers/exercise_provider.dart';
import '../widgets/custom_flexible_bar.dart';
import '../widgets/home_screen/workout_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final now = DateTime.now();

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // googlePlayIdentifier: ''
  );

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) => {
          //if (_rateMyApp.shouldOpenDialog)
          //{
          _rateMyApp.showStarRateDialog(
            context,
            title: 'Are you enjoying this app?',
            message:
                'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
            actionsBuilder: (context, stars) {
              return [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () async {
                    await _rateMyApp
                        .callEvent(RateMyAppEventType.rateButtonPressed);
                    Navigator.pop<RateMyAppDialogButton>(
                        context, RateMyAppDialogButton.rate);

                    if (stars <= 3) {
                      print('Navigate to contact screen');
                    } else {
                      print('navigate to app store and leave a review');
                    }
                    print('Thanks for the ' +
                        (stars == null ? '0' : stars.round().toString()) +
                        ' star(s) !');

                    DoNotOpenAgainCondition();
                  },
                ),
              ];
            },
            ignoreIOS: false,
            dialogStyle: DialogStyle(
              titleAlign: TextAlign.center,
              messageAlign: TextAlign.center,
              messagePadding: EdgeInsets.only(bottom: 20),
            ),
            starRatingOptions: StarRatingOptions(),
            onDismissed: () =>
                _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
          )
          //  }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        onPressed: () => Navigator.of(context).pushNamed(NewWorkout.routeName),
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(
          Icons.add,
          size: 30,
        ),
        label: Text(
          "Add workout",
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<ExerciseProvider>(context, listen: false)
              .fetchAndSetExercises(),
          builder: (context, snapshot) {
            Widget newsListSliver;
            if (snapshot.connectionState != ConnectionState.waiting) {
              newsListSliver = Consumer<ExerciseProvider>(
                child: Center(
                  child: const Text('Got no exercises yet. Start adding some!'),
                ),
                builder: (ctx, exercises, ch) => exercises.items.length <= 0
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) => Container(
                            margin: const EdgeInsets.only(left: 10, top: 30),
                            child: Lottie.asset('assets/images/warmup.json'),
                          ),
                          childCount: 1,
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) =>
                              WorkoutTile(exercise: exercises.items[index]),
                          childCount: exercises.items.length,
                        ),
                      ),
              );
            } else {
              newsListSliver = SliverList(
                delegate: SliverChildBuilderDelegate(
                  (ctx, index) => Text(''),
                  childCount: 1,
                ),
              );
            }

            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  expandedHeight: 160,
                  iconTheme: const IconThemeData(color: Colors.black),
                  backgroundColor: Theme.of(context).backgroundColor,
                  pinned: true,
                  floating: true,
                  primary: true,
                  centerTitle: true,
                  title: Text(
                    'My workouts',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: CustomFlexibleBar(
                      now: now,
                      withDate: true,
                      title: 'Ready to train?',
                    ),
                  ),
                ),
                newsListSliver,
              ],
            );
          },
        ),
      ),
    );
  }
}
