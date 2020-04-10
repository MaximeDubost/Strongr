import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:strongr/utils/screen_size.dart';
import 'package:strongr/widgets/strongr_rounded_container.dart';

class DebugZone extends StatefulWidget {
  @override
  _DebugZoneState createState() => _DebugZoneState();
}

class _DebugZoneState extends State<DebugZone> {
  PageController controller;
  int currentpage = 0;

  @override
  initState() {
    super.initState();
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.85,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: ScreenSize.height(context) / 5.5,
          child: PageView(
            physics: BouncingScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  currentpage = value;
                });
              },
              controller: controller,
              children: <Widget>[
                StrongrRoundedContainer(),
                StrongrRoundedContainer(),
                StrongrRoundedContainer(),
              ],
              // itemBuilder: (context, index) => builder(index)
          ),
        ),
      ),
    );
  }

  builder(int index) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * .8)).clamp(0.8, 1.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * ScreenSize.height(context) / 5.5,
            width: Curves.easeOut.transform(value) * ScreenSize.width(context),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8.0),
        color: Colors.grey
      ),
    );
  }
}