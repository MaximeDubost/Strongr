import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/utils/no_animation_material_page_route.dart';
import 'package:strongr/views/homepage_view.dart';

import 'routing_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  switch (settings.name) {

    // Loading

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