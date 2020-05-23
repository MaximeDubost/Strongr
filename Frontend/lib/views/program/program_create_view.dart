import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ProgramCreateView extends StatefulWidget {
  _ProgramCreateViewState createState() => _ProgramCreateViewState();
}

class _ProgramCreateViewState extends State<ProgramCreateView> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _unique, _validate;
  TextEditingController _seriesCountController;
  int linesCount = 1;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    _seriesCountController = TextEditingController(text: "1");
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
        title: Text("Nouveau programme"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
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
                      hint: "Nom de votre programme (facultatif)",
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    // color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: StrongrText("Objectif"),
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
                                    "Perte de poids",
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
                                    "Sèche",
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
                                    "Prise de masse",
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
                                    "Gain de force",
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
                                    "Gain d'endurance",
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
                                    "Gain d'explosivité",
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
                    child: StrongrText("Séances"),
                  ),
                  Container(
                    // color: Colors.red,
                    height: 50,
                    child: Center(
                      child: StrongrText(
                        "Aucune séance",
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: ScreenSize.width(context),
                    child: Center(
                      child: FloatingActionButton(
                        heroTag: "add_fab",
                        mini: true,
                        backgroundColor: StrongrColors.blue,
                        onPressed: () {},
                        child: Icon(Icons.add, color: Colors.white),
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
        height: 80,
        child: Center(
          child: FloatingActionButton.extended(
            // heroTag: 'program_fab_' + widget.id.toString(),
            backgroundColor: Colors.grey,
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: null,
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
