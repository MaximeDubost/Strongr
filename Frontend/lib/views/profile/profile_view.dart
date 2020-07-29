import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/models/User.dart';
import 'package:strongr/services/UserService.dart';
import 'package:strongr/utils/date_formater.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/utils/strings.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = UserService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profil"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.edit),
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: FutureBuilder(
        future: futureUser,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return buildMessage(NO_DATA_MESSAGE);
              break;
            case ConnectionState.done:
              if (snapshot.hasData) return buildProfile(snapshot.data);
              if (snapshot.hasError)
                return buildMessage(snapshot.error.toString());
              else
                return buildMessage(NULL_DATA_MESSAGE);
              break;
            default:
              return buildLoading();
          }
        },
      ),
      bottomNavigationBar: FutureBuilder(
        future: futureUser,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData)
                return Container(
                  height: 40,
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(8),
                  child: StrongrText(
                    "Inscrit depuis le " +
                        DateFormater.format(snapshot.data.signedDate),
                    size: 16,
                    color: Colors.grey,
                    textAlign: TextAlign.start,
                  ),
                );
              else
                return SizedBox();
              break;
            default:
              return SizedBox();
          }
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(StrongrColors.blue),
      ),
    );
  }

  Widget buildMessage(String message) {
    return Center(
      child: StrongrText(
        message,
      ),
    );
  }

  Widget buildProfile(dynamic data) {
    return Container(
      padding: EdgeInsets.all(8),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child:
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: StrongrText(
                      data.firstName + " " + data.lastName,
                      size: 22,
                      textAlign: TextAlign.center,
                      // bold: true,
                    ),
                  ),
                  StrongrText(
                    data.username,
                    size: 16,
                    color: StrongrColors.black,
                    textAlign: TextAlign.start,
                  ),
                  StrongrText(
                    DateFormater.age(data.birthdate).toString() +
                        (DateFormater.age(data.birthdate) < 2 ? " an" : " ans"),
                    size: 16,
                    color: StrongrColors.black,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              // SizedBox(
              //   height: 80,
              //   width: 80,
              //   child: CircleAvatar(
              //     /// https://avatars.dicebear.com/
              //     backgroundColor: StrongrColors.black,
              //     foregroundColor: Colors.white,
              //     child: Icon(
              //       Icons.image,
              //       size: 50,
              //     ),
              //   ),
              // ),
              //   ],
              // ),
            ),
          ),
          Container(
            // color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Container(
                    // color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.fitness_center,
                                  size: 20,
                                  color: int.parse(data.exerciseCount) == 0
                                      ? Colors.grey
                                      : StrongrColors.black,
                                ),
                              ),
                              StrongrText(
                                (int.parse(data.exerciseCount) == 0
                                        ? "Aucun"
                                        : data.exerciseCount) +
                                    (int.parse(data.exerciseCount) < 2
                                        ? " exercice"
                                        : " exercices"),
                                color: int.parse(data.exerciseCount) == 0
                                    ? Colors.grey
                                    : StrongrColors.black,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: int.parse(data.sessionCount) == 0
                                      ? Colors.grey
                                      : StrongrColors.black,
                                ),
                              ),
                              StrongrText(
                                (int.parse(data.sessionCount) == 0
                                        ? "Aucune"
                                        : data.sessionCount) +
                                    (int.parse(data.sessionCount) < 2
                                        ? " séance"
                                        : " séances"),
                                color: int.parse(data.sessionCount) == 0
                                    ? Colors.grey
                                    : StrongrColors.black,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.date_range,
                                  size: 20,
                                  color: int.parse(data.programCount) == 0
                                      ? Colors.grey
                                      : StrongrColors.black,
                                ),
                              ),
                              StrongrText(
                                (int.parse(data.programCount) == 0
                                        ? "Aucun"
                                        : data.programCount) +
                                    (int.parse(data.programCount) < 2
                                        ? " programme"
                                        : " programmes"),
                                color: int.parse(data.programCount) == 0
                                    ? Colors.grey
                                    : StrongrColors.black,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 120,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: StrongrColors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            StrongrText(
                              "Poids :",
                              color: Colors.white,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                StrongrText(
                                  data.weight ?? "73.1 kg",
                                  color: Colors.white,
                                ),
                                data.weight != null
                                    ? StrongrText(
                                        "(" +
                                            data.weight.toStringAsFixed(1) +
                                            ")",
                                        color: Colors.white,
                                      )
                                    : SizedBox(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 120,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: StrongrColors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            StrongrText(
                              "Volume moyen exercices :",
                              size: 16,
                              color: Colors.white,
                            ),
                            StrongrText(
                              "0",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 120,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: StrongrColors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            StrongrText(
                              "Volume moyen séances :",
                              size: 16,
                              color: Colors.white,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                StrongrText(
                                  data.weight ?? "0",
                                  color: Colors.white,
                                ),
                                data.weight != null
                                    ? StrongrText(
                                        "(" +
                                            data.weight.toStringAsFixed(1) +
                                            ")",
                                        color: Colors.white,
                                      )
                                    : SizedBox(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 120,
                      margin: EdgeInsets.only(left: 5, right: 5),
                      decoration: BoxDecoration(
                        color: StrongrColors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            StrongrText(
                              "Volume moyen programmes :",
                              size: 16,
                              color: Colors.white,
                            ),
                            StrongrText(
                              "0",
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
