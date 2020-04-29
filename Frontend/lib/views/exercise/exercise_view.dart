import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExerciseView extends StatefulWidget {
  final String id;
  final String name;

  ExerciseView({this.id, this.name});

  @override
  _ExerciseViewState createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  bool isEditMode;

  @override
  void initState() {
    isEditMode = false;
    super.initState();
  }

  Container buildListViewItem(int i) {
    return Container(
      margin: i == 1 ? EdgeInsets.only(top: 5) : null,
      key: ValueKey(i),
      padding: EdgeInsets.all(5),
      height: 90,
      child: StrongrRoundedContainer(
        width: ScreenSize.width(context),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 35,
              width: 35,
              child: Center(
                child: StrongrText(
                  i.toString(),
                  bold: true,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.replay),
                      StrongrText(" Répétitions : 10"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.hourglass_empty),
                      StrongrText(" Repos : 60s"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 35,
              width: 35,
              child: isEditMode ? RawMaterialButton(
                onPressed: () {},
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red[300],
                ),
                shape: CircleBorder(),
              ) : RawMaterialButton(onPressed: null),
            ),
            Container(
              height: 35,
              width: 35,
              child: isEditMode ? RawMaterialButton(
                onPressed: () {},
                child: Icon(
                  Icons.reorder,
                  color: Colors.grey,
                ),
                shape: CircleBorder(),
              ) : RawMaterialButton(onPressed: null),
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
        leading: isEditMode
            ? IconButton(
                icon: Icon(Icons.close),
                onPressed: () => setState(() => isEditMode = false),
              )
            : BackButton(),
        actions: <Widget>[
          isEditMode
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => setState(() => isEditMode = true),
                ),
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RawMaterialButton(onPressed: null),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: StrongrText(
                      "Crunch",
                      size: 22,
                      bold: true,
                    ),
                  ),
                  isEditMode
                      ? RawMaterialButton(onPressed: null)
                      : Container(
                          alignment: Alignment.centerRight,
                          child: RawMaterialButton(
                            onPressed: () {},
                            child: Icon(
                              Icons.info_outline,
                            ),
                            shape: CircleBorder(),
                          ),
                        )
                ],
              ),
            ),
            Container(
              width: ScreenSize.width(context),
              height: 1,
              color: Colors.grey[350],
            ),
            Container(
              // margin: EdgeInsets.only(top: 10),
              height: ScreenSize.height(context) / 1.6,
              child: isEditMode
                  ? ReorderableListView(
                      onReorder: (oldIndex, newIndex) {},
                      children: <Widget>[
                        for (int i = 1; i <= 6; i++) buildListViewItem(i),
                      ],
                    )
                  : ListView(
                      children: <Widget>[
                        for (int i = 1; i <= 6; i++) buildListViewItem(i),
                      ],
                    ),
            ),
            Container(
              width: ScreenSize.width(context),
              height: 1,
              color: Colors.grey[350],
            ),
            Visibility(
              visible: !isEditMode,
              child: Container(
                padding: EdgeInsets.all(10),
                width: ScreenSize.width(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StrongrText(
                      "Créé le 01/01/2020 à 00:00.",
                      color: Colors.grey,
                      size: 16,
                    ),
                    StrongrText(
                      "Mis à jour le 01/01/2020 à 00:00.",
                      color: Colors.grey,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'exercise_fab_' + widget.id.toString(),
        backgroundColor: isEditMode ? Colors.red[800] : StrongrColors.blue,
        icon: Icon(
          isEditMode ? Icons.delete_outline : Icons.play_arrow,
          color: Colors.white,
        ),
        onPressed: () {},
        label: StrongrText(
          isEditMode ? "Supprimer" : "Démarrer",
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
