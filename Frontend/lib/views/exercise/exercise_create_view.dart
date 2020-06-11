import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/app_exercise/app_exercise_view.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';
import 'package:strongr/models/Equipment.dart';
import 'package:strongr/services/equipment_service.dart';

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
  int _serieCount,
      _repetitionCount1,
      _repetitionCount2,
      _repetitionCount3,
      _repetitionCount4,
      _repetitionCount5,
      _repetitionCount6,
      _repetitionCount7,
      _repetitionCount8,
      _repetitionCount9,
      _repetitionCount10;
  List<int> repCountList;
  Duration _restTime1,
      _restTime2,
      _restTime3,
      _restTime4,
      _restTime5,
      _restTime6,
      _restTime7,
      _restTime8,
      _restTime9,
      _restTime10;
  List<Duration> restTimeList;
  int linesCount = 1, setCount;
  String errorText = "";
  Future<List<Equipment>> futureEquipments;

  @override
  void initState() {
    super.initState();
    _serieCount = 1;
    _repetitionCount1 = _repetitionCount2 = _repetitionCount3 =
        _repetitionCount4 = _repetitionCount5 = _repetitionCount6 =
            _repetitionCount7 =
                _repetitionCount8 = _repetitionCount9 = _repetitionCount10 = 10;
    repCountList = List<int>();
    repCountList.addAll([
      _repetitionCount1,
      _repetitionCount2,
      _repetitionCount3,
      _repetitionCount4,
      _repetitionCount5,
      _repetitionCount6,
      _repetitionCount7,
      _repetitionCount8,
      _repetitionCount9,
      _repetitionCount10
    ]);
    _restTime1 = Duration(seconds: 60);
    _restTime2 = Duration(seconds: 60);
    _restTime3 = Duration(seconds: 60);
    _restTime4 = Duration(seconds: 60);
    _restTime5 = Duration(seconds: 60);
    _restTime6 = Duration(seconds: 60);
    _restTime7 = Duration(seconds: 60);
    _restTime8 = Duration(seconds: 60);
    _restTime9 = Duration(seconds: 60);
    _restTime10 = Duration(seconds: 60);
    restTimeList = List<Duration>();
    restTimeList.addAll([
      _restTime1,
      _restTime2,
      _restTime3,
      _restTime4,
      _restTime5,
      _restTime6,
      _restTime7,
      _restTime8,
      _restTime9,
      _restTime10
    ]);
    _visibility = !validSet();
    _unique = _validate = false;
    futureEquipments =
        EquipmentService.getEquipmentsOfAppExercise(idAppExercise: widget.id);
  }

  String validate(String value) {
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
    if (_key.currentState.validate()) {
      _key.currentState.save();
      setState(() {
        linesCount = _serieCount;
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
        ? !(_serieCount < 1 || _serieCount > 10)
        : !(_serieCount <= 1 || _serieCount > 10);
    return res;
  }

  void changeSetCount() {
    if (_unique == false) {
      linesCount = 1;
      // print(linesCount);
    } else if (_serieCount < 1 || _serieCount > 10) {
      linesCount = 0;
      // print(linesCount);
    } else {
      linesCount = _serieCount;
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
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Form(
              key: _key,
              autovalidate: _validate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StrongrText("Nom"),
                        Container(
                          height: 24,
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
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
                      hint: widget.name,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StrongrText("Équipement à utiliser"),
                        Container(
                          height: 24,
                          width: 24,
                          child: Icon(Icons.keyboard_arrow_right),
                        )
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    height: 80,
                    width: ScreenSize.width(context),
                    child: FutureBuilder(
                      future: futureEquipments,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == null) {
                            return Center(
                              child: StrongrText(
                                "Impossible d'afficher les équipements associés",
                                color: Colors.grey,
                              ),
                            );
                          } else if (snapshot.data.length == 0) {
                            return Center(
                              child: StrongrText(
                                "Aucun équipement associé",
                                color: Colors.grey,
                              ),
                            );
                          } else
                            return ListView(
                              scrollDirection: Axis.horizontal,
                              physics: BouncingScrollPhysics(),
                              // padding: EdgeInsets.all(10),
                              padding: EdgeInsets.only(left: 10, right: 10),
                              children: <Widget>[
                                for (final item in snapshot.data)
                                  StrongrRoundedContainer(
                                    width: ScreenSize.width(context) / 1.5,
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          // color: Colors.red,
                                          width:
                                              ScreenSize.width(context) / 2.8,
                                          child: Center(
                                            child: StrongrText(
                                              item.name,
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
                                          icon: Icon(
                                            Icons.info_outline,
                                            color: StrongrColors.blue,
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                    onPressed: () {},
                                  ),
                              ],
                            );
                        } else if (snapshot.hasError) {
                          return Text(
                            snapshot.error,
                            textAlign: TextAlign.center,
                          );
                        } else
                          return Container(
                            alignment: Alignment.center,
                            height: ScreenSize.height(context) / 1.25,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                StrongrColors.blue,
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StrongrText("Nombre de séries"),
                        Container(
                          height: 24,
                          width: 24,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // padding: EdgeInsets.all(10),
                    padding: EdgeInsets.only(left: 10, right: 10),
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
                                  // color: Colors.red,
                                  height: 35,
                                  width: 35,
                                  child: RawMaterialButton(
                                    child: StrongrText(
                                      "-",
                                      color:
                                          _serieCount <= 1 || _serieCount > 10
                                              ? Colors.grey
                                              : StrongrColors.black,
                                    ),
                                    shape: CircleBorder(),
                                    onPressed: _serieCount <= 1 ||
                                            _serieCount > 10
                                        ? null
                                        : _serieCount != 1
                                            ? () {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                try {
                                                  if (_serieCount > 1) {
                                                    int count = _serieCount;
                                                    count--;
                                                    setState(() =>
                                                        _serieCount = count);
                                                  } else
                                                    setState(
                                                        () => _serieCount = 1);
                                                } catch (e) {
                                                  setState(
                                                      () => _serieCount = 1);
                                                }
                                                _unique
                                                    ? setState(() =>
                                                        linesCount =
                                                            _serieCount)
                                                    : setState(
                                                        () => linesCount = 1);
                                              }
                                            : null,
                                    onLongPress: _serieCount != 1
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            setState(() => _serieCount = 1);
                                            _unique
                                                ? setState(() =>
                                                    linesCount = _serieCount)
                                                : setState(
                                                    () => linesCount = 1);
                                          }
                                        : null,
                                  ),
                                ),
                                Flexible(
                                  child: StrongrText(_serieCount.toString()),
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: RawMaterialButton(
                                    child: StrongrText(
                                      "+",
                                      color:
                                          _serieCount >= 10 || _serieCount < 1
                                              ? Colors.grey
                                              : StrongrColors.black,
                                    ),
                                    shape: CircleBorder(),
                                    onPressed: _serieCount >= 10 ||
                                            _serieCount < 1
                                        ? null
                                        : _serieCount != 10
                                            ? () {
                                                FocusScope.of(context)
                                                    .unfocus();
                                                try {
                                                  if (_serieCount < 10) {
                                                    int count = _serieCount;
                                                    count++;
                                                    setState(() =>
                                                        _serieCount = count);
                                                  } else
                                                    setState(
                                                        () => _serieCount = 10);
                                                } catch (e) {
                                                  setState(
                                                      () => _serieCount = 1);
                                                }
                                                _unique
                                                    ? setState(() =>
                                                        linesCount =
                                                            _serieCount)
                                                    : setState(
                                                        () => linesCount = 1);
                                              }
                                            : null,
                                    onLongPress: _serieCount != 10
                                        ? () {
                                            FocusScope.of(context).unfocus();
                                            setState(() => _serieCount = 10);
                                            _unique
                                                ? setState(() =>
                                                    linesCount = _serieCount)
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
                  Center(
                    child: Container(
                      // color: Colors.blue,
                      height: _unique
                          ? 65 * double.parse(linesCount.toString())
                          : 65,
                      child: Visibility(
                        visible: _visibility,
                        child: Container(
                          // color: Colors.red[100],
                          child: Column(
                            // physics: BouncingScrollPhysics(),
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
                                                  key: Key("rep_" +
                                                      (i + 1).toString()),
                                                  textAlign: TextAlign.center,
                                                  validator: validate,
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
                                                  key: Key("rest_" +
                                                      (i + 1).toString()),
                                                  textAlign: TextAlign.center,
                                                  validator: validate,
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
                                        height: 35,
                                        width: 35,
                                        child: RawMaterialButton(
                                          child: Icon(
                                            Icons.tune,
                                            color: StrongrColors.blue,
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
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        // color: Colors.red,
        height: 80,
        child: Stack(
          children: <Widget>[
            Divider(
              thickness: 0.5,
              color: Colors.grey,
              height: 1,
            ),
            Center(
              child: FloatingActionButton.extended(
                backgroundColor:
                    validSet(strict: true) ? StrongrColors.blue : Colors.grey,
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
                onPressed: validSet()
                    ? () {
                        sendToServer();
                      }
                    : null,
                label: StrongrText(
                  "Créer",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
