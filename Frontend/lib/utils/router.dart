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
import 'package:strongr/views/exercise/exercise_add_view.dart';
import 'package:strongr/views/exercise/exercise_create_view.dart';
import 'package:strongr/views/exercise/exercise_view.dart';
import 'package:strongr/views/exercise/exercises_view.dart';
import 'package:strongr/views/homepage/homepage_view.dart';
import 'package:strongr/views/program/program_create_view.dart';
import 'package:strongr/views/program/program_new_session.dart';
import 'package:strongr/views/program/program_view.dart';
import 'package:strongr/views/program/programs_view.dart';
import 'package:strongr/views/session/session_create_view.dart';
import 'package:strongr/views/session/session_new_exercise_view.dart';
import 'package:strongr/views/session/session_view.dart';
import 'package:strongr/views/session/sessions_view.dart';
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
      SignInView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) =>
            SignInNextView(email: args.email, password: args.password),
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
      ResetPasswordView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => RecoveryCodeView(email: args.email),
      );

    case NEW_PASSWORD_ROUTE:
      RecoveryCodeView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => NewPasswordView(email: args.email),
      );

    ///
    /// Accueil
    ///

    case HOMEPAGE_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => HomepageView(),
      );

    ///
    /// Exercice Application
    ///
    case APP_EXERCISE_ROUTE:
      AppExerciseView args = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => AppExerciseView(
          id: args.id,
          name: args.name,
          isBelonged: args.isBelonged,
          fromExercises: args.fromExercises,
        ),
      );

    ///
    /// Exercice(s)
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
    /// Séance(s)
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
    /// Programme(s)
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
    /// Page non trouvée
    ///
    default:
      return NoAnimationMaterialPageRoute(
        builder: (context) => UnknownView(),
      );
  }
}
