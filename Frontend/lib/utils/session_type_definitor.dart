import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/Muscle.dart';
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
    List<TargetMusclesByExercise> targetMusclesByExercise =
        await ExerciseService.targetMusclesByExercise(exerciseIDs);

    List<List<Muscle>> targetMuscles = List<List<Muscle>>();
    for (final exercise in targetMusclesByExercise) {
      targetMuscles.add(List<Muscle>());
      for (final muscle in exercise.targetMuscles)
        targetMuscles[exercise.targetMuscles.indexOf(muscle)].add(muscle);
    }
    
    return FULL_BODY;
  }
}
