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
  bool _validate;
  TextEditingController _seriesCountController;
  int linesCount = 1;
  String errorText = "";

  @override
  void initState() {
    super.initState();
    _seriesCountController = TextEditingController(text: "1");
    _validate = false;
  }

  @override
  void dispose() {
    super.dispose();
    _seriesCountController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(),
        title: Text("Nouveau programme"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.edit),
        //     onPressed: () {},
        //   )
        // ],
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
                  Container(
                    padding: EdgeInsets.all(10),
                    child: StrongrText("Nom"),
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
                      hint: "Programme perso.",
                      textInputType: TextInputType.text,
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
                                    "Brûleur de calories",
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
                  // Container(
                  //   // color: Colors.red,
                  //   height: 50,
                  //   child: Center(
                  //     child: StrongrText(
                  //       "Aucune séance",
                  //       color: Colors.grey,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: ScreenSize.width(context),
                    child: Center(
                      child: FloatingActionButton.extended(
                        heroTag: "add_fab",
                        backgroundColor: StrongrColors.black,
                        onPressed: () {},
                        label: StrongrText("Ajouter", color: Colors.white,),
                        icon: Icon(Icons.add, color: Colors.white,),
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
          ],
        ),
      ),
    );
  }
}
