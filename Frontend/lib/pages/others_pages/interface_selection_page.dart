import 'package:flutter/material.dart';

class InterfaceSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
              child: Material(
                color: Color.fromRGBO(40, 140, 100, 1.0),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.white, width: 5.0),
                      // ),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Coach",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Material(
              color: Color.fromRGBO(20, 120, 80, 1.0),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    "Vous êtes...",
                    style: TextStyle(
                      fontSize: 18, 
                      fontFamily: 'Calibri',
                      color: Colors.white,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                color: Color.fromRGBO(0, 100, 60, 1.0),
                child: InkWell(
                  onTap: () {},
                  child: Center(
                    child: Container(
                      // decoration: BoxDecoration(
                      //   border: Border.all(color: Colors.white, width: 5.0),
                      // ),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Athlète",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
