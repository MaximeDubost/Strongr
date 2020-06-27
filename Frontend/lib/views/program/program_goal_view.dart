import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/ProgramGoal.dart';
import 'package:strongr/services/ProgramGoalService.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ProgramGoalView extends StatefulWidget {
  final int id;
  final String name;

  ProgramGoalView({
    this.id,
    this.name,
  });

  @override
  _ProgramGoalViewState createState() => _ProgramGoalViewState();
}

class _ProgramGoalViewState extends State<ProgramGoalView> {
  Future<ProgramGoal> futureProgramGoal;

  @override
  void initState() {
    futureProgramGoal = ProgramGoalService.getProgramGoal(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
          future: futureProgramGoal,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StrongrText(
                snapshot.data.description,
                textAlign: TextAlign.justify,
                maxLines: 24,
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error, textAlign: TextAlign.center);
            } else
              return Container(
                alignment: Alignment.center,
                height: ScreenSize.height(context) / 1.25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(StrongrColors.blue),
                ),
              );
          },
        ),
      ),
    );
  }
}
