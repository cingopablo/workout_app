import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user-detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width * 0.73,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0.0, 3.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 25,
                    ),
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'imageUrl',
                        child: CircleAvatar(
                          radius: 85.0,
                          backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/women/82.jpg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ))

        /*Center(
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
      */
        );
  }
}
