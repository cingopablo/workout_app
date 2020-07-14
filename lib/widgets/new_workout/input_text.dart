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
    return Container(
      margin: const EdgeInsets.only(
        left: 20,
        right: 25,
        bottom: 10,
      ),
      child: TextFormField(
        initialValue: initialValue,
        autofocus: false,
        autocorrect: false,
        enableSuggestions: false,
        maxLength: 15,
        onChanged: (value) => setValues(key: 'title', value: value),
        style: Theme.of(context).textTheme.headline6,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          labelStyle: Theme.of(context).textTheme.headline6,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Name of your workout',
        ),
        validator: (value) {
          if (value.isEmpty) return 'Please provide a name';
          return null;
        },
      ),
    );
  }
}
