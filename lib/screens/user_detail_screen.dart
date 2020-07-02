import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user-detail';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: 'imageUrl',
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/82.jpg',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'First Last',
              style: Theme.of(context).textTheme.headline2,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey[200],
                    Colors.grey[50],
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2.5, 2.5),
                    blurRadius: 8,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  BoxShadow(
                    offset: Offset(-2.5, -3.5),
                    blurRadius: 8,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                ],
              ),
              height: 350,
              margin: EdgeInsets.only(
                left: 25,
                right: 25,
                top: 20,
              ),
              padding: EdgeInsets.all(
                25,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            )
          ],
        ),
      ),

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
