import 'package:flutter/material.dart';

import '../../main.dart';

class ProgramPage extends StatefulWidget {
  final String _programName;

  ProgramPage(this._programName);

  @override
  State createState() => ProgramPageState();
}

class ProgramPageState extends State<ProgramPage> {
List<String> _exercisesOfProgram = [
    "Séance 1",
    "Séance 2",
    "Séance 3"
  ];
  bool _isEmptyList;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width,
      height: 0.2,
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget._programName),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
        backgroundColor: PrimaryColor,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                //color: Colors.indigo,
                child: ReorderableListView(
                  children: <Widget>[
                    for (final item in _exercisesOfProgram)
                      ListTile(
                        key: ValueKey(item),
                        // leading: Icon(Icons.add),
                        title: Text(
                          item,
                          //textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Calibri',
                              fontWeight: FontWeight.w600,
                              color: Colors.grey),
                        ),
                        // trailing: Icon(Icons.help_outline),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.help_outline, color: SecondaryColor,),
                        //   onPressed: () => Navigator.of(context).push(
                        //     CupertinoPageRoute(
                        //         builder: (BuildContext context) =>
                        //             ExercisePage(item))),
                        // ),
                        onTap: () {},
                        onLongPress: () {}, // Enable edit mode
                      ),
                  ],
                  onReorder: (oldValue, newValue) {},
                  
                ),
              ),
            ),
            _buildSeparator(screenSize),
            Container(
                height: height / 8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Color.fromRGBO(40, 140, 100, 1.0),
                      disabledColor: Colors.grey,
                      onPressed: () {},
                      child: Text(
                        "Plannifier le programme",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Calibri',
                            color: Colors.white),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}