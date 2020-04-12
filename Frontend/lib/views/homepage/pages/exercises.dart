import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';
import 'package:strongr/widgets/strongr_text.dart';

class Exercises extends StatefulWidget {
  @override
  _ExercisesState createState() => _ExercisesState();
}

class _ExercisesState extends State<Exercises> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 60,
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              // color: Colors.grey,
              child: TextField(
                style: TextStyle(color: StrongrColors.black, fontFamily: 'Futura', fontSize: 18),
                inputFormatters:[
                  LengthLimitingTextInputFormatter(100),
                ],
                controller: null,
                onChanged: (newValue) {},
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search, color: StrongrColors.blue),
                  hintText: "Rechercher un exercice...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: StrongrColors.blue,
                      width: 1.5
                    )
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 100, right: 100),
            height: 1,
            width: 100,
            color: Colors.grey[350],
          ),
          for (int i = 1; i <= 10; i++)
            Container(
              padding: EdgeInsets.all(5),
              height: 90,
              child: StrongrRoundedContainer(
                content: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      StrongrText(
                        "Exercice " + i.toString(), bold: true,
                      ),
                      StrongrText("Muscle(s) ciblé(s)")
                    ],
                  ),
                ),
                onPressed: () {},
              ),
            ),
        ],
      ),
    );
  }
}
