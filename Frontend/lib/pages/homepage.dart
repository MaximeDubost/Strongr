import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'profile_page.dart';
import 'settings_page.dart';

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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.fitness_center),
                Text("Programmes")
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.date_range),
                Text("Séances")
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Bienvenue, Maxime ! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28, fontFamily: 'Calibri', fontWeight: FontWeight.bold, color: PrimaryColor),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Text(
                    "C'est bien vide par ici... 🤔",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, fontFamily: 'Calibri', color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 30, 50, 0),
                  child: Text(
                    "Que diriez-vous de nous en dire un peu plus sur vous ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18, fontFamily: 'Calibri', fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: RaisedButton(
                    color: Color.fromRGBO(40, 140, 100, 1.0),
                    disabledColor: Colors.grey,
                    onPressed:  () {},
                    child: Text(
                      "Allons-y !",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Calibri',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.multiline_chart),
                Text("Statistiques")
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.star),
                Text("Objectifs")
              ],
            ),
          ),
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
