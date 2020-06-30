import 'package:flutter/material.dart';
import 'package:workout_app/screens/workout_detail_screen.dart';

class WorkoutTile extends StatelessWidget {
  const WorkoutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).pushNamed(WorkoutDetailScreen.routeName),
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(
              25.0,
              0.0,
              25.0,
              15.0,
            ),
            width: double.infinity,
            height: 108.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColorLight,
                ],
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          Text(
                            '2',
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                      color: Colors.black,
                                      height: 1,
                                    ),
                          ),
                          Text(
                            'sets',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      height: 0.8,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: <Widget>[
                          Text(
                            'Skipping rope',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            'Workout time: 30 min',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(height: 2.0),
                          ),
                        ],
                      )
                    ],
                  ),
                  Icon(Icons.chevron_right),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
