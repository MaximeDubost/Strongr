import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/homepage/pages/exercises.dart';
import 'package:strongr/views/homepage/pages/homepage.dart';
import 'package:strongr/views/homepage/pages/statistics.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

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
      Exercises(),
      Homepage(),
      Statistics(),
    ];
    popupMenuItems = [
      "Profil",
      "Paramètres",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.notifications_none),
          color: Colors.white,
          onPressed: () {},
        ),
        title: Text("Strongr"),
        actions: <Widget>[
          // IconButton(
          //     icon: Icon(Icons.more_vert),
          //     color: Colors.white,
          //     onPressed: () {},
          // ),
          PopupMenuButton<String>(
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
        onTap: (index) {
          setState(() => currentPage = index);
        },
        backgroundColor: StrongrColors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center, color: Colors.white70, size: 22.0),
            activeIcon:
                Icon(Icons.fitness_center, color: Colors.white, size: 26.0),
            title: Text(
              'Exercices',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white70, size: 22.0),
            activeIcon: Icon(Icons.home, color: Colors.white, size: 26.0),
            title: Text(
              'Accueil',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.multiline_chart, color: Colors.white70, size: 22.0),
            activeIcon:
                Icon(Icons.multiline_chart, color: Colors.white, size: 26.0),
            title: Text(
              'Stratistiques',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Container(
      //   height: 60,
      //   color: StrongrColors.black,
      // ),
    );
  }
}
