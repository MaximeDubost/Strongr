import 'package:flutter/material.dart';

class PerformancesView extends StatefulWidget {
  @override
  State createState() => PerformancesViewState();
}

class PerformancesViewState extends State<PerformancesView> {
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
          children: <Widget>[Icon(Icons.multiline_chart), Text("Performances")],
        ),
      ),
    );
  }
}
