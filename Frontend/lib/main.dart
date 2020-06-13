import 'package:flutter/material.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/router.dart' as router;
import 'package:strongr/utils/strongr_colors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Strongr',
      theme: ThemeData(
        canvasColor: StrongrColors.canvas,
        primaryColor: StrongrColors.black,
        accentColor: StrongrColors.blue,
        cursorColor: StrongrColors.black,
        fontFamily: 'Futura',
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: HOMEPAGE_ROUTE
    );
  }
}
