import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/models/SessionType.dart';
import 'package:strongr/services/SessionService.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class SessionTypeView extends StatefulWidget {
  final int id;
  final String name;

  SessionTypeView({
    this.id,
    this.name,
  });

  @override
  _SessionTypeViewState createState() => _SessionTypeViewState();
}

class _SessionTypeViewState extends State<SessionTypeView> {
  Future<SessionType> futureSessionType;

  @override
  void initState() {
    futureSessionType = SessionService.getSessionType(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: FutureBuilder(
              future: futureSessionType,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return StrongrText(
                    snapshot.data.description,
                    textAlign: TextAlign.justify,
                    maxLines: 512,
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error, textAlign: TextAlign.center);
                } else
                  return Container(
                    alignment: Alignment.center,
                    height: ScreenSize.height(context) / 1.25,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(StrongrColors.blue),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
