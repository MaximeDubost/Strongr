import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/UI/homepage/dashboard_view.dart';
import 'package:strongr/UI/homepage/exercises_view.dart';
import 'package:strongr/UI/homepage/performances_view.dart';
import 'package:strongr/UI/homepage/programs_view.dart';
import 'package:strongr/UI/homepage/sessions_view.dart';

import '../main.dart';
import 'profile_pages/profile_page.dart';
import 'settings_pages/settings_page.dart';

class Homepage extends StatefulWidget {
  @override
  State createState() => new HomepageState();
}

class HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  int _page = 2;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 2);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white,
          onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => SettingsPage())),
        ),
        title: Text("Strongr"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            color: Colors.white,
            onPressed: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => ProfilePage())),
          ),
          
        ],
        backgroundColor: PrimaryColor,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (newPage) {
          setState(() {
            this._page = newPage;
          });
        },
        children: <Widget>[
          ProgramsView(),
          SessionsView(),
          DashboardView(),
          ExercisesView(),
          PerformancesView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //type: BottomNavigationBarType.shifting,
        type : BottomNavigationBarType.fixed,
        backgroundColor: PrimaryColor,
        currentIndex: _page,
        onTap: (index) {
          this._pageController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range, color: Colors.white70, size: 22.0),
            activeIcon: Icon(Icons.date_range, color: Colors.white, size: 26.0),
            title: Text(
              'Programmes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Colors.white70, size: 22.0),
            activeIcon: Icon(Icons.calendar_today, color: Colors.white, size: 26.0),
            title: Text(
              'Séances',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white70, size: 22.0),
            activeIcon: Icon(Icons.home, color: Colors.white, size: 26.0),
            title: Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center, color: Colors.white70, size: 22.0),
            activeIcon: Icon(Icons.fitness_center, color: Colors.white, size: 26.0),
            title: Text(
              'Exercices',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.multiline_chart, color: Colors.white70, size: 22.0),
            activeIcon: Icon(Icons.multiline_chart, color: Colors.white, size: 26.0),
            title: Text(
              'Performances',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
