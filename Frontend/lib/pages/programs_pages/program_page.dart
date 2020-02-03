import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/UI/dialogs/custom_dialog.dart';

import '../../main.dart';
import 'add_session_page.dart';

class ProgramPage extends StatefulWidget {
  final String _sessionName;

  ProgramPage(this._sessionName);

  @override
  State createState() => ProgramPageState();
}

class ProgramPageState extends State<ProgramPage> {
  List<String> _sessionsOfProgram = [
    "Première séance",
    "Deuxième séance",
    "Troisième séance",
    "Quatrième séance",
    "Cinquième séance"
  ];
  // List<String> _oldList = ["Première séance", "Deuxième séance", "Troisième séance", "Quatrième séance", "Cinquième séance"];
  bool _isEditMode = false;
  bool _isEmptyList = false;

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
    _isEmptyList = _sessionsOfProgram.length == 0 ? true : false;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: _isEditMode
              ? Icon(
                  Icons.close,
                  color: Colors.white,
                )
              : Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: _isEditMode
              ? () {} // () {setState(() { _isEditMode = false; _sessionsOfProgram = _oldList;});}
              : () => Navigator.of(context).pop(),
        ),
        title: Text(widget._sessionName),
        actions: _isEditMode
            ? <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        _isEditMode = false;
                        // _oldList = _sessionsOfProgram;
                        /** Récupérer tous les titles de la nouvelle liste ordonnée et l'attribuer à _sessionsOfProgram */
                      });
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (BuildContext context) => AddSessionPage()));
                    }),
                IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  onPressed: _isEditMode
                      ? () {
                          setState(() {
                            _isEditMode = false;
                            // _oldList = _sessionsOfProgram;
                            /** Récupérer tous les titles de la nouvelle liste ordonnée et l'attribuer à _sessionsOfProgram */
                          });
                        }
                      : () => setState(() => _isEditMode = true),
                ),
              ]
            : <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  onPressed: _isEditMode
                      ? () {
                          setState(() {
                            _isEditMode = false;
                            // _oldList = _sessionsOfProgram;
                            /** Récupérer tous les titles de la nouvelle liste ordonnée et l'attribuer à _sessionsOfProgram*/
                          });
                        }
                      : () => setState(() => _isEditMode = true),
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
                    for (final item in _sessionsOfProgram)
                      ListTile(
                        key: ValueKey(item),
                        // leading: Icon(Icons.add),
                        leading: Text(
                          (_sessionsOfProgram.indexOf(item) + 1).toString(),
                          style: TextStyle(
                              color: SecondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          item,
                          //textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Calibri',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        subtitle: Text("𝑥 exercice(s)",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Calibri',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey)),
                        trailing: IconButton(
                            icon: Icon(
                              _isEditMode ? Icons.reorder : null,
                              color: _isEditMode ? Colors.grey : DarkColor,
                            ),
                            onPressed: () {}),
                        onTap: () {},
                        onLongPress: _isEditMode ? null : () {},
                      ),
                  ],
                  onReorder: _isEditMode
                      ? (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > _sessionsOfProgram.length)
                              newIndex = _sessionsOfProgram.length;
                            if (oldIndex < newIndex) newIndex--;
                            String item = _sessionsOfProgram[oldIndex];
                            _sessionsOfProgram.remove(item);
                            _sessionsOfProgram.insert(newIndex, item);
                          });
                        }
                      : (oldValue, newValue) {},
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
                    color: _isEditMode
                        ? Colors.red
                        : Color.fromRGBO(40, 140, 100, 1.0),
                    disabledColor: Colors.grey,
                    onPressed: _isEmptyList
                        ? null
                        : _isEditMode
                            ? () {
                                showDialog(
                                  context: context,
                                  // barrierDismissible: false,
                                  builder: (context) {
                                    return CustomDialog(
                                        "Supprimer le programme ?",
                                        "Les séances ne seront pas supprimées.",
                                        "Supprimer le programme",
                                        "Annuler");
                                  },
                                );
                              }
                            : () {},
                    child: Text(
                      _isEditMode
                          ? "Supprimer le programme"
                          : "Plannifier le programme",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Calibri',
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      // side: BorderSide(color: SecondaryColor)
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
