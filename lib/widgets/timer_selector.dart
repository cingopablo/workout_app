import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerSelector extends StatelessWidget {
  const TimerSelector({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      height: 120,
      //color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'min',
            style: Theme.of(context).textTheme.headline4.copyWith(
                  height: 2.5,
                  fontWeight: FontWeight.w600,
                ),
          ),
          TimerSelectorTheme(
            picker: NumberPicker.integer(
              infiniteLoop: true,
              zeroPad: true,
              highlightSelectedValue: true,
              initialValue: 0,
              minValue: 0,
              maxValue: 60,
              onChanged: (value) => {},
            ),
          ),
          Text(
            ':',
            style: Theme.of(context).textTheme.headline3.copyWith(
                  height: 1.70,
                ),
          ),
          TimerSelectorTheme(
            picker: NumberPicker.integer(
              infiniteLoop: true,
              zeroPad: true,
              highlightSelectedValue: true,
              initialValue: 0,
              minValue: 0,
              maxValue: 59,
              onChanged: (value) => {},
            ),
          ),
          Text(
            'sec',
            style: Theme.of(context).textTheme.headline4.copyWith(
                  height: 2.5,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

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
              headline: Theme.of(context).textTheme.headline1.copyWith(
                    color: Theme.of(context).primaryColor,
                    height: 0.01,
                  ), //other highlighted style
              body1: Theme.of(context).textTheme.headline1.copyWith(
                    color: Colors.grey,
                    height: 0.01,
                  ), //not highlighted styles
            ),
      ),
      child: picker,
    );
  }
}
