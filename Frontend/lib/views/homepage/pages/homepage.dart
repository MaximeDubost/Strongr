

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  List<Widget> exercisesList;
  List<Widget> sessionsList;
  List<Widget> programsList;
  PageController exercisesListController, sessionsListController, programsListController;
  int exercisesListCurrentPage, sessionsListCurrentPage, programsListCurrentPage;

  @override
  initState() {
    exercisesListCurrentPage = sessionsListCurrentPage = programsListCurrentPage = 0;
    exercisesListController = PageController(
      initialPage: exercisesListCurrentPage,
      keepPage: false,
      viewportFraction: 0.85,
    );
    sessionsListController = PageController(
      initialPage: sessionsListCurrentPage,
      keepPage: false,
      viewportFraction: 0.85,
    );
    programsListController = PageController(
      initialPage: programsListCurrentPage,
      keepPage: false,
      viewportFraction: 0.85,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pageView = PageView(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        programsListCurrentPage = value;
                      });
                    },
                    controller: programsListController,
                    children: <Widget>[
                      StrongrRoundedContainer(),
                      StrongrRoundedContainer(),
                      StrongrRoundedContainer(),
                    ],
                    // itemBuilder: (context, index) => builder(index)
                  );
        return Container(
            child: Column(
              children: <Widget>[
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.all(5),
                    // height: 50,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StrongrText("Exercices", size: 25),
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_right),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(5),
                //   // color: Colors.green,
                //   height: ScreenSize.height(context) / 5.5,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: <Widget>[
                //       StrongrRoundedContainer(),
                //       StrongrRoundedContainer(),
                //       StrongrRoundedContainer(),
                //     ],
                //   ),
                // ),
                Container(
                  height: ScreenSize.height(context) / 5.5,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        exercisesListCurrentPage = value;
                      });
                    },
                    controller: exercisesListController,
                    children: <Widget>[
                      StrongrRoundedContainer(),
                      StrongrRoundedContainer(),
                      StrongrRoundedContainer(),
                    ],
                    // itemBuilder: (context, index) => builder(index)
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.all(5),
                    // height: 50,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StrongrText("Séances", size: 25),
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_right),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(5),
                //   // color: Colors.green,
                //   height: ScreenSize.height(context) / 5.5,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: <Widget>[
                //       StrongrRoundedContainer(),
                //       StrongrRoundedContainer(),
                //       StrongrRoundedContainer(),
                //     ],
                //   ),
                // ),
                Container(
                  height: ScreenSize.height(context) / 5.5,
                  child: PageView(
                    physics: BouncingScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        sessionsListCurrentPage = value;
                      });
                    },
                    controller: sessionsListController,
                    children: <Widget>[
                      StrongrRoundedContainer(),
                      StrongrRoundedContainer(),
                      StrongrRoundedContainer(),
                    ],
                    // itemBuilder: (context, index) => builder(index)
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Container(
                    padding: EdgeInsets.all(5),
                    // height: 50,
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StrongrText("Programmes", size: 25),
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_right),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.all(5),
                //   // color: Colors.green,
                //   height: ScreenSize.height(context) / 5.5,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     children: <Widget>[
                //       StrongrRoundedContainer(),
                //       StrongrRoundedContainer(),
                //       StrongrRoundedContainer(),
                //     ],
                //   ),
                // ),
                Container(
                  height: ScreenSize.height(context) / 5.5,
                  child: pageView,
            ),
          ],
        ),
      );
  }
}