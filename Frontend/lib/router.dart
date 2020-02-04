import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'pages/others_pages/loading_page.dart';
import 'pages/connection_pages/connection_page.dart';
import 'pages/connection_pages/log_in_page.dart';
import 'pages/connection_pages/reset_password_page.dart';
import 'pages/connection_pages/sign_in_page.dart';
import 'pages/connection_pages/sign_in_second_page.dart';
import 'pages/others_pages/welcome_page.dart';
import 'pages/homepage.dart';
import 'pages/exercises_pages/exercise_page.dart';
import 'pages/exercises_pages/search_exercise.dart';
import 'pages/profile_pages/edit_profile_page.dart';
import 'pages/profile_pages/profile_page.dart';
import 'pages/programs_pages/add_session_page.dart';
import 'pages/programs_pages/create_program_page.dart';
import 'pages/programs_pages/program_page.dart';
import 'pages/sessions_pages/add_exercise_page.dart';
import 'pages/sessions_pages/create_session_page.dart';
import 'pages/sessions_pages/session_page.dart';
import 'pages/sessions_pages/set_exercise_page.dart';
import 'pages/settings_pages/about_settings_page.dart';
import 'pages/settings_pages/activity_settings_page.dart';
import 'pages/settings_pages/coach_settings_page.dart';
import 'pages/settings_pages/confidentiality_settings_page.dart';
import 'pages/settings_pages/general_settings_page.dart';
import 'pages/settings_pages/help_settings_page.dart';
import 'pages/settings_pages/notifications_settings_page.dart';
import 'pages/settings_pages/settings_page.dart';
import 'pages/others_pages/undefined_view.dart';

import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {

    // Loading

    case LoadingViewRoute:
      return CupertinoPageRoute(
        builder: (context) => LoadingPage(),
      );

    // Connection

    case ConnectionViewRoute:
      return CupertinoPageRoute(
        builder: (context) => ConnectionPage(),
      );

    case SignInViewRoute:
      return CupertinoPageRoute(
        builder: (context) => SignInPage(),
      );

    case SignInNextViewRoute:
      return CupertinoPageRoute(
        builder: (context) => SignInSecondPage(),
      );

    case LoginViewRoute:
      return CupertinoPageRoute(
        builder: (context) => LogInPage(),
      );

    case ResetPasswordViewRoute:
      return CupertinoPageRoute(
        builder: (context) => ResetPasswordPage(),
      );

    // Welcome & Homepage

    case WelcomeViewRoute:
      return CupertinoPageRoute(
        builder: (context) => WelcomePage(),
      );

    case HomepageViewRoute:
      return CupertinoPageRoute(
        builder: (context) => Homepage(),
      );

    // Exercise

    case ExerciseViewRoute:
      var exerciseName = settings.arguments;
      return CupertinoPageRoute(
        builder: (context) => ExercisePage(exerciseName: exerciseName),
      );

    case SearchExerciseViewRoute:
      return CupertinoPageRoute(
        builder: (context) => SearchExercisePage(),
      );

    // Session

    case SessionViewRoute:
      return CupertinoPageRoute(
        builder: (context) => SessionPage(""),
      );

    case CreateSessionViewRoute:
      return CupertinoPageRoute(
        builder: (context) => CreateSessionPage(),
      );

    case AddExerciseViewRoute:
      return CupertinoPageRoute(
        builder: (context) => AddExercisePage(),
      );

    case SetExerciseViewRoute:
      return CupertinoPageRoute(
        builder: (context) => SetExercisePage(""),
      );

    // Program

    case ProgramViewRoute:
      return CupertinoPageRoute(
        builder: (context) => ProgramPage(""),
      );

    case CreateProgramViewRoute:
      return CupertinoPageRoute(
        builder: (context) => CreateProgramPage(),
      );

    case AddSessionViewRoute:
      return CupertinoPageRoute(
        builder: (context) => AddSessionPage(),
      );

    // Profile

    case ProfileViewRoute:
      return CupertinoPageRoute(
        builder: (context) => ProfilePage(),
      );

    case EditProfileViewRoute:
      return CupertinoPageRoute(
        builder: (context) => EditProfilePage(),
      );

    // Settings

    case SettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => SettingsPage(),
      );

    case GeneralSettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => GeneralSettingsPage(),
      );

    case ActivitySettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => ActivitySettingsPage(),
      );

    case NotificationsSettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => NotificationsSettingsPage(),
      );

    case ConfidentialitySettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => ConfidentialitySettingsPage(),
      );

    case CoachSettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => CoachSettingsPage(),
      );

    case HelpSettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => HelpSettingsPage(),
      );

    case AboutSettingsViewRoute:
      return CupertinoPageRoute(
        builder: (context) => AboutSettingsPage(),
      );

    // UndefinedView
    default:
      return CupertinoPageRoute(
        builder: (context) => UndefinedView(
          name: settings.name,
        ),
      );
  }
}
