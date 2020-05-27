import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/app_exercise/app_exercise_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

import 'exercise_view.dart';

class ExerciseCreateView extends StatefulWidget {
  final int id;
  final String name;

  ExerciseCreateView({
    @required this.id,
    @required this.name,
  });

  _ExerciseCreateViewState createState() => _ExerciseCreateViewState();
}

class _ExerciseCreateViewState extends State<ExerciseCreateView> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _unique, _validate, _visibility;
  TextEditingController _seriesCountController;
  int linesCount = 1;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    _seriesCountController = TextEditingController(text: "1");
    _visibility = !validSet();
    _unique = _validate = false;
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

    if (value.length == 0 ||
        value.startsWith("0") ||
        int.parse(value) < 1 ||
        int.parse(value) > 10)
      return "";
    else
      return null;
  }

  void sendToServer() {
    if (_key.currentState.validate() && _seriesCountController.text != "") {
      _key.currentState.save();
      setState(() {
        linesCount = int.parse(_seriesCountController.text);
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  /// Détermine si le champ "Séries" est valide ou non.
  /// Retourne true s'il est valide, false sinon.
  bool validSet({bool strict = false}) {
    bool res = strict
        ? !(_seriesCountController.text == "" ||
            _seriesCountController.text.startsWith("0") ||
            int.parse(_seriesCountController.text) < 1 ||
            int.parse(_seriesCountController.text) > 10)
        : !(_seriesCountController.text == "" ||
            _seriesCountController.text.startsWith("0") ||
            int.parse(_seriesCountController.text) <= 1 ||
            int.parse(_seriesCountController.text) > 10);
    return res;
  }

  void changeSetCount() {
    if (_unique == false) {
      linesCount = 1;
      // print(linesCount);
    } else if (_seriesCountController.text == "" ||
        _seriesCountController.text.startsWith("0") ||
        int.parse(_seriesCountController.text) < 1 ||
        int.parse(_seriesCountController.text) > 10) {
      linesCount = 0;
      // print(linesCount);
    } else {
      linesCount = int.parse(_seriesCountController.text);
      // print(linesCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(),
        title: Text(widget.name),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.pushNamed(
                context,
                APP_EXERCISE_ROUTE,
                arguments: AppExerciseView(
                  id: widget.id,
                  name: widget.name,
                  isBelonged: true,
                ),
              );
            },
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: <Widget>[
            Form(
              key: _key,
              autovalidate: _validate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: StrongrRoundedTextFormField(
                      controller: null,
                      validator: null,
                      // onSaved: (String value) => setState(
                      // () => connectId = value.toLowerCase()),
                      onSaved: (value) {},

                      // onChanged: (String value) {
                      //   setState(() => warning = null);
                      //   isEmpty();
                      // },
                      onChanged: (value) {},
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      hint: "Nom de votre exercice (facultatif)",
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: StrongrText("Équipement"),
                  ),
                  Container(
                    // color: Colors.red,
                    height: 100,
                    width: ScreenSize.width(context),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.all(10),
                      children: <Widget>[
                        StrongrRoundedContainer(
                          width: ScreenSize.width(context) / 1.5,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                // color: Colors.red,
                                width: ScreenSize.width(context) / 2.8,
                                child: Center(
                                  child: StrongrText(
                                    "Banc décliné",
                                    size: 18,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              IconButton(
                                icon: Icon(Icons.info_outline),
                                onPressed: () {},
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                        StrongrRoundedContainer(
                          width: ScreenSize.width(context) / 1.5,
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                // color: Colors.red,
                                width: ScreenSize.width(context) / 2.8,
                                child: Center(
                                  child: StrongrText(
                                    "Poulie position haute",
                                    size: 18,
                                  ),
                                ),
                              ),
                              VerticalDivider(
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              IconButton(
                                icon: Icon(Icons.info_outline),
                                onPressed: () {},
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: StrongrText("Séries"),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 50,
                          child: StrongrRoundedContainer(
                            width: 135,
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: RawMaterialButton(
                                    child: StrongrText(
                                      "-",
                                      color: _seriesCountController.text != "1"
                                          ? StrongrColors.black
                                          : Colors.grey,
                                    ),
                                    shape: CircleBorder(),
                                    onPressed: _seriesCountController.text !=
                                            "1"
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            if (!_seriesCountController.text
                                                .startsWith("0")) {
                                              try {
                                                if (int.parse(
                                                        _seriesCountController
                                                            .text) >
                                                    1) {
                                                  int count = int.parse(
                                                      _seriesCountController
                                                          .text);
                                                  count--;
                                                  setState(() =>
                                                      _seriesCountController
                                                              .text =
                                                          count.toString());
                                                } else
                                                  setState(() =>
                                                      _seriesCountController
                                                          .text = "1");
                                              } catch (e) {
                                                setState(() =>
                                                    _seriesCountController
                                                        .text = "1");
                                              }
                                              _unique
                                                  ? setState(() => linesCount =
                                                      int.parse(
                                                          _seriesCountController
                                                              .text))
                                                  : setState(
                                                      () => linesCount = 1);
                                            }
                                          }
                                        : null,
                                    onLongPress: _seriesCountController.text !=
                                            "1"
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            setState(() =>
                                                _seriesCountController.text =
                                                    "1");
                                            _unique
                                                ? setState(() => linesCount =
                                                    int.parse(
                                                        _seriesCountController
                                                            .text))
                                                : setState(
                                                    () => linesCount = 1);
                                          }
                                        : null,
                                  ),
                                ),
                                // StrongrText("10"),
                                Flexible(
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    validator: validateSeriesCount,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(2),
                                      WhitelistingTextInputFormatter.digitsOnly
                                    ],
                                    controller: _seriesCountController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.all(5),
                                    ),
                                    onSaved: (String value) {
                                      linesCount = int.parse(value);
                                    },
                                    onChanged: (newValue) {
                                      if (_seriesCountController.text == "" ||
                                          _seriesCountController.text
                                              .startsWith("0") ||
                                          int.parse(
                                                  _seriesCountController.text) <
                                              1 ||
                                          int.parse(
                                                  _seriesCountController.text) >
                                              10) {
                                        setState(() {
                                          _visibility = false;
                                          linesCount = 0;
                                          // print(linesCount);
                                        });
                                      } else {
                                        setState(() => _visibility = true);
                                        if (_unique) {
                                          linesCount = int.parse(newValue);
                                          // print(linesCount);
                                        } else {
                                          linesCount = 1;
                                          // print(linesCount);
                                        }
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: RawMaterialButton(
                                    child: StrongrText(
                                      "+",
                                      color: _seriesCountController.text != "10"
                                          ? StrongrColors.black
                                          : Colors.grey,
                                    ),
                                    shape: CircleBorder(),
                                    onPressed: _seriesCountController.text !=
                                            "10"
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            if (!_seriesCountController.text
                                                .startsWith("0")) {
                                              try {
                                                if (int.parse(
                                                        _seriesCountController
                                                            .text) <
                                                    10) {
                                                  int count = int.parse(
                                                      _seriesCountController
                                                          .text);
                                                  count++;
                                                  setState(() =>
                                                      _seriesCountController
                                                              .text =
                                                          count.toString());
                                                } else
                                                  setState(() =>
                                                      _seriesCountController
                                                          .text = "10");
                                              } catch (e) {
                                                setState(() =>
                                                    _seriesCountController
                                                        .text = "1");
                                              }
                                              _unique
                                                  ? setState(() => linesCount =
                                                      int.parse(
                                                          _seriesCountController
                                                              .text))
                                                  : setState(
                                                      () => linesCount = 1);
                                            }
                                          }
                                        : null,
                                    onLongPress: _seriesCountController.text !=
                                            "10"
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            setState(() =>
                                                _seriesCountController.text =
                                                    "10");
                                            _unique
                                                ? setState(() => linesCount =
                                                    int.parse(
                                                        _seriesCountController
                                                            .text))
                                                : setState(
                                                    () => linesCount = 1);
                                          }
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: null,
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: FlatButton(
                                  onPressed: validSet()
                                      ? () {
                                          FocusScope.of(context).unfocus();
                                          setState(() {
                                            _unique = !_unique;
                                          });
                                          changeSetCount();
                                        }
                                      : null,
                                  child: StrongrText(
                                    "Séries spécifiques",
                                    textAlign: TextAlign.end,
                                    size: 16,
                                    color: validSet()
                                        ? StrongrColors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              Switch(
                                activeColor: StrongrColors.blue,
                                value: _unique,
                                onChanged: validSet()
                                    ? (newValue) {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _unique = newValue;
                                        });
                                        changeSetCount();
                                      }
                                    : null,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 35,
                        ),
                        Container(
                          width: 135,
                          child: StrongrText(
                            "Répétitions",
                            size: 18,
                          ),
                        ),
                        Container(
                          width: 135,
                          child: StrongrText(
                            "Repos",
                            size: 18,
                          ),
                        ),
                        Container(
                          width: 35,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _unique && linesCount != 1,
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                  Center(
                    child: Container(
                      // color: Colors.blue,
                      height: _unique ? ScreenSize.height(context) / 3.8 : 65,
                      child: Visibility(
                        visible: _visibility,
                        child: Container(
                          // color: Colors.red[100],
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              for (int i = 0; i < linesCount; i++)
                                Container(
                                  height: 65,
                                  // color: Colors.green,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        height: 35,
                                        width: 35,
                                        // color: Colors.red,
                                        child: Center(
                                          child: Text(
                                            _unique
                                                ? linesCount == 1
                                                    ? "•"
                                                    : (i + 1).toString()
                                                : "•",
                                            style: TextStyle(
                                              color: StrongrColors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.blue,
                                        height: 50,
                                        child: StrongrRoundedContainer(
                                          width: 135,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                height: 35,
                                                width: 35,
                                                child: RawMaterialButton(
                                                  child: StrongrText(
                                                    "-",
                                                    color: StrongrColors.black,
                                                  ),
                                                  shape: CircleBorder(),
                                                  onPressed: null,
                                                  onLongPress: null,
                                                ),
                                              ),
                                              Flexible(
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  validator:
                                                      validateSeriesCount,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    LengthLimitingTextInputFormatter(
                                                        2),
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller: null,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                  ),
                                                  onSaved: (String value) {},
                                                  onChanged: (newValue) {},
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 35,
                                                child: RawMaterialButton(
                                                  child: StrongrText(
                                                    "+",
                                                    color: StrongrColors.black,
                                                  ),
                                                  shape: CircleBorder(),
                                                  onPressed: null,
                                                  onLongPress: null,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.green,
                                        height: 50,
                                        child: StrongrRoundedContainer(
                                          width: 135,
                                          content: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                height: 35,
                                                width: 35,
                                                child: RawMaterialButton(
                                                  child: StrongrText(
                                                    "-",
                                                    color: StrongrColors.black,
                                                  ),
                                                  shape: CircleBorder(),
                                                  onPressed: null,
                                                  onLongPress: null,
                                                ),
                                              ),
                                              Flexible(
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  validator:
                                                      validateSeriesCount,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <
                                                      TextInputFormatter>[
                                                    LengthLimitingTextInputFormatter(
                                                        2),
                                                    WhitelistingTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                  controller: null,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.all(5),
                                                  ),
                                                  onSaved: (String value) {},
                                                  onChanged: (newValue) {},
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                width: 35,
                                                child: RawMaterialButton(
                                                  child: StrongrText(
                                                    "+",
                                                    color: StrongrColors.black,
                                                  ),
                                                  shape: CircleBorder(),
                                                  onPressed: null,
                                                  onLongPress: null,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: null,
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.yellow,
                                        height: 35,
                                        width: 35,
                                        child: RawMaterialButton(
                                          child: Icon(
                                            Icons.tune,
                                            color: StrongrColors.black,
                                          ),
                                          onPressed: () {},
                                          shape: CircleBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _unique && linesCount != 1,
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Center(
          child: FloatingActionButton.extended(
            // heroTag: 'program_fab_' + widget.id.toString(),
            backgroundColor:
                validSet(strict: true) ? StrongrColors.blue : Colors.grey,
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: validSet() ? () {} : null,
            label: StrongrText(
              "Créer",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
