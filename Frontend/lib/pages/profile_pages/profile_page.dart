import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/no_animation_material_page_route.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  final String _firstName = "Maxime";
  final String _lastName = "Dubost";
  final String _status = "Coach sportif";
  //final String _bio = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.";

  Widget _buildCover(Size screenSize) {
    return Container(
      height: screenSize.height / 5,
      decoration: BoxDecoration(
        color: SecondaryColor,
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/default_user_img.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(80.0),
          border: Border.all(
            color: Colors.white,
            width: 4.0,
          ),
        ),
      ),
    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      color: PrimaryColor,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      _firstName + " " + _lastName,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        _status,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
    );
    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      // decoration: BoxDecoration(
      //   color: Color(0xFFEFF4F7),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Programmes", "3"),
          _buildStatItem("Séances", "5"),
        ],
      ),
    );
  }

  // Widget _buildBio(BuildContext context) {
  //   TextStyle bioTextStyle = TextStyle(
  //     fontWeight: FontWeight.w500,
  //     fontStyle: FontStyle.italic,
  //     color: Colors.grey,
  //     fontSize: 16.0,
  //   );
  //   return Container(
  //     color: Theme.of(context).scaffoldBackgroundColor,
  //     padding: EdgeInsets.all(20.0),
  //     child: Text(
  //       _bio,
  //       textAlign: TextAlign.center,
  //       style: bioTextStyle,
  //     ),
  //   );
  // }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: PrimaryColor,
      //margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildCategoryTitle(String categoryTitle) {
    TextStyle _categoryTitleTextStyle = TextStyle(
      color: PrimaryColor,
      fontSize: 22.0,
      fontWeight: FontWeight.w700,
    );

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(
        categoryTitle,
        style: _categoryTitleTextStyle,
      ),
    );
  }

  Widget _buildCategoryContent(BuildContext context) {
    TextStyle categoryContentTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic,
      color: Colors.grey,
      fontSize: 16.0,
    );
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.all(20.0),
      child: Text(
        "N/A",
        textAlign: TextAlign.center,
        style: categoryContentTextStyle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Profil"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            color: Colors.white,
            onPressed: () => Navigator.of(context).push(
                NoAnimationMaterialPageRoute(
                    builder: (BuildContext context) => EditProfilePage())),
          ),
        ],
        backgroundColor: PrimaryColor,
      ),
      body: Stack(
        children: <Widget>[
          //_buildCover(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _buildCover(screenSize),
                      Padding(
                        padding: EdgeInsets.only(top: screenSize.height / 10),
                        child: _buildProfileImage(),
                      )
                    ],
                  ),
                  _buildFullName(),
                  _buildStatus(context),
                  _buildStatContainer(),
                  _buildCategoryTitle("Statistiques"),
                  _buildSeparator(screenSize),
                  _buildCategoryContent(context),
                  _buildCategoryTitle("Objectifs"),
                  _buildSeparator(screenSize),
                  _buildCategoryContent(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
