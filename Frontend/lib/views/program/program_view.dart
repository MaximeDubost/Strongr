import 'package:flutter/material.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ProgramView extends StatefulWidget {
  final String id;
  final String name;

  ProgramView({this.id, this.name});

  @override
  _ProgramViewState createState() => _ProgramViewState();
}

class _ProgramViewState extends State<ProgramView> {
  String weekday;

  @override
  void initState() {
    switch (DateTime.now().weekday) {
      case DateTime.monday:
        weekday = "Lundi";
        break;
      case DateTime.tuesday:
        weekday = "Mardi";
        break;
      case DateTime.wednesday:
        weekday = "Mercredi";
        break;
      case DateTime.thursday:
        weekday = "Jeudi";
        break;
      case DateTime.friday:
        weekday = "Vendredi";
        break;
      case DateTime.saturday:
        weekday = "Samedi";
        break;
      case DateTime.sunday:
        weekday = "Dimanche";
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'program_fab_' + widget.id.toString(),
        icon: Icon(
          Icons.play_arrow,
          color: Colors.white,
        ),
        backgroundColor: StrongrColors.blue,
        onPressed: () {},
        label: StrongrText(
          "Démarrer (" + weekday + ")",
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
