import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/utils/no_animation_material_page_route.dart';
import 'package:strongr/views/connection/log_in_view.dart';
import 'package:strongr/views/connection/sign_in_next_view.dart';
import 'package:strongr/views/connection/sign_in_view.dart';
import 'package:strongr/views/homepage_view.dart';

import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {

    case SIGN_IN_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => SignInView(),
      );

    case SIGN_IN_NEXT_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => SignInNextView(),
      );

    case LOG_IN_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => LogInView(),
      );

    case HOMEPAGE_ROUTE:
      return CupertinoPageRoute(
        builder: (context) => HomepageView(),
      );

    default:
      return NoAnimationMaterialPageRoute(
        builder: (context) => Scaffold(body: Center(child: Text("Unknown view"))),
      );
  }
}