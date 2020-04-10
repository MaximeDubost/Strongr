import 'package:flutter/material.dart';
import 'package:strongr/utils/routing_constants.dart';
import 'package:strongr/utils/router.dart' as router;
import 'package:strongr/utils/strongr_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Strongr',
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('fr'), // French
        // ... other locales the app supports
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.blue,
        canvasColor: StrongrColors.canvas,
        primaryColor: StrongrColors.black,
        accentColor: StrongrColors.greyA,
        fontFamily: 'Futura',
      ),
      onGenerateRoute: router.generateRoute,
      initialRoute: LOG_IN_ROUTE,
    );
  }
}
