import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/ProgramGoal.dart';
import 'package:strongr/services/ProgramGoalService.dart';
import 'package:strongr/route/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

import 'program_goal_view.dart';

class ProgramGoalsView extends StatefulWidget {
  final int selectedProgramGoalId;

  ProgramGoalsView({this.selectedProgramGoalId});

  @override
  _ProgramGoalsViewState createState() => _ProgramGoalsViewState();
}

class _ProgramGoalsViewState extends State<ProgramGoalsView> {
  Future<List<ProgramGoal>> futureProgramGoals;

  @override
  void initState() {
    futureProgramGoals = ProgramGoalService.getProgramGoals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Objectif du programme"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: FutureBuilder(
          future: futureProgramGoals,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 8),
                  snapshot.data.length == 0
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: StrongrText(
                              "Aucun élément à afficher",
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : SizedBox(),
                  for (final item in snapshot.data)
                    Column(
                      children: <Widget>[
                        StrongrRoundedContainer(
                          width: ScreenSize.width(context),
                          content: Container(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: StrongrText(
                                      item.name,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 35,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.info_outline,
                                      color: StrongrColors.blue,
                                    ),
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      PROGRAM_GOAL_ROUTE,
                                      arguments: ProgramGoalView(
                                        id: item.id,
                                        name: item.name,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          borderColor: widget.selectedProgramGoalId == item.id
                              ? StrongrColors.blue
                              : StrongrColors.greyD,
                          borderWidth:
                              widget.selectedProgramGoalId == item.id ? 2 : 1,
                          onPressed: () => Navigator.pop(
                            context,
                            ProgramGoal(
                              id: item.id,
                              name: item.name,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  SizedBox(height: 25),
                ],
              ));
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
