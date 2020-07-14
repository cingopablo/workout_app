import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import './selector_theme.dart';

class TimerSelector extends StatefulWidget {
  final Function setValues;
  final String key1;
  final String key2;
  final int initialValue;
  int initialValue2;

  TimerSelector({
    @required this.setValues,
    @required this.key1,
    this.key2 = '',
    @required this.initialValue,
    @required this.initialValue2,
  });

  @override
  _TimerSelectorState createState() => _TimerSelectorState();
}

class _TimerSelectorState extends State<TimerSelector> {
  int _initialValue = 0;
  int _initialValue2 = 0;

  @override
  void initState() {
    super.initState();
    _initialValue = widget.initialValue;
    _initialValue2 = widget.initialValue2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'min',
            style: Theme.of(context).textTheme.headline6,
          ),
          TimerSelectorTheme(
            picker: NumberPicker.integer(
              listViewWidth: 55.0,
              itemExtent: 35.0,
              infiniteLoop: true,
              zeroPad: true,
              highlightSelectedValue: true,
              initialValue: _initialValue,
              minValue: 0,
              maxValue: 60,
              onChanged: (value) => {
                setState(() => _initialValue = value),
                widget.setValues(key: widget.key1, value: value),
              },
            ),
          ),
          Text(
            ':',
            style: Theme.of(context).textTheme.headline3.copyWith(
                  height: 1.15,
                ),
          ),
          TimerSelectorTheme(
            picker: NumberPicker.integer(
              listViewWidth: 55.0,
              itemExtent: 35.0,
              infiniteLoop: true,
              zeroPad: true,
              highlightSelectedValue: true,
              initialValue: _initialValue2,
              minValue: 0,
              maxValue: 59,
              onChanged: (value) => {
                setState(() => _initialValue2 = value),
                widget.setValues(key: widget.key2, value: value),
              },
            ),
          ),
          Text(
            'sec',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
