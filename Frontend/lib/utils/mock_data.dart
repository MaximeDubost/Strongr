import 'package:strongr/models/AppExercise.dart';
import 'package:strongr/models/Equipment.dart';
import 'package:strongr/models/Exercise.dart';
import 'package:strongr/models/Set.dart';
import 'package:strongr/models/Status.dart';

class MockData {
  static final List<Exercise> exercise = [
    Exercise(
        status: Status.inProgress,
        id: 1,
        equipment: Equipment(id: 1, name: "Barre parallèles"),
        appExercise: AppExercise(
          id: 1,
          name: "Dips",
          equipmentList: [],
          muscleList: [],
        ),
        name: "Dips de la mort",
        sets: [
          Set(
            status: Status.inProgress,
            id: 1,
            place: 1,
            repetitionCount: 10,
            restTime: 90,
          ),
          Set(
            status: Status.waiting,
            id: 2,
            place: 2,
            repetitionCount: 10,
            restTime: 90,
          ),
          Set(
            status: Status.waiting,
            id: 3,
            place: 3,
            repetitionCount: 10,
            restTime: 90,
          ),
          Set(
            status: Status.waiting,
            id: 4,
            place: 4,
            repetitionCount: 10,
            restTime: 90,
          ),
        ]),
  ];

  static final List<Exercise> exerciseList = [
    Exercise(
        status: Status.inProgress,
        id: 1,
        appExercise: AppExercise(name: "Développé \"pec\""),
        name: "Mon développé couché",
        equipment: Equipment(name: "Développé couché"),
        sets: [
          Set(
            status: Status.inProgress,
            id: 1,
            place: 1,
            repetitionCount: 10,
            restTime: 90,
          ),
          Set(
            status: Status.waiting,
            id: 2,
            place: 2,
            repetitionCount: 8,
            restTime: 60,
          ),
          Set(
            status: Status.waiting,
            id: 3,
            place: 3,
            repetitionCount: 6,
            restTime: 45,
          ),
          Set(
            status: Status.waiting,
            id: 4,
            place: 4,
            repetitionCount: 4,
            restTime: 30,
          ),
        ]),
    Exercise(
        status: Status.waiting,
        id: 2,
        appExercise: AppExercise(
          name: "Squat"
        ),
        name: "Squat",
        sets: [
          Set(
            status: Status.waiting,
            id: 5,
            place: 1,
            repetitionCount: 20,
            restTime: 120,
          ),
          Set(
            status: Status.waiting,
            id: 6,
            place: 2,
            repetitionCount: 20,
            restTime: 120,
          ),
          Set(
            status: Status.waiting,
            id: 7,
            place: 3,
            repetitionCount: 20,
            restTime: 120,
          ),
          Set(
            status: Status.waiting,
            id: 8,
            place: 4,
            repetitionCount: 20,
            restTime: 120,
          ),
          Set(
            status: Status.waiting,
            id: 9,
            place: 5,
            repetitionCount: 20,
            restTime: 120,
          ),
        ]),
    Exercise(
        status: Status.waiting,
        id: 3,
        appExercise: AppExercise(
          name: "Tractions"
        ),
        name: "Tractions",
        equipment: Equipment(name: "Barre de tractions"),
        sets: [
          Set(
            status: Status.waiting,
            id: 10,
            place: 1,
            repetitionCount: 10,
            restTime: 30,
          ),
          Set(
            status: Status.waiting,
            id: 11,
            place: 2,
            repetitionCount: 10,
            restTime: 30,
          ),
          Set(
            status: Status.waiting,
            id: 12,
            place: 3,
            repetitionCount: 10,
            restTime: 30,
          ),
        ]),
    Exercise(
        status: Status.waiting,
        id: 4,
        appExercise: AppExercise(
          name: "Dips"
        ),
        name: "Dips de la mort",
        sets: [
          Set(
            status: Status.waiting,
            id: 13,
            place: 1,
            repetitionCount: 10,
            restTime: 60,
          ),
          Set(
            status: Status.waiting,
            id: 14,
            place: 2,
            repetitionCount: 10,
            restTime: 60,
          ),
          Set(
            status: Status.waiting,
            id: 15,
            place: 3,
            repetitionCount: 12,
            restTime: 30,
          ),
          Set(
            status: Status.waiting,
            id: 16,
            place: 4,
            repetitionCount: 12,
            restTime: 30,
          ),
        ]),
  ];
}
