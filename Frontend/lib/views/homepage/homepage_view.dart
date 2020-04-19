import 'package:flutter/material.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/homepage/pages/app_exercises_page.dart';
import 'package:strongr/views/homepage/pages/homepage.dart';
import 'package:strongr/views/homepage/pages/statistics_page.dart';

class HomepageView extends StatefulWidget {
  @override
  _HomepageViewState createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  List<Widget> pagesList;
  List<String> popupMenuItems;
  int currentPage;

  @override
  void initState() {
    currentPage = 1;
    pagesList = [
      ExercisesPage(),
      Homepage(),
      StatisticsPage(),
    ];
    popupMenuItems = currentPage != 0
        ? [
            "Profil",
            "Paramètres",
          ]
        : [
            "Profil",
            "Paramètres",
            "Trier par",
          ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            tooltip: "Notifications",
            icon: Icon(Icons.notifications_none),
            color: Colors.white,
            onPressed: () {},
          ),
          title: Text(currentPage == 1
              ? "Strongr"
              : currentPage == 0 ? "Exercices" : "Statistiques"),
          actions: <Widget>[
            // IconButton(
            //     icon: Icon(Icons.more_vert),
            //     color: Colors.white,
            //     onPressed: () {},
            // ),
            PopupMenuButton<String>(
              tooltip: "Menu",
              onSelected: (value) => {},
              itemBuilder: (BuildContext context) {
                return popupMenuItems.map(
                  (String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  },
                ).toList();
              },
            ),
          ],
        ),
        body: pagesList[currentPage],
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          backgroundColor: StrongrColors.black,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
              popupMenuItems = currentPage != 0
                  ? [
                      "Profil",
                      "Paramètres",
                    ]
                  : [
                      "Profil",
                      "Paramètres",
                      "Trier par",
                    ];
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center, color: Colors.white54, size: 22.0),
              activeIcon:
                  Icon(Icons.fitness_center, color: Colors.white, size: 26.0),
              title: Text(
                'Exercices',
                style: TextStyle(
                    color: currentPage != 0 ? Colors.white54 : Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white54, size: 22.0),
              activeIcon: Icon(Icons.home, color: Colors.white, size: 26.0),
              title: Text(
                'Accueil',
                style: TextStyle(
                    color: currentPage != 1 ? Colors.white54 : Colors.white),
              ),
            ),
            BottomNavigationBarItem(
              icon:
                  Icon(Icons.multiline_chart, color: Colors.white54, size: 22.0),
              activeIcon:
                  Icon(Icons.multiline_chart, color: Colors.white, size: 26.0),
              title: Text(
                'Stratistiques',
                style: TextStyle(
                    color: currentPage != 2 ? Colors.white54 : Colors.white),
              ),
            ),
          ],
        ),
        // bottomNavigationBar: Container(
        //   height: 60,
        //   color: StrongrColors.black,
        // ),
      ),
    );
  }
}
