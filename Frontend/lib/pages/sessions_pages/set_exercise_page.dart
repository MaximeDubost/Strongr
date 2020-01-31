import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../main.dart';

class SetExercisePage extends StatefulWidget {
  final String _exerciseName;

  SetExercisePage(this._exerciseName);

  @override
  State createState() => SetExercisePageState();
}

class SetExercisePageState extends State<SetExercisePage> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _unique = false, _validate = false, _visibility = false;
  TextEditingController _seriesCountController;
  int seriesCount, linesCount = 1;
  String errorText = "";
  List<String> _equipmentList = [
    "Équipement",
    "Aucun équipement",
    "Équipement 1",
    "Équipement 2",
    "Équipement 3",
    "Équipement 4",
    "Équipement 5",
  ];
  List<String> _workMethodsList = [
    "Méthode de travail",
    "Méthode de travail 1",
    "Méthode de travail 2",
    "Méthode de travail 3",
    "Méthode de travail 4",
    "Méthode de travail 5",
    "Méthode de travail personnalisée",
  ];

  @override
  void initState() {
    super.initState();
    _seriesCountController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _seriesCountController.dispose();
  }

  String validateSeriesCount(String value) {
    // if (value.length == 0)
    //   return "Vous devez renseigner un nombre de séries";
    // if (value.startsWith("0"))
    //   return "Format incorrect";
    // if (int.parse(value) < 1)
    //   return "Vous ne pouvez pas effectuer moins d'une série";
    // if (int.parse(value) > 10)
    //   return "Vous ne pouvez pas effectuer plus de 10 séries";
    
    if(value.length == 0 || value.startsWith("0") || int.parse(value) < 1 || int.parse(value) > 10)
      return "";
    else
      return null;
  }

  void sendToServer() {
    if (_key.currentState.validate() && _seriesCountController.text != "") {
      _key.currentState.save();
      setState(() {
        seriesCount = int.parse(_seriesCountController.text);
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
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
    //double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.check),
              color: Colors.white,
              onPressed: () {
                sendToServer();
              }),
        ],
        title: Text(widget._exerciseName),
        backgroundColor: PrimaryColor,
      ),
      body: Container(
        child: Center(
          child: Form(
            key: _key,
            autovalidate: _validate,
            child: Column(
              children: <Widget>[
                Container(
                  //color: Colors.blue,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: width,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: DropdownButtonFormField(
                            onChanged: (newValue) {},
                            items: <DropdownMenuItem>[
                              for (var item in _equipmentList)
                                DropdownMenuItem(
                                  child: Text(item),
                                ),
                            ],
                            hint: Text("Équipement"),
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: DropdownButtonFormField(
                            onChanged: (newValue) {},
                            items: <DropdownMenuItem>[
                              for (var item in _workMethodsList)
                                DropdownMenuItem(
                                  child: Text(item),
                                ),
                            ],
                            hint: Text("Méthode de travail"),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 20, 5, 20),
                              child: TextFormField(
                                  maxLength: 2,
                                  validator: validateSeriesCount,
                                  onSaved: (String value) {
                                    seriesCount = int.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  cursorColor: Colors.grey,
                                  controller: _seriesCountController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    labelText: 'Séries',
                                    labelStyle: TextStyle(color: Colors.grey),
                                    counterText: "",
                                  ),
                                  onChanged: (newValue) {
                                    if (_seriesCountController.text == "" ||
                                        _seriesCountController.text
                                            .startsWith("0") ||
                                        int.parse(_seriesCountController.text) <
                                            1 ||
                                        int.parse(_seriesCountController.text) >
                                            10) {
                                      setState(() {
                                        _visibility = false;
                                        linesCount = 0;
                                        print(linesCount);
                                      });
                                    } else {
                                      setState(() {
                                        _visibility = true;
                                      });
                                      if (_unique) {
                                        linesCount = int.parse(newValue);
                                        print(linesCount);
                                      } else {
                                        linesCount = 1;
                                        print(linesCount);
                                      }
                                    }
                                  }),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              "Rendre chaque série unique",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: Switch(
                                value: _unique,
                                onChanged: !(_seriesCountController.text ==
                                            "" ||
                                        _seriesCountController.text
                                            .startsWith("0") ||
                                        int.parse(
                                                _seriesCountController.text) <=
                                            1 ||
                                        int.parse(_seriesCountController.text) >
                                            10)
                                    ? (newValue) {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _unique = !_unique;
                                        });
                                        if (_unique == false) {
                                          linesCount = 1;
                                          print(linesCount);
                                        } else if (_seriesCountController.text ==
                                                "" ||
                                            _seriesCountController.text
                                                .startsWith("0") ||
                                            int.parse(_seriesCountController
                                                    .text) <
                                                1 ||
                                            int.parse(_seriesCountController
                                                    .text) >
                                                10) {
                                          linesCount = 0;
                                          print(linesCount);
                                        } else {
                                          linesCount = int.parse(
                                              _seriesCountController.text);
                                          print(linesCount);
                                        }
                                      }
                                    : null),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(_validate ? errorText : ""),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _visibility,
                  child: _buildSeparator(screenSize),
                ),
                Expanded(
                  child: Visibility(
                    visible: _visibility,
                    child: Container(
                      //color: Colors.cyan,
                      child: ListView(
                        children: <Widget>[
                          for (int i = 0; i < linesCount; i++)
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text(
                                    _unique ? (i + 1).toString() : "-",
                                    style: TextStyle(
                                        color: SecondaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Flexible(
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 5, 10),
                                          child: TextFormField(
                                            maxLength: 3,
                                            keyboardType: TextInputType.number,
                                            cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              labelText: 'Répétitions',
                                              labelStyle:
                                                  TextStyle(color: Colors.grey),
                                              counterText: "",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 10, 5, 10),
                                          child: TextFormField(
                                            maxLength: 5,
                                            keyboardType:
                                                TextInputType.datetime,
                                            cursorColor: Colors.grey,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              labelText: 'Repos',
                                              labelStyle:
                                                  TextStyle(color: Colors.grey),
                                              counterText: "",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.tune,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
