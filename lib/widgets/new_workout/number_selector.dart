import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

import './selector_theme.dart';

class NumberSelector extends StatefulWidget {
  final Function setValues;
  final String valueKey;

  NumberSelector({
    this.setValues,
    this.valueKey,
  });

  @override
  _NumberSelectorState createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  int _initialValue = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TimerSelectorTheme(
            picker: NumberPicker.integer(
              listViewWidth: 55.0,
              itemExtent: 35.0,
              infiniteLoop: true,
              zeroPad: true,
              highlightSelectedValue: true,
              initialValue: _initialValue,
              minValue: 1,
              maxValue: 20,
              onChanged: (value) => {
                setState(() => _initialValue = value),
                widget.setValues(
                  key: widget.valueKey,
                  value: value,
                )
              },
            ),
          ),
          Text(
            widget.valueKey,
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
