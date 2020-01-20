import 'package:flutter/material.dart';

class GoalsView extends StatefulWidget {
  @override
  State createState() => GoalsViewState();
}

class GoalsViewState extends State<GoalsView> {
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
          children: <Widget>[Icon(Icons.star), Text("Objectifs")],
        ),
      ),
    );
  }
}
