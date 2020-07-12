import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/utils/no_animation_material_page_route.dart';
import 'package:strongr/views/connection/log_in_view.dart';
import 'package:strongr/views/connection/new_password_view.dart';
import 'package:strongr/views/connection/recovery_code_view.dart';
import 'package:strongr/views/connection/reset_password_view.dart';
import 'package:strongr/views/connection/sign_in_next_view.dart';
import 'package:strongr/views/connection/sign_in_view.dart';
import 'package:strongr/views/app_exercise/app_exercise_view.dart';
import 'package:strongr/views/equipment/equipment_view.dart';
import 'package:strongr/views/equipment/equipments_view.dart';
import 'package:strongr/views/exercise/exercise_add_view.dart';
import 'package:strongr/views/exercise/exercise_create_view.dart';
import 'package:strongr/views/exercise/exercise_view.dart';
import 'package:strongr/views/exercise/exercises_view.dart';
import 'package:strongr/views/homepage/homepage_view.dart';
import 'package:strongr/views/muscle/muscle_view.dart';
import 'package:strongr/views/program/program_create_view.dart';
import 'package:strongr/views/program_goal/program_goal_view.dart';
import 'package:strongr/views/program/program_new_session.dart';
import 'package:strongr/views/program/program_view.dart';
import 'package:strongr/views/program/programs_view.dart';
import 'package:strongr/views/program_goal/program_goals_view.dart';
import 'package:strongr/views/session/session_create_view.dart';
import 'package:strongr/views/session/session_new_exercise_view.dart';
import 'package:strongr/views/session/session_view.dart';
import 'package:strongr/views/session/sessions_view.dart';
import 'package:strongr/views/session_type/session_type_view.dart';
import 'package:strongr/views/settings/settings_view.dart';
import 'package:strongr/views/unknown_view.dart';
import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    ///
    /// Connexion
    ///
    case SIGN_IN_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => SignInView(),
      );

    case SIGN_IN_NEXT_ROUTE:
      SignInNextView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => SignInNextView(
          email: args.email,
          password: args.password,
        ),
      );

    case LOG_IN_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => LogInView(),
      );

    case RESET_PASSWORD_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => ResetPasswordView(),
      );

    case RECOVERY_CODE_ROUTE:
      RecoveryCodeView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => RecoveryCodeView(
          email: args.email,
        ),
      );

    case NEW_PASSWORD_ROUTE:
      NewPasswordView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => NewPasswordView(
          email: args.email,
        ),
      );

    ///
    /// Accueil
    ///
    case HOMEPAGE_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => HomepageView(),
      );

    ///
    /// AppExercise
    ///
    case APP_EXERCISE_ROUTE:
      AppExerciseView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => AppExerciseView(
          id: args.id,
          name: args.name,
          isBelonged: args.isBelonged,
          fromExercises: args.fromExercises,
          selectedEquipmentId: args.selectedEquipmentId,
        ),
      );

    ///
    /// Exercise
    ///
    case EXERCISES_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => ExercisesView(),
      );

    case EXERCISE_ROUTE:
      ExerciseView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => ExerciseView(
          id: args.id,
          name: args.name,
          appExerciseName: args.appExerciseName,
          fromSession: args.fromSession,
          fromSessionCreation: args.fromSessionCreation,
        ),
      );

    case EXERCISE_ADD_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => ExerciseAddView(),
      );

    case EXERCISE_CREATE_ROUTE:
      ExerciseCreateView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => ExerciseCreateView(
          id: args.id,
          name: args.name,
        ),
      );

    ///
    /// Session
    ///
    case SESSIONS_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => SessionsView(),
      );

    case SESSION_ROUTE:
      SessionView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => SessionView(
          id: args.id,
          name: args.name,
          sessionTypeName: args.sessionTypeName,
          fromProgram: args.fromProgram,
          fromProgramCreation: args.fromProgramCreation,
        ),
      );

    case SESSION_CREATE_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => SessionCreateView(),
      );

    case SESSION_NEW_EXERCISE_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => SessionNewExerciseView(),
      );

    ///
    /// Program
    ///
    case PROGRAMS_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => ProgramsView(),
      );

    case PROGRAM_ROUTE:
      ProgramView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => ProgramView(
          id: args.id,
          name: args.name,
          programGoalName: args.programGoalName,
        ),
      );

    case PROGRAM_CREATE_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => ProgramCreateView(),
      );

    case PROGRAM_NEW_SESSION_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => ProgramNewSessionView(),
      );

    ///
    /// Session type
    ///
    case SESSION_TYPE_ROUTE:
      SessionTypeView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => SessionTypeView(
          id: args.id,
          name: args.name,
        ),
      );

    ///
    /// Program goal
    ///
    case PROGRAM_GOALS_ROUTE:
      ProgramGoalsView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => ProgramGoalsView(
          selectedProgramGoalId: args.selectedProgramGoalId,
        ),
      );

    case PROGRAM_GOAL_ROUTE:
      ProgramGoalView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => ProgramGoalView(
          id: args.id,
          name: args.name,
        ),
      );

    ///
    /// Muscle
    ///
    case MUSCLE_ROUTE:
      MuscleView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => MuscleView(
          id: args.id,
          name: args.name,
        ),
      );

    ///
    /// Equipment
    ///
    case EQUIPMENTS_ROUTE:
      EquipmentsView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => EquipmentsView(
          appExerciseId: args.appExerciseId,
          appExerciseName: args.appExerciseName,
          selectedEquipmentId: args.selectedEquipmentId,
        ),
      );

    case EQUIPMENT_ROUTE:
      EquipmentView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => EquipmentView(
          id: args.id,
          name: args.name,
        ),
      );

    ///
    /// Settings
    ///
    case SETTINGS_ROUTE:
      return CupertinoPageRoute(builder: (context) => SettingsView());

    ///
    /// UnknownView
    ///
    default:
      return NoAnimationMaterialPageRoute(
        builder: (context) => UnknownView(),
      );
  }
}
