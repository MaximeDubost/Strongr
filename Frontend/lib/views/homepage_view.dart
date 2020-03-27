import 'package:flutter/material.dart';
import 'package:strongr/services/connection_service.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class HomepageView extends StatefulWidget {
  @override
  _HomepageViewState createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> {
  List<Widget> exercisesList;
  List<Widget> sessionsList;
  List<Widget> programsList;
  List<String> popupMenuItems;

  @override
  void initState() {
    popupMenuItems = [
      "Profil",
      "Paramètres",
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**
       * DEBUG
       */
      floatingActionButton: FloatingActionButton(
        onPressed: () => ConnectionService.postLogIn(connectId: 'kevtsi@gmail.com', password: 'motdepasse'),
      ),
      /**
       * END DEBUG
       */
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
      body: Container(
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
            Container(
              padding: EdgeInsets.all(5),
              // color: Colors.green,
              height: ScreenSize.height(context) / 5.5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  StrongrRoundedContainer(),
                  StrongrRoundedContainer(),
                  StrongrRoundedContainer(),
                ],
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
            Container(
              padding: EdgeInsets.all(5),
              // color: Colors.green,
              height: ScreenSize.height(context) / 5.5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  StrongrRoundedContainer(),
                  StrongrRoundedContainer(),
                  StrongrRoundedContainer(),
                ],
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
            Container(
              padding: EdgeInsets.all(5),
              // color: Colors.green,
              height: ScreenSize.height(context) / 5.5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  StrongrRoundedContainer(),
                  StrongrRoundedContainer(),
                  StrongrRoundedContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: StrongrColors.black,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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
    );
  }
}
