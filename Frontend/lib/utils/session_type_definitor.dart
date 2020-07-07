import 'package:strongr/models/ExercisePreview.dart';
import 'package:strongr/models/Muscle.dart';
import 'package:strongr/models/SessionType.dart';
import 'package:strongr/models/TargetMusclesByExercise.dart';
import 'package:strongr/services/ExerciseService.dart';

class SessionTypeDefinitor {
  /// Split body : Si tous les exercices ont au moins un muscle ciblé en commun 
  static final SessionType _splitBody = SessionType(id: 1, name: "Split body");
  /// Half body : Si tous les exercices font partie du même groupe (Haut ou bas du corps)
  static final SessionType _halfBody = SessionType(id: 2, name: "Half body");
  /// Full body : Si la liste des exercices ne respecte pas les conditions du Split body et du Half body
  static final SessionType _fullBody = SessionType(id: 3, name: "Full body");
  /// Liste des muscles du haut du corps
  static List<Muscle> upperMuscleGroup = [
    Muscle(id: 2, name: "Avant-bras"),
    Muscle(id: 3, name: "Biceps"),
    Muscle(id: 4, name: "Dos"),
    Muscle(id: 5, name: "Épaules"),
    Muscle(id: 8, name: "Pectoraux"),
    Muscle(id: 10, name: "Triceps"),
  ];
  /// liste des muscles du bas du corps
  static List<Muscle> lowerMuscleGroup = [
    Muscle(id: 1, name: "Abdominaux"),
    Muscle(id: 6, name: "Ischios"),
    Muscle(id: 7, name: "Mollets"),
    Muscle(id: 9, name: "Quadriceps"),
  ];

  static Future<SessionType> defineByExercises(
      List<ExercisePreview> exercises) async {
    try {
      List<int> exerciseIDs = List<int>();
      for (final item in exercises) exerciseIDs.add(item.id);
      List<ExerciseTargetMuscles> targetMusclesByExercises =
          await ExerciseService.targetMusclesByExercise(exerciseIDs);
      int count;
      // Muscle splitedMuscle;

      // VÉRIFICATION DE LA REDONDANCE D'UN MUSCLE DANS TOUS LES EXERCICES

      // On boucle sur les muscles ciblés du premier exercice qui serviront de base pour comparer les autres
      for (Muscle muscle in targetMusclesByExercises[0].targetMuscles) {
        // splitedMuscle = muscle;
        count = 0;
        // On boucle sur les exercices
        for (ExerciseTargetMuscles exercise in targetMusclesByExercises) 
          // On boucle sur les muscles ciblés de chaque exercice
          for (Muscle targetMuscle in exercise.targetMuscles) 
            // Si un muscle ciblé pas l'exercices correspond au muscle à comparer, on passe à l'exerice suivant
            if (muscle.id == targetMuscle.id) {
              count++;
              break;
            }
        if (count == targetMusclesByExercises.length) 
          return _splitBody;
      }

      // CRÉATION D'UNE LISTE DES MUSCLES CIBLÉS PAR LES EXERCICES SANS DOUBLON

      List<Muscle> allMuscle = List<Muscle>();
      bool alreadyInserted = false;
      // On boucle sur les exercices
      for (ExerciseTargetMuscles exerciseTM in targetMusclesByExercises)
        // On boucle sur les muscles ciblés par l'exercice
        for (Muscle muscle in exerciseTM.targetMuscles) {
          // On boucle sur la liste sans doublon de muscles
          for (Muscle insertedMuscle in allMuscle)
            // Si un élément de la liste sans doublon vaut l'élément qu'on veut insérer
            if (insertedMuscle == muscle) {
              // Élément déja inséré
              alreadyInserted = true;
              break;
            } else
              alreadyInserted = false;
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
        for (Muscle referenceMuscleElement in referenceMuscleGroup)
          // Si le muscle ciblé correspond à l'élément de la liste de référence
          if (referenceMuscleElement == muscle) {
            // On passe au muscle suivant
            exists = true;
            break;
          } else
            exists = false;
        
        // Si aucun muscle ciblé ne correspond à aucun élément de la liste de référence
        if (!exists)
          return _fullBody;
      }
      return _halfBody;
    } catch (e) {
      return _splitBody;
    }
  }
}
