import 'package:flutter/material.dart';

class StatisticsView extends StatefulWidget {
  @override
  State createState() => StatisticsViewState();
}

class StatisticsViewState extends State<StatisticsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.multiline_chart),
            Text("Statistiques")
          ],
        ),
      ),
    );
  }
}