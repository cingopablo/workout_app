import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:workout_app/providers/exercise_provider.dart';
import 'package:workout_app/screens/workout_preview_screen.dart';

import '../widgets/custom_flexible_bar.dart';
import '../widgets/new_workout/input_text.dart';
import '../widgets/new_workout/timer_selector.dart';
import '../widgets/new_workout/card_with_title.dart';

class NewWorkout extends StatefulWidget {
  static const routeName = '/new_workout';

  @override
  _NewWorkoutState createState() => _NewWorkoutState();
}

class _NewWorkoutState extends State<NewWorkout> {
  ScrollController _scrollController;
  bool _isExtended = true;
  var now = DateTime.now();

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
        case ScrollDirection.forward:
          _switchActionBar(true);
          break;
        case ScrollDirection.reverse:
          _switchActionBar(false);
          break;
        case ScrollDirection.idle:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final id = uuid.v4();
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
            //Navigator.of(context).pushNamed(NewWorkout.routeName);
            Navigator.of(context).pop();
            Provider.of<ExerciseProvider>(
              context,
              listen: false,
            ).addExercise(
              title: 'New timer',
              id: id,
              sets: 1,
              repetitions: 1,
              exerciseTime: const Duration(seconds: 10),
              restTime: const Duration(seconds: 5),
              breakTime: const Duration(seconds: 60),
            );
            Navigator.of(context).pushNamed(
              WorkoutPreviewScreen.routeName,
              arguments: id,
            );
          },
          elevation: 2,
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          label: _isExtended
              ? Row(
                  children: <Widget>[
                    const Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: const Icon(Icons.save),
                    ),
                    const Text("Save"),
                  ],
                )
              : const Icon(Icons.save),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
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
              title: Text('New workout',
                  style: Theme.of(context).textTheme.headline6),
              flexibleSpace: FlexibleSpaceBar(
                background: CustomFlexibleBar(
                  now: now,
                  title: 'Add your thing',
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                InputText(),
                CardWithTitle(
                  height: 80,
                  cardTitle: 'Number of sets',
                  child: TimerSelector(
                    isTime: false,
                  ),
                ),
                CardWithTitle(
                  height: 80,
                  cardTitle: 'Number of repetitions',
                  child: TimerSelector(
                    isTime: false,
                  ),
                ),
                CardWithTitle(
                  cardTitle: 'Exercise time',
                  child: TimerSelector(),
                ),
                CardWithTitle(
                  cardTitle: 'Resting time',
                  child: TimerSelector(),
                ),
                CardWithTitle(
                  cardTitle: 'Break between sets',
                  child: TimerSelector(),
                ),
                const SizedBox(
                  height: 45,
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
