import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/TargetMusclesByExercise.dart';
import 'package:strongr/services/ExerciseService.dart';

class SessionTypeDefinitor {
  static const String SPLIT_BODY = "Split body";
  static const String HALF_BODY = "Half body";
  static const String FULL_BODY = "Full body";
  static List<String> upperMuscleGroup = [
    "Abant-bras",
    "Biceps",
    "Dos",
    "Épaules",
    "Pectoraux",
    "Triceps"
  ];
  static List<String> lowerMuscleGroup = [
    "Abdominaux",
    "Ischios",
    "Mollets",
    "Quadriceps"
  ];

  static Future<String> ofExercises(List<ExercisePreview> exercises) async {
    List<int> exerciseIDs = List<int>();

    for (final item in exercises) exerciseIDs.add(item.id);

    List<ExerciseTargetMuscles> targetMusclesByExercises =
        await ExerciseService.targetMusclesByExercise(exerciseIDs);

    int count;
    bool nextMuscle;

    // On boucle les muscles ciblés du premier exercice qui servirons de base pour comparer les autres
    for (final muscle in targetMusclesByExercises[0].targetMuscles) {

      count = 0;
      nextMuscle = false;

      // On boucle sur les ETM
      for (final exerciseTM in targetMusclesByExercises) {
        // Pour chaque ETM, on boucle sur ses muscles ciblés
        for (final targetMuscle in exerciseTM.targetMuscles) {
          // Si le muscle ciblé correspond au muscle à comparer, on passe au muscle suivant
          if (muscle.id == targetMuscle.id) {
            count++;
            break;
          }
          if (exerciseTM.targetMuscles.indexOf(targetMuscle) + 1 ==
                  exerciseTM.targetMuscles.length &&
              count <
                  targetMusclesByExercises[0].targetMuscles.indexOf(muscle) +
                      1) {
            nextMuscle = true;
            break;
          }
        }
        if (nextMuscle) break;
      }
    }
    print(count);
    // if(count == targetMusclesByExercises[0].targetMuscles.length)
    

    // List<List> targetMuscles = List<List>();

    // for (final exercise in targetMusclesByExercise) {
    //   targetMuscles.add(List<Muscle>());
    //   for (final muscle in exercise.targetMuscles) {
    //     print("index : " + exercise.targetMuscles.indexOf(muscle).toString());
    //     targetMuscles[exercise.targetMuscles.indexOf(muscle)].add(muscle);
    //   }
    // }

    // print(targetMuscles);
    return FULL_BODY;
  }
}
