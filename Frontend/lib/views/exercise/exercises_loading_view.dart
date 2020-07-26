import 'package:flutter/material.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/Session.dart';
import 'package:strongr/route/routing_constants.dart';
import 'package:strongr/services/ExerciseService.dart';
import 'package:strongr/services/SessionService.dart';
import 'package:strongr/utils/global_widgets.dart';
import 'package:strongr/utils/strongr_colors.dart';
import 'package:strongr/views/exercise/exercises_play_view.dart';
import 'package:strongr/widgets/strongr_text.dart';

class ExercisesLoadingView extends StatelessWidget {
  final int exerciseId;
  final int sessionId;
  final String name;

  ExercisesLoadingView({
    this.exerciseId,
    this.sessionId,
    this.name,
  });

  Future<List<Exercise>> getExercises({
    int exerciseId,
    int sessionId,
  }) async {
    if (exerciseId != null)
      return [await ExerciseService.getExercise(id: exerciseId)];
    if (sessionId != null) {
      Session session = await SessionService.getSession(id: sessionId);
      List<Exercise> exercises = List<Exercise>();
      for (final exercise in session.exercises)
        exercises.add(await ExerciseService.getExercise(id: exercise.id));
      return exercises;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: StrongrColors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: getExercises(
          exerciseId: exerciseId,
          sessionId: sessionId,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child:
                    StrongrText("Une erreur est survenue lors du démarrage."),
              );
              break;
            case ConnectionState.done:
              if (snapshot.hasData)
                Future.delayed(
                    Duration(milliseconds: 300),
                    () => Navigator.popAndPushNamed(
                          context,
                          EXERCISES_PLAY_ROUTE,
                          arguments: ExercisesPlayView(
                            name: name,
                            exercises: snapshot.data,
                          ),
                        )
                    // Navigator.pushNamed(
                    //   context,
                    //   EXERCISES_PLAY_ROUTE,
                    //   arguments: ExercisesPlayView(
                    //     name: name,
                    //     exercises: snapshot.data,
                    //   ),
                    // ),
                    );
              if (snapshot.hasError)
                return GlobalWidgets.buildMessage(snapshot.error.toString());
              else
                return loading();
              break;
            default:
              return loading();
          }
        },
      ),
    );
  }

  Widget loading() {
    return Center(
      child: SizedBox(
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(StrongrColors.blue),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: StrongrText(
                "Chargement...",
                color: StrongrColors.blue,
                bold: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
