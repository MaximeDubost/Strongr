import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/AppExercise.dart';
import 'package:strongr/services/AppExerciseService.dart';
import 'package:strongr/route/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/app_exercise/app_exercise_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class EquipmentView extends StatefulWidget {
  final int id;
  final String name;

  EquipmentView({
    this.id,
    this.name,
  });

  @override
  _EquipmentViewState createState() => _EquipmentViewState();
}

class _EquipmentViewState extends State<EquipmentView> {
  Future<List<AppExercise>> futureAppExercises;

  @override
  void initState() {
    futureAppExercises =
        AppExerciseService.getAppExercisesOfEquipment(id: widget.id);
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
        padding: EdgeInsets.only(left: 5, right: 5),
        child: FutureBuilder(
          future: futureAppExercises,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8),
                    child: StrongrText(
                      snapshot.data.length == 1
                          ? "Exercice associé"
                          : "Exercices associés",
                      textAlign: TextAlign.start,
                    ),
                  ),
                  snapshot.data.length == 0
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: StrongrText(
                              "Aucun Exercice",
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
                                  child: Icon(
                                    Icons.info_outline,
                                    color: StrongrColors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          borderColor: StrongrColors.greyD,
                          borderWidth: 1,
                          onPressed: () => Navigator.pushNamed(
                            context,
                            APP_EXERCISE_ROUTE,
                            arguments: AppExerciseView(
                              id: item.id,
                              name: item.name,
                              isBelonged: true,
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
