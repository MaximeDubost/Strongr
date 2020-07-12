import 'package:flutter/material.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.multiline_chart,
                color: StrongrColors.black,
              ),
              StrongrText(
                "Disponible dans une prochaine mise à jour",
                color: StrongrColors.black80,
                maxLines: 5,
              ),
            ],
          )),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Icon(Icons.multiline_chart),
      //     StrongrText("Disponible dans une prochaine mise à jour"),
      //   ],
      // ),
    );
  }
}
