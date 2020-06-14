import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_textformfield.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SessionCreateView extends StatefulWidget {
  _SessionCreateViewState createState() => _SessionCreateViewState();
}

class _SessionCreateViewState extends State<SessionCreateView> {
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
        title: Text("Nouvelle séance"),
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
                      hint: "Séance perso.",
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: StrongrText("Exercices"),
                  ),
                  // Container(
                  //   // color: Colors.red,
                  //   height: 50,
                  //   child: Center(
                  //     child: StrongrText(
                  //       "Aucun exercice",
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
