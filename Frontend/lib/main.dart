import 'package:flutter/material.dart';
import 'package:flutter_app_test/pages/loading_page.dart';

import 'pages/homepage.dart';


const PrimaryColor = Color.fromRGBO(40, 140, 100, 1.0);
const SecondaryColor = Color.fromRGBO(20, 120, 80, 1.0);
const DarkColor = Color.fromRGBO(0, 100, 60, 1.0);

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: new LoadingPage(),
    home: new Homepage(),
  ));
}