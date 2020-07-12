import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final Function setValues;
  final String initialValue;

  InputText({
    this.setValues,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      autofocus: false,
      autocorrect: false,
      enableSuggestions: false,
      maxLength: 18,
      onChanged: (value) => setValues(key: 'title', value: value),
      style: Theme.of(context).textTheme.headline1,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // filled: true,
        fillColor: Colors.white,
        labelText: 'Name',
        //labelStyle: Theme.of(context).textTheme.headline6,
        // hintText: 'Workout name',
      ),
      validator: (value) {
        if (value.isEmpty) return 'Please provide a name';
        return null;
      },
    );
  }
}
