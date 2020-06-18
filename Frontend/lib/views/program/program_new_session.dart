import 'package:flutter/material.dart';
import 'package:strongr/views/session/sessions_view.dart';

class ProgramNewSessionView extends StatefulWidget {
  _ProgramNewSessionViewState createState() => _ProgramNewSessionViewState();
}

class _ProgramNewSessionViewState extends State<ProgramNewSessionView> {
  // final List<String> popupMenuItems = ["Filtres"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(),
        title: Text("Ajouter une séance"),
        // actions: <Widget>[
        //   PopupMenuButton<String>(
        //     tooltip: "Menu",
        //     onSelected: (value) async {
        //       switch (value) {
        //         case "Filtres":
        //           break;
        //       }
        //     },
        //     itemBuilder: (BuildContext context) {
        //       return popupMenuItems.map(
        //         (String choice) {
        //           return PopupMenuItem<String>(
        //             value: choice,
        //             child: Text(choice),
        //           );
        //         },
        //       ).toList();
        //     },
        //   ),
        // ],
      ),
      body: SessionsView(fromProgramCreation: true)
    );
  }
}
