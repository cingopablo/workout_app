import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user-detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'imageUrl',
          child: CircleAvatar(
            radius: 66.0,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/women/82.jpg',
            ),
          ),
        ),
      ),
    );
  }
}
