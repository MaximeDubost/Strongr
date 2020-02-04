import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/main.dart';

import '../../main.dart';
import '../homepage.dart';

class WelcomePage extends StatefulWidget {
  @override
  State createState() => new WelcomePageState();
}

class WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController _pageController;
  Icon _fabIcon;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _fabIcon = Icon(Icons.arrow_forward_ios);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_page == 2) {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (BuildContext context) => Homepage()));
          } else {
            setState(() {
              this._pageController.animateToPage(_page + 1,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
              this._page++;
            });
          }

          if (_page == 2)
            setState(() {
              this._fabIcon = Icon(Icons.check);
            });
          else
            setState(() {
              this._fabIcon = Icon(Icons.arrow_forward_ios);
            });
        },
        child: _fabIcon,
        backgroundColor: PrimaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (newPage) {
                setState(() {
                  this._page = newPage;
                  if (this._page == 2)
                    this._fabIcon = Icon(Icons.check);
                  else
                    this._fabIcon = Icon(Icons.arrow_forward);
                });
              },
              children: <Widget>[
                Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Bienvenue sur Strongr !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Calibri',
                                fontWeight: FontWeight.bold,
                                color: PrimaryColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.fitness_center,
                              color: Colors.grey, size: 32.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Accédez à tout moment à un grand nombre d'exercices à faire chez soi, en extérieur ou en salle de sport.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Calibri',
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "L'organisation. Avant tout.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Calibri',
                                //fontWeight: FontWeight.bold,
                                color: PrimaryColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.date_range,
                              color: Colors.grey, size: 32.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Créez et organisez vos propres séances et intégrez-les dans des programmes personnalisés.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Calibri',
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Plus fort chaque jour.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                fontFamily: 'Calibri',
                                // fontWeight: FontWeight.bold,
                                color: PrimaryColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.multiline_chart,
                              color: Colors.grey, size: 32.0),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Suivez votre évolution et améliorez vos performances au fil du temps.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Calibri',
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
              height: height / 8,
              width: width,
              //color: Colors.blue,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: FlatButton(
                        onPressed: () => Navigator.of(context).push(
                            CupertinoPageRoute(
                                builder: (BuildContext context) => Homepage())),
                        child: Text(
                          "Ignorer",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Calibri',
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            width: _page == 0 ? 12.0 : 10.0,
                            height: _page == 0 ? 12.0 : 10.0,
                            decoration: BoxDecoration(
                              color: _page == 0 ? PrimaryColor : Colors.grey,
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            width: _page == 1 ? 12.0 : 10.0,
                            height: _page == 1 ? 12.0 : 10.0,
                            decoration: BoxDecoration(
                              color: _page == 1 ? PrimaryColor : Colors.grey,
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            width: _page == 2 ? 12.0 : 10.0,
                            height: _page == 2 ? 12.0 : 10.0,
                            decoration: BoxDecoration(
                              color: _page == 2 ? PrimaryColor : Colors.grey,
                              borderRadius: BorderRadius.circular(80.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
