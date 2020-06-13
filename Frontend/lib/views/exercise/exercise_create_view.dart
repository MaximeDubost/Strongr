import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/app_exercise/app_exercise_view.dart';
import 'package:strongr/widgets/dialogs/repetition_count_dialog.dart';
import 'package:strongr/widgets/dialogs/rest_time_dialog.dart';
import 'package:strongr/widgets/dialogs/set_count_dialog.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';
import 'package:strongr/models/Equipment.dart';
import 'package:strongr/services/equipment_service.dart';
import 'package:strongr/utils/time_formater.dart';

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
  bool _specific, _validate, _visibility;
  TextEditingController exerciseNameController;
  int selectedEquipmentId,
      setCount,
      linesCount,
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
  String errorText = "";
  Future<List<Equipment>> futureEquipments;
  List<bool> equipmentSelection;

  @override
  void initState() {
    super.initState();
    exerciseNameController = TextEditingController(text: "");
    setCount = 1;
    linesCount = 1;
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
    _restTime1 = Duration(seconds: 90);
    _restTime2 = Duration(seconds: 90);
    _restTime3 = Duration(seconds: 90);
    _restTime4 = Duration(seconds: 90);
    _restTime5 = Duration(seconds: 90);
    _restTime6 = Duration(seconds: 90);
    _restTime7 = Duration(seconds: 90);
    _restTime8 = Duration(seconds: 90);
    _restTime9 = Duration(seconds: 90);
    _restTime10 = Duration(seconds: 90);
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
    _specific = _validate = false;
    futureEquipments =
        EquipmentService.getEquipmentsOfAppExercise(idAppExercise: widget.id);
    equipmentSelection = List<bool>();
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
        linesCount = setCount;
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
        ? !(setCount < 1 || setCount > 10)
        : !(setCount <= 1 || setCount > 10);
    return res;
  }

  /// Change le nombre de ligne affichées.
  void changeLineCount() {
    if (_specific == false) {
      linesCount = 1;
      // print(linesCount);
    } else if (setCount < 1 || setCount > 10) {
      linesCount = 0;
      // print(linesCount);
    } else {
      linesCount = setCount;
      // print(linesCount);
    }
  }

  /// Retourne le nombre de répétition de la série [i] + 1.
  int repCountOfRow(int i) {
    switch (i + 1) {
      case 1:
        return _repetitionCount1;
      case 2:
        return _repetitionCount2;
      case 3:
        return _repetitionCount3;
      case 4:
        return _repetitionCount4;
      case 5:
        return _repetitionCount5;
      case 6:
        return _repetitionCount6;
      case 7:
        return _repetitionCount7;
      case 8:
        return _repetitionCount8;
      case 9:
        return _repetitionCount9;
      case 10:
        return _repetitionCount10;
      default:
        return 0;
    }
  }

  /// Retourne le temps de repos de la série [i] + 1.
  Duration restTimeOfRow(int i) {
    switch (i + 1) {
      case 1:
        return _restTime1;
      case 2:
        return _restTime2;
      case 3:
        return _restTime3;
      case 4:
        return _restTime4;
      case 5:
        return _restTime5;
      case 6:
        return _restTime6;
      case 7:
        return _restTime7;
      case 8:
        return _restTime8;
      case 9:
        return _restTime9;
      case 10:
        return _restTime10;
      default:
        return Duration(seconds: 0);
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
                      controller: exerciseNameController,
                      // onChanged: (value) => print(exerciseNameController.text),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(30),
                      ],
                      hint: widget.name,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  FlatButton(
                    onPressed: null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StrongrText("Équipement à utiliser"),
                        Container(
                          height: 24,
                          width: 24,
                          // child: Icon(Icons.keyboard_arrow_right),
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
                          } else {
                            for (int i = 0; i < snapshot.data.length; i++)
                              equipmentSelection.add(false);
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
                                    borderColor: equipmentSelection[
                                            snapshot.data.indexOf(item)]
                                        ? StrongrColors.blue80
                                        : StrongrColors.greyD,
                                    borderWidth: equipmentSelection[
                                            snapshot.data.indexOf(item)]
                                        ? 2
                                        : 1,
                                    onPressed: () {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        for (int i = 0;
                                            i < equipmentSelection.length;
                                            i++) equipmentSelection[i] = false;
                                        equipmentSelection[
                                            snapshot.data.indexOf(item)] = true;
                                        selectedEquipmentId = item.id;
                                      });
                                    },
                                  ),
                              ],
                            );
                          }
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    // color: Colors.red,
                                    height: 35,
                                    width: 35,
                                    child: RawMaterialButton(
                                      child: StrongrText(
                                        "-",
                                        color: setCount <= 1 || setCount > 10
                                            ? Colors.grey
                                            : StrongrColors.black,
                                      ),
                                      shape: CircleBorder(),
                                      onPressed: setCount <= 1 || setCount > 10
                                          ? null
                                          : setCount != 1
                                              ? () {
                                                  FocusScope.of(context)
                                                      .unfocus();

                                                  try {
                                                    if (setCount > 1) {
                                                      int count = setCount;
                                                      count--;
                                                      setState(() =>
                                                          setCount = count);
                                                    } else
                                                      setState(
                                                          () => setCount = 1);
                                                  } catch (e) {
                                                    setState(
                                                        () => setCount = 1);
                                                  }
                                                  _specific
                                                      ? setState(() =>
                                                          linesCount = setCount)
                                                      : setState(
                                                          () => linesCount = 1);
                                                }
                                              : null,
                                      onLongPress: setCount != 1
                                          ? () {
                                              FocusScope.of(context).unfocus();
                                              setState(() => setCount = 1);
                                              _specific
                                                  ? setState(() =>
                                                      linesCount = setCount)
                                                  : setState(
                                                      () => linesCount = 1);
                                            }
                                          : null,
                                    ),
                                  ),
                                  Flexible(
                                    child: StrongrText(setCount.toString()),
                                  ),
                                  Container(
                                    height: 35,
                                    width: 35,
                                    child: RawMaterialButton(
                                      child: StrongrText(
                                        "+",
                                        color: setCount >= 10 || setCount < 1
                                            ? Colors.grey
                                            : StrongrColors.black,
                                      ),
                                      shape: CircleBorder(),
                                      onPressed: setCount >= 10 || setCount < 1
                                          ? null
                                          : setCount != 10
                                              ? () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (_specific &&
                                                      setCount == 1)
                                                    setState(() {
                                                      _repetitionCount10 = _repetitionCount9 =
                                                          _repetitionCount8 = _repetitionCount7 =
                                                              _repetitionCount6 =
                                                                  _repetitionCount5 =
                                                                      _repetitionCount4 =
                                                                          _repetitionCount3 =
                                                                              _repetitionCount2 = _repetitionCount1;
                                                      _restTime10 = _restTime9 =
                                                          _restTime8 = _restTime7 =
                                                              _restTime6 = _restTime5 =
                                                                  _restTime4 =
                                                                      _restTime3 =
                                                                          _restTime2 =
                                                                              _restTime1;
                                                    });
                                                  try {
                                                    if (setCount < 10) {
                                                      int count = setCount;
                                                      count++;
                                                      setState(() =>
                                                          setCount = count);
                                                    } else
                                                      setState(
                                                          () => setCount = 10);
                                                  } catch (e) {
                                                    setState(
                                                        () => setCount = 1);
                                                  }
                                                  _specific
                                                      ? setState(() =>
                                                          linesCount = setCount)
                                                      : setState(
                                                          () => linesCount = 1);
                                                }
                                              : null,
                                      onLongPress: setCount != 10
                                          ? () {
                                              FocusScope.of(context).unfocus();
                                              if (_specific && setCount == 1)
                                                setState(() {
                                                  _repetitionCount10 = _repetitionCount9 =
                                                      _repetitionCount8 = _repetitionCount7 =
                                                          _repetitionCount6 = _repetitionCount5 =
                                                              _repetitionCount4 =
                                                                  _repetitionCount3 =
                                                                      _repetitionCount2 =
                                                                          _repetitionCount1;
                                                  _restTime10 = _restTime9 =
                                                      _restTime8 = _restTime7 =
                                                          _restTime6 = _restTime5 =
                                                              _restTime4 =
                                                                  _restTime3 =
                                                                      _restTime2 =
                                                                          _restTime1;
                                                });
                                              setState(() => setCount = 10);
                                              _specific
                                                  ? setState(() =>
                                                      linesCount = setCount)
                                                  : setState(
                                                      () => linesCount = 1);
                                            }
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                showDialog(
                                  context: context,
                                  builder: (context) => SetCountDialog(
                                    setCount: setCount,
                                  ),
                                ).then((newSetCount) {
                                  if (newSetCount != null)
                                    setState(() => setCount = newSetCount);
                                  _specific
                                      ? setState(() => linesCount = setCount)
                                      : setState(() => linesCount = 1);
                                });
                              }),
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
                                            _specific = !_specific;
                                          });
                                          if (_specific)
                                            setState(() {
                                              _repetitionCount10 = _repetitionCount9 =
                                                  _repetitionCount8 = _repetitionCount7 =
                                                      _repetitionCount6 = _repetitionCount5 =
                                                          _repetitionCount4 =
                                                              _repetitionCount3 =
                                                                  _repetitionCount2 =
                                                                      _repetitionCount1;
                                              _restTime10 = _restTime9 =
                                                  _restTime8 = _restTime7 =
                                                      _restTime6 = _restTime5 =
                                                          _restTime4 =
                                                              _restTime3 =
                                                                  _restTime2 =
                                                                      _restTime1;
                                            });
                                          changeLineCount();
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
                                value: _specific,
                                onChanged: validSet()
                                    ? (newValue) {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _specific = newValue;
                                        });
                                        if (_specific)
                                          setState(() {
                                            _repetitionCount10 = _repetitionCount9 =
                                                _repetitionCount8 = _repetitionCount7 =
                                                    _repetitionCount6 = _repetitionCount5 =
                                                        _repetitionCount4 =
                                                            _repetitionCount3 =
                                                                _repetitionCount2 =
                                                                    _repetitionCount1;
                                            _restTime10 = _restTime9 =
                                                _restTime8 = _restTime7 =
                                                    _restTime6 = _restTime5 =
                                                        _restTime4 =
                                                            _restTime3 =
                                                                _restTime2 =
                                                                    _restTime1;
                                          });
                                        changeLineCount();
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
                      height: _specific
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
                                            _specific
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
                                        // color: Colors.green,
                                        height: 50,
                                        child: StrongrRoundedContainer(
                                            width: 135,
                                            content: StrongrText(
                                              repCountOfRow(i) != 0
                                                  ? repCountOfRow(i).toString()
                                                  : "",
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    RepetitionCountDialog(
                                                  repetitionCount:
                                                      repCountOfRow(i),
                                                ),
                                              ).then((repetitionCount) {
                                                if (repetitionCount != null)
                                                  switch (i + 1) {
                                                    case 1:
                                                      setState(() =>
                                                          _repetitionCount1 =
                                                              repetitionCount);
                                                      break;
                                                    case 2:
                                                      setState(() =>
                                                          _repetitionCount2 =
                                                              repetitionCount);
                                                      break;
                                                    case 3:
                                                      setState(() =>
                                                          _repetitionCount3 =
                                                              repetitionCount);
                                                      break;
                                                    case 4:
                                                      setState(() =>
                                                          _repetitionCount4 =
                                                              repetitionCount);
                                                      break;
                                                    case 5:
                                                      setState(() =>
                                                          _repetitionCount5 =
                                                              repetitionCount);
                                                      break;
                                                    case 6:
                                                      setState(() =>
                                                          _repetitionCount6 =
                                                              repetitionCount);
                                                      break;
                                                    case 7:
                                                      setState(() =>
                                                          _repetitionCount7 =
                                                              repetitionCount);
                                                      break;
                                                    case 8:
                                                      setState(() =>
                                                          _repetitionCount8 =
                                                              repetitionCount);
                                                      break;
                                                    case 9:
                                                      setState(() =>
                                                          _repetitionCount9 =
                                                              repetitionCount);
                                                      break;
                                                    case 10:
                                                      setState(() =>
                                                          _repetitionCount10 =
                                                              repetitionCount);
                                                      break;
                                                  }
                                              });
                                            }),
                                      ),
                                      Container(
                                        // color: Colors.blue,
                                        height: 50,
                                        child: StrongrRoundedContainer(
                                            width: 135,
                                            content: StrongrText(
                                              restTimeOfRow(i) !=
                                                      Duration(seconds: 0)
                                                  ? TimeFormater.getDuration(
                                                          restTimeOfRow(i))
                                                      .toString()
                                                  : "",
                                            ),
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    RestTimeDialog(
                                                  restTime: restTimeOfRow(i),
                                                ),
                                              ).then((restTime) {
                                                if (restTime != null)
                                                  switch (i + 1) {
                                                    case 1:
                                                      setState(() =>
                                                          _restTime1 =
                                                              restTime);
                                                      break;
                                                    case 2:
                                                      setState(() =>
                                                          _restTime2 =
                                                              restTime);
                                                      break;
                                                    case 3:
                                                      setState(() =>
                                                          _restTime3 =
                                                              restTime);
                                                      break;
                                                    case 4:
                                                      setState(() =>
                                                          _restTime4 =
                                                              restTime);
                                                      break;
                                                    case 5:
                                                      setState(() =>
                                                          _restTime5 =
                                                              restTime);
                                                      break;
                                                    case 6:
                                                      setState(() =>
                                                          _restTime6 =
                                                              restTime);
                                                      break;
                                                    case 7:
                                                      setState(() =>
                                                          _restTime7 =
                                                              restTime);
                                                      break;
                                                    case 8:
                                                      setState(() =>
                                                          _restTime8 =
                                                              restTime);
                                                      break;
                                                    case 9:
                                                      setState(() =>
                                                          _restTime9 =
                                                              restTime);
                                                      break;
                                                    case 10:
                                                      setState(() =>
                                                          _restTime10 =
                                                              restTime);
                                                      break;
                                                  }
                                              });
                                            }),
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
                onPressed: validSet(strict: true)
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
