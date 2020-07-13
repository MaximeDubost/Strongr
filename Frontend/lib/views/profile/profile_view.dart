import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/models/User.dart';
import 'package:strongr/services/UserService.dart';
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
        future: futureUser,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return buildMessage(NO_DATA_MESSAGE);
              break;
            case ConnectionState.done:
              if (snapshot.hasData)
                buildProfile(snapshot.data);
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
          Padding(
            padding: EdgeInsets.all(8),
            child: StrongrText(
              data.username,
              size: 24,
              textAlign: TextAlign.start,
              bold: true,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    StrongrText("Inscrit depuis le " + data.signedDate),
                    StrongrText(
                      data.exerciseCount == 0
                          ? "Aucun"
                          : data.exerciseCount + data.exerciseCount as int < 2
                              ? " exercice"
                              : " exercices",
                    ),
                    StrongrText(
                      data.sessionCount == 0
                          ? "Aucune"
                          : data.sessionCount + data.sessionCount as int < 2
                              ? " séance"
                              : " séances",
                    ),
                    StrongrText(
                      data.programCount == 0
                          ? "Aucun"
                          : data.programCount + data.programCount as int < 2
                              ? " programme"
                              : " programmes",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    /// https://avatars.dicebear.com/
                    backgroundColor: StrongrColors.black,
                    foregroundColor: Colors.white,
                    child: Icon(
                      Icons.image,
                      size: 50,
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
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
                                "72.5 kg",
                                color: Colors.white,
                              ),
                              StrongrText(
                                "(159.8 lbs)",
                                color: Colors.white,
                              ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                StrongrText(
                                  "Volume moyen :",
                                  color: Colors.white,
                                ),
                                StrongrText(
                                  "???",
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 32,
                            child: RawMaterialButton(
                              shape: CircleBorder(),
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
