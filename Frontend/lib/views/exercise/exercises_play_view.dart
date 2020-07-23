import 'package:flutter/material.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/widgets/strongr_text.dart';

import 'exercise_play_view.dart';

class ExercisesPlayView extends StatefulWidget {
  final List<Exercise> exercises;

  ExercisesPlayView({this.exercises});

  @override
  _ExercisesPlayViewState createState() => _ExercisesPlayViewState();
}

class _ExercisesPlayViewState extends State<ExercisesPlayView> {
  List<Exercise> exercises;
  int currentPage;
  PageController controller;
  PageView pageView;

  @override
  void initState() {
    exercises = widget.exercises;
    currentPage = 0;
    controller = PageController(initialPage: currentPage);
    pageView = PageView(
      physics: BouncingScrollPhysics(),
      controller: controller,
      children: [
        for (final item in exercises) ExercisePlayView(exercise: item),
      ],
      onPageChanged: (newPage) {
        setState(() {
          currentPage = newPage;
        });
      },
    );

    super.initState();
  }

  refreshStatus() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: pageView,
      bottomNavigationBar: exercises.length > 1
          ? buildBottomNavigationBar(itemCount: exercises.length)
          : null,
    );
  }

  Widget buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(90),
      child: SafeArea(
        child: Container(
          // color: Colors.blue[200],
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: StrongrColors.black,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            // title: Column(
            //   children: <Widget>[
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(25),
            //       child: Container(
            //         height: 25,
            //         child: LinearProgressIndicator(
            //           value: 0.35,
            //           valueColor:
            //               AlwaysStoppedAnimation<Color>(StrongrColors.blue),
            //           backgroundColor: StrongrColors.blue20,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            title: StrongrText(
              "Session name",
              bold: true,
            ),
            centerTitle: true,
            // bottom: PreferredSize(
            //   preferredSize: null,
            //   child: Column(
            //     children: <Widget>[
            //       Container(
            //         padding: EdgeInsets.only(bottom: 8),
            //         alignment: Alignment.center,
            //         child: StrongrText(
            //           "Progression : 35%",
            //           size: 18,
            //           color: Colors.grey,
            //           textAlign: TextAlign.start,
            //         ),
            //       ),
            //       Divider(
            //         thickness: 0.5,
            //         height: 0.5,
            //       ),
            //     ],
            //   ),
            // ),
            bottom: PreferredSize(
              preferredSize: null,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Container(
                      //   // color: Colors.red,
                      //   height: 25,
                      //   width: 50,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            height: 25,
                            width: ScreenSize.width(context) / 1.5,
                            child: LinearProgressIndicator(
                              value: 0.35,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  StrongrColors.blue),
                              backgroundColor: StrongrColors.blue20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: StrongrText("35%"),
                      ),
                    ],
                  ),
                  Divider(
                    height: 0.5,
                    thickness: 0.5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar({@required int itemCount}) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentPage,
      onTap: (index) {
        setState(() {
          currentPage = index;
        });
        controller.animateToPage(currentPage,
            duration: Duration(milliseconds: 200), curve: Curves.ease);
      },
      items: [
        for (int i = 1; i <= itemCount; i++)
          BottomNavigationBarItem(
            icon: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: i == 1
                    ? i == currentPage + 1
                        ? StrongrColors.blue
                        : StrongrColors.blue80
                    : i == currentPage + 1
                        ? StrongrColors.black80
                        : Colors.grey,
                border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(25.0),
                ),
              ),
              child: Center(
                child: StrongrText(
                  i.toString(),
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(""),
          ),
      ],
    );
  }
}
