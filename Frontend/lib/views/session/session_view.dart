import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SessionView extends StatefulWidget {
  final String id;
  final String name;

  SessionView({this.id, this.name});

  @override
  _SessionViewState createState() => _SessionViewState();
}

class _SessionViewState extends State<SessionView> {
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
              // color: Colors.yellow,
              width: 35,
              child: Center(
                child: StrongrText(
                  i.toString(),
                  bold: true,
                ),
              ),
            ),
            Flexible(
              child: Container(
                // color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(Icons.fitness_center),
                        ),
                        Flexible(
                          child: Container(
                            // color: Colors.blue,
                            child: StrongrText(
                              "Crunch",
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Icon(Icons.refresh),
                        ),
                        Container(
                          width: 185,
                          child: StrongrText(
                            "4 séries",
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isEditMode,
              child: Container(
                // color: Colors.green,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 35,
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.close,
                          color: Colors.red[800],
                        ),
                        shape: CircleBorder(),
                      ),
                    ),
                    Container(
                      width: 35,
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Icon(
                          Icons.reorder,
                          color: Colors.grey,
                        ),
                        shape: CircleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !isEditMode,
              child: Container(
                width: 35,
                height: 35,
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "play_fab_" + i.toString(),
                  tooltip: "Démarrer",
                  backgroundColor: StrongrColors.blue,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
              ),
            )
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
            InkWell(
              onTap: isEditMode ? null : () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 100,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: StrongrText(
                      "Full body",
                      // size: 22,
                      bold: true,
                    ),
                  ),
                  Opacity(
                    opacity: isEditMode ? 0 : 1,
                    child: Container(
                      height: 50,
                      width: 100,
                      child: Icon(Icons.info_outline),
                    ),
                  ),
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
                        for (int i = 1; i <= 4; i++) buildListViewItem(i),
                      ],
                    )
                  : ListView(
                      children: <Widget>[
                        for (int i = 1; i <= 4; i++) buildListViewItem(i),
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
            Visibility(
              visible: isEditMode,
              child: Container(
                padding: EdgeInsets.all(10),
                width: ScreenSize.width(context),
                child: Center(
                  child: FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.grey,
                    onPressed: () {},
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'session_fab_' + widget.id.toString(),
        backgroundColor: isEditMode ? Colors.red[800] : StrongrColors.blue,
        icon: Icon(
          isEditMode ? Icons.delete_outline : Icons.play_arrow,
          color: Colors.white,
        ),
        onPressed: isEditMode ? () {} : () {},
        label: StrongrText(
          isEditMode ? "Supprimer" : "Démarrer",
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
