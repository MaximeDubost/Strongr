import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/UI/dialogs/custom_dialog.dart';
import 'package:strongr/pages/exercises_pages/exercise_page.dart';

import '../../main.dart';
import 'add_exercise_page.dart';

class SessionPage extends StatefulWidget {
  final String _sessionName;

  SessionPage(this._sessionName);

  @override
  State createState() => SessionPageState();
}

class SessionPageState extends State<SessionPage> {
  List<String> _exercisesOfSession = [
    "Premier exercice",
    "Deuxième exercice",
    "Troisième exercice",
    "Quatrième exercice"
  ];
  // List<String> _oldList = ["Premier exercice", "Deuxième exercice", "Troisième exercice", "Quatrième exercice"];
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
    _isEmptyList = _exercisesOfSession.length == 0 ? true : false;

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
              ? () {} // () {setState(() { _isEditMode = false; _exercisesOfSession = _oldList;});}
              : () => Navigator.of(context).pop(),
        ),
        title: Text(widget._sessionName),
        backgroundColor: PrimaryColor,
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
                        // _oldList = _exercisesOfSession;
                        /** Récupérer tous les titles de la nouvelle liste ordonnée et l'attribuer à _exercisesOfSession */
                      });
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (BuildContext context) =>
                              AddExercisePage()));
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
                            // _oldList = _exercisesOfSession;
                            /** Récupérer tous les titles de la nouvelle liste ordonnée et l'attribuer à _exercisesOfSession */
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
                            // _oldList = _exercisesOfSession;
                            /** Récupérer tous les titles de la nouvelle liste ordonnée et l'attribuer à _exercisesOfSession*/
                          });
                        }
                      : () => setState(() => _isEditMode = true),
                ),
              ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                //color: Colors.indigo,
                child: ReorderableListView(
                  children: <Widget>[
                    for (final item in _exercisesOfSession)
                      ListTile(
                        key: ValueKey(item),
                        leading: Text(
                          (_exercisesOfSession.indexOf(item) + 1).toString(),
                          style: TextStyle(
                              color: SecondaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        // leading: Icon(Icons.add),
                        title: Text(
                          item,
                          //textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Calibri',
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        subtitle: Text("4 séries, répétitions et repos variés",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Calibri',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey)),
                        trailing: IconButton(
                          icon: Icon(
                            _isEditMode ? Icons.reorder : Icons.help_outline,
                            color: _isEditMode ? Colors.grey : SecondaryColor,
                          ),
                          onPressed: _isEditMode
                              ? null
                              : () => Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          ExercisePage(exerciseName: item))),
                        ),
                        onTap: () {},
                        onLongPress: _isEditMode ? null : () {},
                      ),
                  ],
                  onReorder: _isEditMode
                      ? (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > _exercisesOfSession.length)
                              newIndex = _exercisesOfSession.length;
                            if (oldIndex < newIndex) newIndex--;
                            String item = _exercisesOfSession[oldIndex];
                            _exercisesOfSession.remove(item);
                            _exercisesOfSession.insert(newIndex, item);
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
                                        "Supprimer la séance ?",
                                        "Les programmes comprenant cette séance ne seront pas supprimés.",
                                        "Supprimer la séance",
                                        "Annuler",
                                        validateAction: () {},
                                        cancelAction: () => Navigator.of(context).pop());
                                  },
                                );
                              }
                            : () {},
                    child: Text(
                      _isEditMode
                          ? "Supprimer la séance"
                          : "Démarrer la séance",
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
