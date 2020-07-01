import 'package:flutter/material.dart';

class NewWorkout extends StatelessWidget {
  static const routeName = '/new_workout';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).backgroundColor,
      //   iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      // ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              elevation: 0,
              expandedHeight: 150,
              backgroundColor: Theme.of(context).backgroundColor,
              pinned: true,
              primary: true,
              iconTheme: IconThemeData(
                color: Theme.of(context).primaryColor,
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Add your new workout',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Workout name',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(2.5, 2.5),
                                blurRadius: 8,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                              BoxShadow(
                                offset: Offset(-2.5, -3.5),
                                blurRadius: 8,
                                color: Colors.grey.withOpacity(0.2),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a search term',
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Exercise time',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          height: 120,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Resting time',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          height: 120,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Number of sets',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 10,
                            bottom: 30,
                          ),
                          height: 120,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
