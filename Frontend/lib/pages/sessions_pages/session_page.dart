import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/pages/exercises_pages/exercise_page.dart';

import '../../main.dart';

class SessionPage extends StatefulWidget {
  final String _sessionName;

  SessionPage(this._sessionName);

  @override
  State createState() => SessionPageState();
}

class SessionPageState extends State<SessionPage> {
  List<String> _exercisesOfSession = ["Exercice 1", "Exercice 2", "Exercice 3"];
  List<String> _oldList = ["Exercice 1", "Exercice 2", "Exercice 3"];
  bool _isEmptyList = false, _isEditMode = false;

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
        actions: <Widget>[
          IconButton(
            icon: _isEditMode
                ? Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
            color: Colors.white,
            onPressed:
                _isEditMode ? () {setState(() { _isEditMode = false; _oldList = _exercisesOfSession; /** TODO: Récupérer tous les titles de la nouvelle liste ordonnée et l'attribuer à _exercisesOfSession*/ });} : () => setState(() => _isEditMode = true),
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
                    for (final item in _exercisesOfSession)
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
                        trailing: IconButton(
                          icon: Icon(
                            _isEditMode ? Icons.reorder : Icons.help_outline,
                            color: _isEditMode ? Colors.grey : DarkColor,
                          ),
                          onPressed: _isEditMode ? null : () => Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (BuildContext context) =>
                                      ExercisePage(item))),
                        ),
                        onTap: () {},
                        onLongPress: _isEditMode ? null : () {},
                      ),
                  ],
                  onReorder: _isEditMode ? (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > _exercisesOfSession.length) newIndex = _exercisesOfSession.length;
                      if (oldIndex < newIndex) newIndex--;
                      String item = _exercisesOfSession[oldIndex];
                      _exercisesOfSession.remove(item);
                      _exercisesOfSession.insert(newIndex, item);
                    });
                  } : (oldValue, newValue) {},
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
                      onPressed: _isEditMode ? () {} : () {},
                      child: Text(
                        _isEditMode
                            ? "Supprimer la séance"
                            : "Démarrer la séance",
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
