import 'package:flutter/material.dart';
import 'package:strongr/widgets/strongr_text.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.multiline_chart),
          StrongrText('Statistiques'),
        ],
      ),
    );
  }
}
