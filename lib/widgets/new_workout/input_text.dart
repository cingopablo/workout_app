import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final Function setValues;

  InputText({this.setValues});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 25,
        right: 25,
        bottom: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Workout name',
            style: Theme.of(context).textTheme.headline6,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            margin: const EdgeInsets.only(top: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(2.5, 2.5),
                  blurRadius: 8,
                  color: Colors.grey.withOpacity(0.2),
                ),
                BoxShadow(
                  offset: const Offset(-2.5, -3.5),
                  blurRadius: 8,
                  color: Colors.grey.withOpacity(0.2),
                ),
              ],
            ),
            child: TextField(
              autocorrect: false,
              enableSuggestions: false,
              maxLength: 15,
              onChanged: (value) => setValues(key: 'title', value: value),
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
