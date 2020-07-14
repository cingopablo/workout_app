import 'package:flutter/material.dart';

class TimerSelectorTheme extends StatelessWidget {
  final Widget picker;

  TimerSelectorTheme({
    this.picker,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: Theme.of(context).primaryColor, // highlted color
        textTheme: Theme.of(context).textTheme.copyWith(
              headline: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).primaryColor,
                    //height: 0.01,
                  ), //other highlighted style
              body1: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.grey,
                    //height: 0.01,
                  ), //not highlighted styles
            ),
      ),
      child: picker,
    );
  }
}
