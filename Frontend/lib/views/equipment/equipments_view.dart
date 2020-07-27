import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/AppExercise.dart';
import 'package:strongr/models/Equipment.dart';
import 'package:strongr/services/AppExerciseService.dart';
import 'package:strongr/route/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

import 'equipment_view.dart';

class EquipmentsView extends StatefulWidget {
  final int appExerciseId;
  final String appExerciseName;
  final int selectedEquipmentId;

  EquipmentsView({
    this.appExerciseId,
    this.appExerciseName,
    this.selectedEquipmentId,
  });

  @override
  _EquipmentsViewState createState() => _EquipmentsViewState();
}

class _EquipmentsViewState extends State<EquipmentsView> {
  Future<AppExercise> futureEquipments;

  @override
  void initState() {
    futureEquipments =
        AppExerciseService.getAppExercise(id: widget.appExerciseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Équipements associés"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: FutureBuilder(
          future: futureEquipments,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 8),
                  snapshot.data.equipmentList.length == 0
                      ? Center(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: StrongrText(
                              "Aucun équipement associé",
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : SizedBox(),
                  for (final item in snapshot.data.equipmentList)
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
                                      EQUIPMENT_ROUTE,
                                      arguments: EquipmentView(
                                        id: item.id,
                                        name: item.name,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          borderColor: widget.selectedEquipmentId == item.id ? StrongrColors.blue : StrongrColors.greyD,
                          borderWidth: widget.selectedEquipmentId == item.id ? 2 : 1,
                          onPressed: () => Navigator.pop(
                            context,
                            Equipment(
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
