import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/Muscle.dart';
import 'package:strongr/models/TargetMusclesByExercise.dart';
import 'package:strongr/services/ExerciseService.dart';

class SessionTypeDefinitor {
  static const String SPLIT_BODY = "Split body";
  static const String HALF_BODY = "Half body";
  static const String FULL_BODY = "Full body";
  static List<Muscle> upperMuscleGroup = [
    Muscle(id: 2, name: "Avant-bras"),
    Muscle(id: 3, name: "Biceps"),
    Muscle(id: 4, name: "Dos"),
    Muscle(id: 5, name: "Épaules"),
    Muscle(id: 8, name: "Pectoraux"),
    Muscle(id: 10, name: "Triceps"),
  ];
  static List<Muscle> lowerMuscleGroup = [
    Muscle(id: 1, name: "Abdominaux"),
    Muscle(id: 6, name: "Ischios"),
    Muscle(id: 7, name: "Mollets"),
    Muscle(id: 9, name: "Quadriceps"),
  ];

  static Future<String> ofExercises(List<ExercisePreview> exercises) async {
    List<int> exerciseIDs = List<int>();
    for (final item in exercises) exerciseIDs.add(item.id);
    List<ExerciseTargetMuscles> targetMusclesByExercises =
        await ExerciseService.targetMusclesByExercise(exerciseIDs);
    int count;
    Muscle splitedMuscle;

    // VÉRIFICATION DE LA REDONDANCE D'UN MUSCLE DANS TOUS LES EXERCICES

    // On boucle sur les muscles ciblés du premier exercice qui servirons de base pour comparer les autres
    for (Muscle muscle in targetMusclesByExercises[0].targetMuscles) {
      splitedMuscle = muscle;
      count = 0;
      // On boucle sur les exercices
      for (ExerciseTargetMuscles exercise in targetMusclesByExercises) {
        // On boucle sur les muscles ciblés de chaque exercice
        for (Muscle targetMuscle in exercise.targetMuscles) {
          // Si un muscle ciblé pas l'exercices correspond au muscle à comparer, on passe à l'exerice suivant
          if (muscle.id == targetMuscle.id) {
            count++;
            break;
          }
        }
      }
      if(count == targetMusclesByExercises.length)
      {
        print("Count : " + count.toString());
        print("Splited muscle : " + splitedMuscle.toString());
        print(SPLIT_BODY);
        return SPLIT_BODY;
      }
      
    }

    // CRÉATION D'UNE LISTE DES MUSCLES CIBLÉS PAR LES EXERCICES SANS DOUBLON

    List<Muscle> allMuscle = List<Muscle>();
    bool alreadyInserted = false;
    // On boucle sur les exercices
    for (ExerciseTargetMuscles exerciseTM in targetMusclesByExercises)
      // On boucle sur les muscles ciblés par l'exercice
      for (Muscle muscle in exerciseTM.targetMuscles) {
        // On boucle sur la liste sans doublon de muscles
        for (Muscle insertedMuscle in allMuscle) {
          // Si un élément de la liste sans doublon vaut l'élément qu'on veut insérer
          if (insertedMuscle == muscle) {
            // Élément déja inséré
            alreadyInserted = true;
            break;
          } else
            alreadyInserted = false;
        }
        // Si le muscle n'est pas déjà dans la liste sans doublon
        if (!alreadyInserted)
          // Ajout du muscle dans cette liste
          allMuscle.add(muscle);
      }

    // IDENTIFICATION DU GROUPE DE RÉFÉRENCE

    Muscle referenceMuscle = allMuscle[0];
    List<Muscle> referenceMuscleGroup = List<Muscle>();
    for (Muscle upperMuscle in upperMuscleGroup) 
      if (referenceMuscle == upperMuscle) {
        referenceMuscleGroup = upperMuscleGroup;
        break;
      }
    
    if (referenceMuscleGroup.length == 0) 
      referenceMuscleGroup = lowerMuscleGroup;
      
    // VÉRIFICATION DU GROUPE DE L'ENSEMBLE DES MUSCLES
    
    bool exists = false;
    // On boucle sur les muscles ciblés par tous les exercices
    for (Muscle muscle in allMuscle) {
      // On boucle sur les muscles de la liste de référence (haut ou bas du corps)
      for (Muscle referenceMuscleElement in referenceMuscleGroup) {
        // Si le muscle ciblé correspond à l'élément de la liste de référence
        if (referenceMuscleElement == muscle) {
          // On passe au muscle suivant
          exists = true;
          break;
        } else
          exists = false;
      }
      // Si aucun muscle ciblé ne correspond à aucun élément de la liste de référence
      if (!exists) {
        print(FULL_BODY);
        return FULL_BODY;
      }
    }
    print(HALF_BODY);
    return HALF_BODY;
  }
}
