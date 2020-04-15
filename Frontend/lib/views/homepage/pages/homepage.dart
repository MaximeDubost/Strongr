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
  PageController exercisesListController,
      sessionsListController,
      programsListController;
  int exercisesListCurrentPage,
      sessionsListCurrentPage,
      programsListCurrentPage;

  @override
  initState() {
    exercisesListCurrentPage =
        sessionsListCurrentPage = programsListCurrentPage = 0;
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
    return Container(
      child: Column(
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.all(5),
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
                for (int i = 1; i <= 3; i++)
                  StrongrRoundedContainer(
                    content: Container(
                      padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: StrongrText(
                              "Exercice perso. " + i.toString(), bold: true,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.fitness_center),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "Exercice X",
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.show_chart),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "X kg",
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.refresh),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "X série(s)",
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.all(5),
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
                for (int i = 1; i <= 3; i++)
                  StrongrRoundedContainer(
                    content: Container(
                      padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: StrongrText(
                              "Séance perso. " + i.toString(), bold: true,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.accessibility),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "Full body",
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.fitness_center),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "X exercices",
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.show_chart),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "X kg",
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {},
            child: Container(
              padding: EdgeInsets.all(5),
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
          Container(
            height: ScreenSize.height(context) / 5.5,
            child: PageView(
              physics: BouncingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  programsListCurrentPage = value;
                });
              },
              controller: programsListController,
              children: <Widget>[
                for (int i = 1; i <= 3; i++)
                  StrongrRoundedContainer(
                    content: Container(
                      padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: StrongrText(
                              "Programme perso. " + i.toString(), bold: true,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.star_border),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "Objectif",
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.calendar_today),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "X séances",
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.fitness_center),
                                Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: StrongrText(
                                      "X exercices",
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
