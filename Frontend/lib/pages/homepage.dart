import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/UI/dashboard_view.dart';
import 'package:flutter_app_test/UI/goals_view.dart';
import 'package:flutter_app_test/UI/programs_view.dart';
import 'package:flutter_app_test/UI/sessions_view.dart';
import 'package:flutter_app_test/UI/statistics_view.dart';

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
          StatisticsView(),
          GoalsView(),
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
            icon: Icon(Icons.fitness_center, color: Colors.white),
            activeIcon: Icon(Icons.fitness_center, color: DarkColor),
            title: Text(
              'Programmes',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range, color: Colors.white),
            activeIcon: Icon(Icons.date_range, color: DarkColor),
            title: Text(
              'Séances',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            activeIcon: Icon(Icons.home, color: DarkColor),
            title: Text(
              'Dashboard',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.multiline_chart, color: Colors.white),
            activeIcon: Icon(Icons.multiline_chart, color: DarkColor),
            title: Text(
              'Stats',
              style: TextStyle(color: Colors.white),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.white),
            activeIcon: Icon(Icons.star, color: DarkColor),
            title: Text(
              'Objectifs',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
