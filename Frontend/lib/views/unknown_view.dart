import 'package:flutter/material.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

class UnknownView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(30),
          child: Container(
            // padding: EdgeInsets.only(top: 30),
            child: Form(
              key: null,
              autovalidate: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            width: ScreenSize.width(context) / 1.7,
                            alignment: Alignment.center,
                            child: StrongrText(
                              "404",
                              size: 100,
                              color: StrongrColors.blue,
                            ),
                          ),
                        ),
                        Container(
                          child: BackButton(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  StrongrText("Page non trouvée", size: 30),
                  SizedBox(height: 50),
                  Image(
                    image: AssetImage('assets/strongr_404.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
