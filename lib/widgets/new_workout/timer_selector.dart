import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerSelector extends StatelessWidget {
  final dynamic initialValue;
  final dynamic initialValue2;
  final Function setValues;
  final String key1;
  final String key2;
  final bool isTime;

  TimerSelector({
    this.isTime = true,
    @required this.setValues,
    @required this.key1,
    this.key2 = '',
    @required this.initialValue,
    this.initialValue2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (isTime)
            Text(
              'min',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    height: 1.10,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          if (isTime)
            TimerSelectorTheme(
              picker: NumberPicker.integer(
                listViewWidth: 55.0,
                itemExtent: 40.0,
                infiniteLoop: true,
                zeroPad: true,
                highlightSelectedValue: true,
                initialValue: initialValue,
                minValue: 0,
                maxValue: 60,
                onChanged: (value) => {setValues(key: key1, value: value)},
              ),
            ),
          if (isTime)
            Text(
              ':',
              style: Theme.of(context).textTheme.headline3.copyWith(
                    height: 1.10,
                  ),
            ),
          if (isTime)
            TimerSelectorTheme(
              picker: NumberPicker.integer(
                listViewWidth: 55.0,
                itemExtent: 40.0,
                infiniteLoop: true,
                zeroPad: true,
                highlightSelectedValue: true,
                initialValue: initialValue2,
                minValue: 0,
                maxValue: 59,
                onChanged: (value) => {setValues(key: key2, value: value)},
              ),
            ),
          if (isTime)
            Text(
              'sec',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    height: 1.10,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          if (!isTime)
            TimerSelectorTheme(
              picker: NumberPicker.horizontal(
                // scrollDirection: Axis.horizontal,
                // infiniteLoop: true,
                listViewHeight: 40.0,
                itemExtent: 40.0,
                zeroPad: true,
                highlightSelectedValue: true,
                initialValue: initialValue,
                minValue: 1,
                maxValue: 20,
                onChanged: (value) => {setValues(key: key1, value: value)},
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
              headline: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).primaryColor,
                    //height: 0.01,
                  ), //other highlighted style
              body1: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.grey,
                    //height: 0.01,
                  ), //not highlighted styles
            ),
      ),
      child: picker,
    );
  }
}
