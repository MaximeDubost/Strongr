import 'package:flutter/material.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/homepage/pages/app_exercises_page.dart';
import 'package:strongr/views/homepage/pages/homepage.dart';
import 'package:strongr/views/homepage/pages/statistics_page.dart';
import 'package:strongr/widgets/dialogs/filters_dialog.dart';

class HomepageView extends StatefulWidget {
  @override
  _HomepageViewState createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  GlobalKey<dynamic> _appExercisesPageKey;
  // GlobalKey<dynamic> _homepageKey;
  List<Widget> pagesList;
  List<String> popupMenuItems,
      // homepagePopupMenuItems,
      appExercisesPopupMenuItems;
  int currentPage;

  @override
  void initState() {
    _appExercisesPageKey = GlobalKey();
    // _homepageKey = GlobalKey();
    currentPage = 1;
    pagesList = [
      AppExercisesPage(key: _appExercisesPageKey),
      Homepage(),
      StatisticsPage(),
    ];
    // homepagePopupMenuItems = ["Profil", "Paramètres"];
    appExercisesPopupMenuItems 
    = ["Filtres", "Paramètres"];
    // = ["Profil", "Paramètres", "Filtres"];
    popupMenuItems =
        // currentPage != 0 ? homepagePopupMenuItems :
        appExercisesPopupMenuItems;
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
          // leading: IconButton(
          //   tooltip: "Notifications",
          //   icon: Icon(Icons.notifications_none),
          //   color: Colors.white,
          //   onPressed: () {},
          // ),
          leading: IconButton(
            tooltip: "Profil",
            icon: Icon(Icons.account_circle),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, PROFILE_ROUTE);
            },
          ),
          title: Text(
            currentPage == 1
                ? "Strongr"
                : currentPage == 0 ? "Exercices" : "Statistiques",
          ),
          actions: <Widget>[
            currentPage == 0
                ? PopupMenuButton<String>(
                    tooltip: "Menu",
                    onSelected: (value) async {
                      switch (value) {
                        // case "Profil":
                        //   break;
                        case "Paramètres":
                          break;
                        case "Filtres":
                          await showDialog(
                            context: context,
                            builder: (context) => FiltersDialog(),
                          ).then((val) {
                            if (val == true) {
                              _appExercisesPageKey.currentState.refresh();
                            }
                          });
                          break;
                      }
                    },
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
                  )
                : IconButton(
                    tooltip: "Réglages",
                    icon: Icon(Icons.settings),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, SETTINGS_ROUTE);
                    },
                  ),
          ],
        ),
        body: pagesList[currentPage],
        bottomNavigationBar: buildBottomNavigationBar(),
      ),
    );
  }

  /// Retourne la barre de navigation inférieure.
  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      showUnselectedLabels: false,
      backgroundColor: StrongrColors.black,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentPage,
      onTap: (index) {
        setState(() {
          currentPage = index;
          popupMenuItems = 
          // currentPage != 0 ? homepagePopupMenuItems : 
          appExercisesPopupMenuItems;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.fitness_center,
            color: Colors.white54,
            size: 22.0,
          ),
          activeIcon: Icon(
            Icons.fitness_center,
            color: Colors.white,
            size: 26.0,
          ),
          title: Text(
            'Exercices',
            style: TextStyle(
              color: currentPage != 0 ? Colors.white54 : Colors.white,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.white54,
            size: 22.0,
          ),
          activeIcon: Icon(
            Icons.home,
            color: Colors.white,
            size: 26.0,
          ),
          title: Text(
            'Accueil',
            style: TextStyle(
              color: currentPage != 1 ? Colors.white54 : Colors.white,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.multiline_chart,
            color: Colors.white54,
            size: 22.0,
          ),
          activeIcon: Icon(
            Icons.multiline_chart,
            color: Colors.white,
            size: 26.0,
          ),
          title: Text(
            'Statistiques',
            style: TextStyle(
              color: currentPage != 2 ? Colors.white54 : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
