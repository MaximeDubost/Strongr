import 'package:flutter/material.dart';
import 'package:strongr/widgets/strongr_text.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Center(child: StrongrText('Statistics'),);
  }
}